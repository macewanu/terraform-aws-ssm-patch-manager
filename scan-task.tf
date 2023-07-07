# Creates the resource required for the `scan` task.

locals {
  scan_task_enabled                    = module.this.enabled && var.scan_task_enabled
  scan_task_maintenance_window_enabled = local.scan_task_enabled && var.scan_task_maintenance_window_enabled
}

resource "aws_ssm_patch_group" "scan_task_patch_group" {
  for_each = module.scan_task_window_label.enabled ? var.target_patch_groups : toset([])

  baseline_id = aws_ssm_patch_baseline.baseline[0].id
  patch_group = each.value
}

module "scan_task_window_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  enabled    = local.scan_task_maintenance_window_enabled
  attributes = ["scan-window"]
  context    = module.this.context
}

resource "aws_ssm_maintenance_window" "scan_task_window" {
  count = local.scan_task_maintenance_window_enabled ? 1 : 0

  name     = module.scan_task_window_label.id
  schedule = var.scan_task_maintenance_window_schedule
  duration = var.scan_task_maintenance_window_duration
  cutoff   = var.scan_task_maintenance_window_cutoff

  tags = module.this.tags
}

resource "aws_ssm_maintenance_window_target" "scan_task_instance_targets" {
  count = (local.scan_task_maintenance_window_enabled && (
    length(var.target_instance_ids) > 0
    || length(var.target_instance_tags) > 0
    || length(var.target_patch_groups) > 0
    )
  ) ? 1 : 0

  window_id     = aws_ssm_maintenance_window.scan_task_window[0].id
  resource_type = "INSTANCE"

  # Targets by Instance ID(s).
  dynamic "targets" {
    for_each = length(var.target_instance_ids) > 0 ? ["true"] : []

    content {
      key    = "InstanceIds"
      values = var.target_instance_ids
    }
  }

  # Targets by Tag(s).
  dynamic "targets" {
    for_each = var.target_instance_tags

    content {
      key    = each.key
      values = each.value
    }
  }

  # Targets by 'Patch Group' Tag.
  dynamic "targets" {
    for_each = length(var.target_patch_groups) > 0 ? ["true"] : []

    content {
      key    = "tag:Patch Group"
      values = var.target_patch_groups
    }
  }
}

resource "aws_ssm_maintenance_window_target" "scan_task_resource_group_targets" {
  count = (local.scan_task_maintenance_window_enabled &&
    length(var.target_resource_groups) > 0
  ) ? 1 : 0

  window_id     = aws_ssm_maintenance_window.scan_task_window[0].id
  resource_type = "RESOURCE_GROUP"

  dynamic "targets" {
    for_each = var.target_resource_groups

    content {
      key    = each.key
      values = each.value
    }
  }
}

resource "aws_ssm_maintenance_window_task" "scan_task_window_task" {
  count = local.scan_task_maintenance_window_enabled ? 1 : 0

  window_id        = aws_ssm_maintenance_window.scan_task_window[0].id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = var.scan_task_priority
  service_role_arn = var.service_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key = "WindowTargetIds"
    values = compact([
      one(aws_ssm_maintenance_window_target.scan_task_instance_targets[*].id),
      one(aws_ssm_maintenance_window_target.scan_task_resource_group_targets[*].id)
    ])
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

      output_s3_bucket     = var.s3_logging_enabled ? var.s3_logging_bucket_id : null
      output_s3_key_prefix = var.s3_logging_enabled ? var.install_task_s3_output_prefix : null

      service_role_arn = var.sns_notifications_role_arn

      dynamic "cloudwatch_config" {
        for_each = var.cloudwatch_logging_enabled ? ["true"] : []

        content {
          cloudwatch_log_group_name = var.scan_task_cloudwatch_log_group_name
          cloudwatch_output_enabled = true
        }
      }

      dynamic "notification_config" {
        for_each = var.scan_task_sns_notifications_enabled ? ["true"] : []

        content {
          notification_arn    = var.sns_notifications_topic_arn
          notification_events = var.sns_notifications_events
          notification_type   = var.sns_notifications_type
        }
      }
    }
  }
}


