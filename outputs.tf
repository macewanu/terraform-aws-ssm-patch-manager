output "install_task_patch_group_id" {
  description = "SSM Patch Manager install patch group ID"
  value       = one(aws_ssm_patch_group.install_task_patch_group[*])
}

output "install_task_maintenance_window_id" {
  description = "SSM Patch Manager install maintenance window ID"
  value       = one(aws_ssm_maintenance_window.install_task_window[*].id)
}

output "install_task_maintenance_window_instances_target_id" {
  description = "SSM Patch Manager install maintenance window instances target ID"
  value       = one(aws_ssm_maintenance_window_target.install_task_instance_targets[*].id)
}

output "install_task_maintenance_window_resource_groups_target_id" {
  description = "SSM Patch Manager scan maintenance window resource groups target ID"
  value       = one(aws_ssm_maintenance_window_target.install_task_resource_group_targets[*].id)
}

output "install_task_maintenance_window_task_id" {
  description = "SSM Patch Manager install maintenance windows task ID"
  value       = one(aws_ssm_maintenance_window_task.install_task_window_task[*].id)
}

output "patch_baseline_arn" {
  description = "SSM Patch Manager patch baseline ARN"
  value       = one(aws_ssm_patch_baseline.baseline[*].arn)
}

output "scan_task_patch_group_id" {
  description = "SSM Patch Manager scan patch group ID"
  value       = one(aws_ssm_patch_group.scan_task_patch_group[*])
}

output "scan_task_maintenance_window_id" {
  description = "SSM Patch Manager install maintenance window ID"
  value       = one(aws_ssm_maintenance_window.scan_task_window[*].id)
}

output "scan_task_maintenance_window_instances_target_id" {
  description = "SSM Patch Manager scan maintenance window instances target ID"
  value       = one(aws_ssm_maintenance_window_target.scan_task_instance_targets[*].id)
}

output "scan_task_maintenance_window_resource_groups_target_id" {
  description = "SSM Patch Manager scan maintenance window resource groups target ID"
  value       = one(aws_ssm_maintenance_window_target.scan_task_resource_group_targets[*].id)
}

output "scan_task_maintenance_window_task_id" {
  description = "SSM Patch Manager scan maintenance windows task ID"
  value       = one(aws_ssm_maintenance_window_task.scan_task_window_task[*].id)
}
