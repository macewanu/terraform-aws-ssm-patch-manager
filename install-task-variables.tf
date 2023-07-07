# Defines variables specifically used by `install-task.tf`.

variable "install_task_cloudwatch_log_group_name" {
  default     = "/aws/ssm/install"
  description = <<EOF
The name of the CloudWatch log group to ship logs to for the install task.

Only relevant when `cloudwatch_logging_enabled`, `install_task_enabled`,
and `install_task_maintenance_window_enabled` are all true.
EOF
  type        = string
}

variable "install_task_enabled" {
  default     = true
  description = "If true, the `install` task will be created and enabled."
  type        = bool
}

variable "install_task_maintenance_window_enabled" {
  default     = true
  description = <<EOF
If true, create a maintenance window for the `install` task.

Only relevant when `install_task_enabled` is true.
EOF
  type        = bool
}

variable "install_task_maintenance_window_cutoff" {
  description = <<EOF
The number of hours before the end of the Maintenance Window that Systems Manager stops
scheduling new tasks for execution.

Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true.
EOF
  type        = number
  default     = 1
}

variable "install_task_maintenance_window_duration" {
  default     = 3
  description = <<EOF
The duration of the maintenence window for the `install` task (in hours).

Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true.
EOF
  type        = number
}

variable "install_task_maintenance_window_schedule" {
  default     = null
  description = <<EOF
The schedule of the maintenance window for the `install` task, expressed as
a cron.

Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true.
EOF
  type        = string
}

variable "install_task_priority" {
  default     = 1
  description = <<EOF
The priority of the `install` task in the maintenance window. The lower the number, the
higher the priority.

Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true.
EOF
  type        = number
}

variable "install_task_s3_output_prefix" {
  default     = "install"
  description = <<EOF
The path prefix within the S3 bucket to use for the `install` task logs.

Only relevant when `install_task_enabled`, `install_task_maintenance_window_enabled`,
and `s3_logging_enabled` are all true.
EOF
  type        = string
}

variable "install_task_sns_notifications_enabled" {
  default     = false
  description = <<EOF
If true, enable SNS notifications for the `install` task.

Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true.
EOF
  type        = bool
}
