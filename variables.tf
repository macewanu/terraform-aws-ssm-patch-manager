variable "approved_patches" {
  default     = []
  description = "A list of explicitly approved patches for the baseline."
  type        = list(string)
}

variable "approved_patches_compliance_level" {
  default     = "HIGH"
  description = <<EOF
Defines the compliance level for approved patches. 

This means that if an approved patch is reported as missing, this is the severity of the compliance 
violation.
EOF
  type        = string
}

variable "cloudwatch_logging_enabled" {
  default     = true
  description = "If true, ship patch logs to CloudWatch."
  type        = bool
}

variable "max_concurrency" {
  default     = 20
  description = "The maximum number of targets this task can be run for in parallel"
  type        = number
}

variable "max_errors" {
  default     = 50
  description = "The maximum number of errors allowed before this task stops being scheduled"
  type        = number
}

variable "operating_system" {
  description = <<EOF
Defines the operating system the patch baseline can be applied to.

See the `ssm_patch_baseline` resource definition for supported values.
EOF
  type        = string
}

variable "patch_baseline_application_approval_rules" {
  default     = {}
  description = "Approval rules for Application patches."
  type = map(object({
    approve_after_days  = number
    compliance_level    = string
    enable_non_security = bool
    filters = map(object({
      name   = string
      values = list(string)
    }))
  }))
}

variable "patch_baseline_os_approval_rules" {
  default     = {}
  description = "Approval rules for Operating System patches."
  type = map(object({
    approve_after_days  = number
    compliance_level    = string
    enable_non_security = bool
    filters = map(object({
      name   = string
      values = list(string)
    }))
  }))
}

variable "patch_baseline_description" {
  default     = ""
  description = "Description for the patch baseline."
  type        = string
}

variable "reboot_option" {
  default     = "RebootIfNeeded"
  description = <<EOF
When you choose the RebootIfNeeded option, the instance is rebooted if
Patch Manager installed new patches, or if it detected any patches with
a status of INSTALLED_PENDING_REBOOT during the Install operation.

Possible values : RebootIfNeeded, NoReboot
EOF
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "rejected_patches" {
  default     = []
  description = "A list of explicitly rejected patches for the baseline."
  type        = list(string)
}

variable "s3_logging_bucket_id" {
  default     = null
  description = <<EOF
The bucket ID to use for the task logs.

Only relevant when `s3_logging_enabled` is true.
EOF
  type        = string
}

variable "s3_logging_enabled" {
  default     = false
  description = "If true, ship task logs to an S3 bucket."
  type        = bool
}

variable "service_role_arn" {
  default     = null
  description = <<EOF
The role that should be assumed when executing the tasks.

If a role is not provided, Systems Manager uses your account's service-linked role.
If no service-linked role for Systems Manager exists in your account, it is created for you
EOF
  type        = string
}

variable "sns_notifications_role_arn" {
  default     = ""
  description = <<EOF
The ARN of the IAM role that will be used to push task status changes to the SNS topic
specified by `notification_arn`.
EOF
  type        = string
}

variable "sns_notifications_topic_arn" {
  default     = ""
  description = <<EOF
The ARN of the SNS topic that task status changes will be pushed to.
EOF
  type        = string
}

variable "sns_notifications_events" {
  default     = ["All"]
  description = <<EOF
The different events for which you can receive notifications.

Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed.
EOF
  type        = list(string)
}

variable "sns_notifications_type" {
  default     = "Command"
  description = <<EOF
When specified with Command, receive notification when the status of a command changes.
When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis
when the status of a command changes. Valid values: Command and Invocation.
EOF
  type        = string
}

variable "target_instance_ids" {
  default     = []
  description = <<EOF
The IDs of instances to register as targets for the created maintenance window(s).
EOF
  type        = set(string)
}

variable "target_instance_tags" {
  default     = {}
  description = <<EOF
A map of instance tag names to their values to register as targets for the created maintenance window(s).

Note that in the case of the `Patch Group` tag,
the `patch_group_targets` variable should be used instead of this one (for that tag only).
EOF
  type        = map(set(string))
}

variable "target_patch_groups" {
  default     = []
  description = <<EOF
The instances to register as targets for the created maintenance window(s) based
on the value of their `Patch Group` tag.
EOF
  type        = set(string)
}

variable "target_resource_groups" {
  default     = {}
  description = "A map of resource group keys to their values to register as targets for the created maintenance window(s)."
  type        = map(set(string))
}