# Defines variables specifically used by `scan-task.tf`.

variable "scan_task_cloudwatch_log_group_name" {
  default     = "/aws/ssm/scan"
  description = <<EOF
The name of the CloudWatch log group to ship logs to for the scan task.

Only relevant when both `cloudwatch_logging_enabled` and `scan_task_enabled`
are true.
EOF
  type        = string
}

variable "scan_task_enabled" {
  default     = false
  description = "If true, the `scan` task will be created and enabled."
  type        = bool
}

variable "scan_task_maintenance_window_cutoff" {
  default     = 1
  description = <<EOF
The number of hours before the end of the Maintenance Window that Systems Manager stops
scheduling new tasks for execution.

Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true.
EOF
  type        = number
}

variable "scan_task_maintenance_window_duration" {
  default     = 3
  description = <<EOF
The duration of the maintenence window for the `scan` task (in hours).

Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true.
EOF
  type        = number
}

variable "scan_task_maintenance_window_enabled" {
  default     = true
  description = <<EOF
If true, a maintenance window for the `scan` task will be created.

Only relevant when `scan_task_enabled` is true.
EOF
  type        = bool
}

variable "scan_task_maintenance_window_schedule" {
  default     = null
  description = <<EOF
The schedule of the maintenance window for the `scan` task, expressed as
a cron.

Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true.
EOF
  type        = string
}

variable "scan_task_priority" {
  default     = 1
  description = <<EOF
The priority of the `scan` task in the maintenance window. The lower the number, the
higher the priority.

Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true.
EOF
  type        = number
}

variable "scan_task_s3_output_prefix" {
  default     = "scan"
  description = <<EOF
The path prefix within the S3 bucket to use for `scan` task logs.

Only relevant when both `scan_task_enabled` and `s3_logging_enabled` are true.
EOF
  type        = string
}

variable "scan_task_sns_notifications_enabled" {
  default     = false
  description = <<EOF
If true, enable SNS notifications for the `scan` task.

Only relevant when `scan_task_enabled` is true.
EOF
  type        = bool
}
