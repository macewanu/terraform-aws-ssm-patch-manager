# Module: `terraform-aws-ssm-patch-manager`

This module provisions AWS SSM Patch manager maintenance window tasks, targets, patch baselines
and patch groups.

## Usage

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_install_task_window_label"></a> [install\_task\_window\_label](#module\_install\_task\_window\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_scan_task_window_label"></a> [scan\_task\_window\_label](#module\_scan\_task\_window\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window.install_task_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window.scan_task_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window_target.install_task_instance_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.install_task_resource_group_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.scan_task_instance_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.scan_task_resource_group_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_task.install_task_window_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_maintenance_window_task.scan_task_window_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_patch_baseline.baseline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |
| [aws_ssm_patch_group.install_task_patch_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_group) | resource |
| [aws_ssm_patch_group.scan_task_patch_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_approved_patches"></a> [approved\_patches](#input\_approved\_patches) | A list of explicitly approved patches for the baseline. | `list(string)` | `[]` | no |
| <a name="input_approved_patches_compliance_level"></a> [approved\_patches\_compliance\_level](#input\_approved\_patches\_compliance\_level) | Defines the compliance level for approved patches. <br><br>This means that if an approved patch is reported as missing, this is the severity of the compliance <br>violation. | `string` | `"HIGH"` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_logging_enabled"></a> [cloudwatch\_logging\_enabled](#input\_cloudwatch\_logging\_enabled) | If true, ship patch logs to CloudWatch. | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_install_task_cloudwatch_log_group_name"></a> [install\_task\_cloudwatch\_log\_group\_name](#input\_install\_task\_cloudwatch\_log\_group\_name) | The name of the CloudWatch log group to ship logs to for the install task.<br><br>Only relevant when `cloudwatch_logging_enabled`, `install_task_enabled`,<br>and `install_task_maintenance_window_enabled` are all true. | `string` | `"/aws/ssm/install"` | no |
| <a name="input_install_task_enabled"></a> [install\_task\_enabled](#input\_install\_task\_enabled) | If true, the `install` task will be created and enabled. | `bool` | `true` | no |
| <a name="input_install_task_maintenance_window_cutoff"></a> [install\_task\_maintenance\_window\_cutoff](#input\_install\_task\_maintenance\_window\_cutoff) | The number of hours before the end of the Maintenance Window that Systems Manager stops<br>scheduling new tasks for execution.<br><br>Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true. | `number` | `1` | no |
| <a name="input_install_task_maintenance_window_duration"></a> [install\_task\_maintenance\_window\_duration](#input\_install\_task\_maintenance\_window\_duration) | The duration of the maintenence window for the `install` task (in hours).<br><br>Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true. | `number` | `3` | no |
| <a name="input_install_task_maintenance_window_enabled"></a> [install\_task\_maintenance\_window\_enabled](#input\_install\_task\_maintenance\_window\_enabled) | If true, create a maintenance window for the `install` task.<br><br>Only relevant when `install_task_enabled` is true. | `bool` | `true` | no |
| <a name="input_install_task_maintenance_window_schedule"></a> [install\_task\_maintenance\_window\_schedule](#input\_install\_task\_maintenance\_window\_schedule) | The schedule of the maintenance window for the `install` task, expressed as<br>a cron.<br><br>Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true. | `string` | `null` | no |
| <a name="input_install_task_priority"></a> [install\_task\_priority](#input\_install\_task\_priority) | The priority of the `install` task in the maintenance window. The lower the number, the<br>higher the priority.<br><br>Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true. | `number` | `1` | no |
| <a name="input_install_task_s3_output_prefix"></a> [install\_task\_s3\_output\_prefix](#input\_install\_task\_s3\_output\_prefix) | The path prefix within the S3 bucket to use for the `install` task logs.<br><br>Only relevant when `install_task_enabled`, `install_task_maintenance_window_enabled`,<br>and `s3_logging_enabled` are all true. | `string` | `"install"` | no |
| <a name="input_install_task_sns_notifications_enabled"></a> [install\_task\_sns\_notifications\_enabled](#input\_install\_task\_sns\_notifications\_enabled) | If true, enable SNS notifications for the `install` task.<br><br>Only relevant when both `install_task_enabled` and `install_task_maintenance_window_enabled` are true. | `bool` | `false` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | The maximum number of targets this task can be run for in parallel | `number` | `20` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | The maximum number of errors allowed before this task stops being scheduled | `number` | `50` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | Defines the operating system the patch baseline can be applied to.<br><br>See the `ssm_patch_baseline` resource definition for supported values. | `string` | n/a | yes |
| <a name="input_patch_baseline_application_approval_rules"></a> [patch\_baseline\_application\_approval\_rules](#input\_patch\_baseline\_application\_approval\_rules) | Approval rules for Application patches. | <pre>map(object({<br>    approve_after_days  = number<br>    compliance_level    = string<br>    enable_non_security = bool<br>    filters = map(object({<br>      name   = string<br>      values = list(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_patch_baseline_description"></a> [patch\_baseline\_description](#input\_patch\_baseline\_description) | Description for the patch baseline. | `string` | `""` | no |
| <a name="input_patch_baseline_os_approval_rules"></a> [patch\_baseline\_os\_approval\_rules](#input\_patch\_baseline\_os\_approval\_rules) | Approval rules for Operating System patches. | <pre>map(object({<br>    approve_after_days  = number<br>    compliance_level    = string<br>    enable_non_security = bool<br>    filters = map(object({<br>      name   = string<br>      values = list(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_reboot_option"></a> [reboot\_option](#input\_reboot\_option) | When you choose the RebootIfNeeded option, the instance is rebooted if<br>Patch Manager installed new patches, or if it detected any patches with<br>a status of INSTALLED\_PENDING\_REBOOT during the Install operation.<br><br>Possible values : RebootIfNeeded, NoReboot | `string` | `"RebootIfNeeded"` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | A list of explicitly rejected patches for the baseline. | `list(string)` | `[]` | no |
| <a name="input_s3_logging_bucket_id"></a> [s3\_logging\_bucket\_id](#input\_s3\_logging\_bucket\_id) | The bucket ID to use for the task logs.<br><br>Only relevant when `s3_logging_enabled` is true. | `string` | `null` | no |
| <a name="input_s3_logging_enabled"></a> [s3\_logging\_enabled](#input\_s3\_logging\_enabled) | If true, ship task logs to an S3 bucket. | `bool` | `false` | no |
| <a name="input_scan_task_cloudwatch_log_group_name"></a> [scan\_task\_cloudwatch\_log\_group\_name](#input\_scan\_task\_cloudwatch\_log\_group\_name) | The name of the CloudWatch log group to ship logs to for the scan task.<br><br>Only relevant when both `cloudwatch_logging_enabled` and `scan_task_enabled`<br>are true. | `string` | `"/aws/ssm/scan"` | no |
| <a name="input_scan_task_enabled"></a> [scan\_task\_enabled](#input\_scan\_task\_enabled) | If true, the `scan` task will be created and enabled. | `bool` | `false` | no |
| <a name="input_scan_task_maintenance_window_cutoff"></a> [scan\_task\_maintenance\_window\_cutoff](#input\_scan\_task\_maintenance\_window\_cutoff) | The number of hours before the end of the Maintenance Window that Systems Manager stops<br>scheduling new tasks for execution.<br><br>Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true. | `number` | `1` | no |
| <a name="input_scan_task_maintenance_window_duration"></a> [scan\_task\_maintenance\_window\_duration](#input\_scan\_task\_maintenance\_window\_duration) | The duration of the maintenence window for the `scan` task (in hours).<br><br>Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true. | `number` | `3` | no |
| <a name="input_scan_task_maintenance_window_enabled"></a> [scan\_task\_maintenance\_window\_enabled](#input\_scan\_task\_maintenance\_window\_enabled) | If true, a maintenance window for the `scan` task will be created.<br><br>Only relevant when `scan_task_enabled` is true. | `bool` | `true` | no |
| <a name="input_scan_task_maintenance_window_schedule"></a> [scan\_task\_maintenance\_window\_schedule](#input\_scan\_task\_maintenance\_window\_schedule) | The schedule of the maintenance window for the `scan` task, expressed as<br>a cron.<br><br>Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true. | `string` | `null` | no |
| <a name="input_scan_task_priority"></a> [scan\_task\_priority](#input\_scan\_task\_priority) | The priority of the `scan` task in the maintenance window. The lower the number, the<br>higher the priority.<br><br>Only relevant when both `scan_task_enabled` and `scan_task_maintenance_window_enabled` are true. | `number` | `1` | no |
| <a name="input_scan_task_s3_output_prefix"></a> [scan\_task\_s3\_output\_prefix](#input\_scan\_task\_s3\_output\_prefix) | The path prefix within the S3 bucket to use for `scan` task logs.<br><br>Only relevant when both `scan_task_enabled` and `s3_logging_enabled` are true. | `string` | `"scan"` | no |
| <a name="input_scan_task_sns_notifications_enabled"></a> [scan\_task\_sns\_notifications\_enabled](#input\_scan\_task\_sns\_notifications\_enabled) | If true, enable SNS notifications for the `scan` task.<br><br>Only relevant when `scan_task_enabled` is true. | `bool` | `false` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | The role that should be assumed when executing the tasks.<br><br>If a role is not provided, Systems Manager uses your account's service-linked role.<br>If no service-linked role for Systems Manager exists in your account, it is created for you | `string` | `null` | no |
| <a name="input_sns_notifications_events"></a> [sns\_notifications\_events](#input\_sns\_notifications\_events) | The different events for which you can receive notifications.<br><br>Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed. | `list(string)` | <pre>[<br>  "All"<br>]</pre> | no |
| <a name="input_sns_notifications_role_arn"></a> [sns\_notifications\_role\_arn](#input\_sns\_notifications\_role\_arn) | The ARN of the IAM role that will be used to push task status changes to the SNS topic<br>specified by `notification_arn`. | `string` | `""` | no |
| <a name="input_sns_notifications_topic_arn"></a> [sns\_notifications\_topic\_arn](#input\_sns\_notifications\_topic\_arn) | The ARN of the SNS topic that task status changes will be pushed to. | `string` | `""` | no |
| <a name="input_sns_notifications_type"></a> [sns\_notifications\_type](#input\_sns\_notifications\_type) | When specified with Command, receive notification when the status of a command changes.<br>When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis<br>when the status of a command changes. Valid values: Command and Invocation. | `string` | `"Command"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_target_instance_ids"></a> [target\_instance\_ids](#input\_target\_instance\_ids) | The IDs of instances to register as targets for the created maintenance window(s). | `set(string)` | `[]` | no |
| <a name="input_target_instance_tags"></a> [target\_instance\_tags](#input\_target\_instance\_tags) | A map of instance tag names to their values to register as targets for the created maintenance window(s).<br><br>Note that in the case of the `Patch Group` tag,<br>the `patch_group_targets` variable should be used instead of this one (for that tag only). | `map(set(string))` | `{}` | no |
| <a name="input_target_patch_groups"></a> [target\_patch\_groups](#input\_target\_patch\_groups) | The instances to register as targets for the created maintenance window(s) based<br>on the value of their `Patch Group` tag. | `set(string)` | `[]` | no |
| <a name="input_target_resource_groups"></a> [target\_resource\_groups](#input\_target\_resource\_groups) | A map of resource group keys to their values to register as targets for the created maintenance window(s). | `map(set(string))` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_install_task_maintenance_window_id"></a> [install\_task\_maintenance\_window\_id](#output\_install\_task\_maintenance\_window\_id) | SSM Patch Manager install maintenance window ID |
| <a name="output_install_task_maintenance_window_instances_target_id"></a> [install\_task\_maintenance\_window\_instances\_target\_id](#output\_install\_task\_maintenance\_window\_instances\_target\_id) | SSM Patch Manager install maintenance window instances target ID |
| <a name="output_install_task_maintenance_window_resource_groups_target_id"></a> [install\_task\_maintenance\_window\_resource\_groups\_target\_id](#output\_install\_task\_maintenance\_window\_resource\_groups\_target\_id) | SSM Patch Manager scan maintenance window resource groups target ID |
| <a name="output_install_task_maintenance_window_task_id"></a> [install\_task\_maintenance\_window\_task\_id](#output\_install\_task\_maintenance\_window\_task\_id) | SSM Patch Manager install maintenance windows task ID |
| <a name="output_install_task_patch_group_id"></a> [install\_task\_patch\_group\_id](#output\_install\_task\_patch\_group\_id) | SSM Patch Manager install patch group ID |
| <a name="output_patch_baseline_arn"></a> [patch\_baseline\_arn](#output\_patch\_baseline\_arn) | SSM Patch Manager patch baseline ARN |
| <a name="output_scan_task_maintenance_window_id"></a> [scan\_task\_maintenance\_window\_id](#output\_scan\_task\_maintenance\_window\_id) | SSM Patch Manager install maintenance window ID |
| <a name="output_scan_task_maintenance_window_instances_target_id"></a> [scan\_task\_maintenance\_window\_instances\_target\_id](#output\_scan\_task\_maintenance\_window\_instances\_target\_id) | SSM Patch Manager scan maintenance window instances target ID |
| <a name="output_scan_task_maintenance_window_resource_groups_target_id"></a> [scan\_task\_maintenance\_window\_resource\_groups\_target\_id](#output\_scan\_task\_maintenance\_window\_resource\_groups\_target\_id) | SSM Patch Manager scan maintenance window resource groups target ID |
| <a name="output_scan_task_maintenance_window_task_id"></a> [scan\_task\_maintenance\_window\_task\_id](#output\_scan\_task\_maintenance\_window\_task\_id) | SSM Patch Manager scan maintenance windows task ID |
| <a name="output_scan_task_patch_group_id"></a> [scan\_task\_patch\_group\_id](#output\_scan\_task\_patch\_group\_id) | SSM Patch Manager scan patch group ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
