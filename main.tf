locals {
  is_windows = var.operating_system == "WINDOWS"
}

resource "aws_ssm_patch_baseline" "baseline" {
  count = module.this.enabled ? 1 : 0

  name             = module.this.id
  description      = var.patch_baseline_description
  operating_system = var.operating_system

  approved_patches                  = var.approved_patches
  approved_patches_compliance_level = var.approved_patches_compliance_level
  rejected_patches                  = var.rejected_patches

  # Operating System Approval Rules
  dynamic "approval_rule" {
    for_each = var.patch_baseline_os_approval_rules

    content {
      approve_after_days  = approval_rule.value.approve_after_days
      compliance_level    = approval_rule.value.compliance_level
      enable_non_security = local.is_windows ? false : approval_rule.value.enable_non_security

      dynamic "patch_filter" {
        for_each = local.is_windows ? ["true"] : []

        content {
          key    = "PATCH_SET"
          values = ["OS"]
        }
      }

      # https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-patch-properties.html
      dynamic "patch_filter" {
        for_each = approval_rule.value.filters

        content {
          key    = patch_filter.value.name
          values = patch_filter.value.values
        }
      }
    }
  }

  # Application Approval Rules
  # Currently only applicable with a Windows OS.
  dynamic "approval_rule" {
    for_each = local.is_windows ? var.patch_baseline_application_approval_rules : {}

    content {
      approve_after_days  = approval_rule.value.approve_after_days
      compliance_level    = approval_rule.value.compliance_level
      enable_non_security = false # Windows does not support this.

      patch_filter {
        key    = "PATCH_SET"
        values = ["APPLICATION"]
      }

      # https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-patch-properties.html
      dynamic "patch_filter" {
        for_each = approval_rule.value.filters

        content {
          key    = patch_filter.value.name
          values = patch_filter.value.values
        }
      }
    }
  }

  tags = module.this.tags
}
