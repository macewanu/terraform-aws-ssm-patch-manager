module "scan_window_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled    = local.enabled
  attributes = ["scan-window"]
  context    = module.this.context
}

resource "aws_ssm_maintenance_window" "scan_window" {
  count    = local.enabled ? 1 : 0

  name     = module.scan_window_label.id
  schedule = var.scan_maintenance_window_schedule
  duration = var.scan_maintenance_window_duration
  cutoff   = var.scan_maintenance_window_cutoff

  tags = module.this.tags
}

resource "aws_ssm_maintenance_window_task" "task_scan_patches" {
  count            = local.enabled ? 1 : 0
  window_id        = aws_ssm_maintenance_window.scan_window[0].id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = var.task_scan_priority
  service_role_arn = var.service_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key    = "WindowTargetIds"
    values = aws_ssm_maintenance_window_target.target_scan.*.id
  }

  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Scan"]
      }
      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }

      output_s3_bucket     = var.s3_logging_enabled ? local.bucket_id : null
      output_s3_key_prefix = var.s3_logging_enabled ? var.s3_scanning_task_output_prefix : null

      service_role_arn     = var.sns_notification_role_arn

      dynamic "cloudwatch_config" {
        for_each = var.cloudwatch_logging_enabled ? ["true"] : []
        
        content {
          cloudwatch_log_group_name = var.cloudwatch_scanning_task_log_group_name
          cloudwatch_output_enabled = true
        }
      }

      dynamic "notification_config" {
        for_each = var.scan_sns_notification_enabled ? [1] : []
        content {
          notification_arn    = var.notification_arn
          notification_events = var.notification_events
          notification_type   = var.notification_type
        }
      }
    }
  }
}

resource "aws_ssm_maintenance_window_target" "target_scan" {
  count         = local.enabled ? 1 : 0
  window_id     = aws_ssm_maintenance_window.scan_window[0].id
  resource_type = "INSTANCE"

  dynamic "targets" {
    for_each = toset(var.scan_maintenance_windows_targets)
    content {
      key    = targets.value.key
      values = targets.value.values
    }
  }

  dynamic "targets" {
    for_each = length(var.scan_maintenance_windows_targets) == 0 ? [1] : []
    content {
      key    = "tag:Patch Group"
      values = var.scan_patch_groups
    }
  }
}
