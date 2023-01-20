variable "name" {
  description = "Name of the service. Will default to product if not defined."
  default     = null
  type        = string
}

variable "event_rule_name" {
  description = "Name of the CloudWatch Event Rule. Will default to name if not defined."
  default     = null
  type        = string
}

variable "event_rule_description" {
  description = "Value to use for the CloudWatch Event Rule. Will default to name if not defined."
  default     = null
  type        = string
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  default     = "FARGATE"
  type        = string
}

variable "platform_version" {
  description = "The platform version on which to run your service"
  default     = "LATEST"
  type        = string
}

variable "cluster" {
  description = "The name of the ECS Cluster this task runs in."
  default     = null
  type        = string
}

variable "task_def_arn" {
  description = "Task definition ARN. If null, task will be created with default values, except that image_repo and image_tag may be defined."
  default     = null
  type        = string
}

variable "subnets" {
  description = "Subnets for the service. If null, private and public subnets will be looked up based on environment tag and one will be selected based on public_service."
  default     = null
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID. If null, one will be looked up based on environment tag."
  default     = null
  type        = string
}

variable "role_policy_json" {
  description = "(optional) the policy to apply for this service. Defaults to a valid ECS role policy if null."
  default     = null
  type        = string
}

variable "task_count" {
  description = "(optional) number of tasks to spin up on this schedule."
  default     = 1
  type        = number
}

variable "cron" {
  description = "(optional) cron controlling schedule of task. Is set to 07:00 GMT (02:00 EST) by default."
  default     = "00 7 * * ? *"
  type        = string
}

variable "is_enabled" {
  description = "(optional) is enabled"
  default     = true
  type        = bool
}

variable "task_family" {
  description = "(optional) task family for task. This is effectively the name of the task, without qualification of revision"
  default     = null
  type        = string
}

variable "input" {
  description = "(optional) input to pass to the container as an array. e.g. {\"containerOverrides\": [{\"name\": \"name-of-container-to-override\",\"command\": [\"bin/console\", \"scheduled-task\"]}]}. If null, does not set an input in the task definition."
  default     = null
  type        = string
}
