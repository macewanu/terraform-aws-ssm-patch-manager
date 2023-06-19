locals {
  enabled = module.this.enabled
}

data "aws_caller_identity" "current" {
  count = local.enabled ? 1 : 0
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

resource "aws_ssm_patch_baseline" "baseline" {
  count            = local.enabled ? 1 : 0
  name             = "${module.this.id}-${var.operating_system}"
  description      = "${var.operating_system} baseline"
  operating_system = var.operating_system

  approved_patches                  = var.approved_patches
  rejected_patches                  = var.rejected_patches
  approved_patches_compliance_level = var.approved_patches_compliance_level

  dynamic "approval_rule" {
    for_each = var.patch_baseline_approval_rules

    content {
      approve_after_days  = approval_rule.value.approve_after_days
      compliance_level    = approval_rule.value.compliance_level
      enable_non_security = approval_rule.value.enable_non_security

      # https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-patch-properties.html
      dynamic "patch_filter" {
        for_each = approval_rule.value.patch_baseline_filters

        content {
          key    = patch_filter.value.name
          values = patch_filter.value.values
        }
      }
    }
  }

  tags = module.this.tags
}

resource "aws_ssm_patch_group" "install_patchgroup" {
  count       = (local.enabled ? 1 : 0) * length(var.install_patch_groups)
  baseline_id = aws_ssm_patch_baseline.baseline[0].id
  patch_group = element(var.install_patch_groups, count.index)
}

resource "aws_ssm_patch_group" "scan_patchgroup" {
  count       = (local.enabled ? 1 : 0) * length(var.scan_patch_groups)
  baseline_id = aws_ssm_patch_baseline.baseline[0].id
  patch_group = element(var.scan_patch_groups, count.index)
}
