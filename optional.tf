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

variable "container_port" {
  description = "Port the container will expose"
  default     = 80
  type        = number
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

variable "image_repo" {
  description = "Image repo. e.g. image_repo = hello-world --> hello-world:image_tag. Ignored if task_def_arn is defined."
  default     = "hello-world"
  type        = string
}

variable "image_tag" {
  description = "Tag of the image. e.g. image_tag = latest --> image_repo:latest. Ignored if task_def_arn is defined."
  default     = "latest"
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

variable "mysql_sg_ids" {
  description = "MySQL DB Security group IDs"
  default     = []
  type        = set(string)
}

variable "redis_sg_ids" {
  description = "Redis Security group IDs"
  default     = []
  type        = set(string)
}

variable "container_name" {
  description = "(optional) name of the primary container for this service. Defaults to local.name if null."
  default     = null
  type        = string
}

variable "role_policy_json" {
  description = "(optional) the policy to apply for this service. Defaults to a valid ECS role policy if null."
  default     = null
  type        = string
}

variable "ssm_path" {
  description = "(optional) path to the ssm parameters you want pulled into your container during execution of the entrypoint."
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

variable "container_definitions" {
  description = "(optional) JSON container definitions for task"
  default     = null
  type        = string
}

variable "cpu_reservation" {
  description = "(optional) CPU reservation for task"
  default     = 256
  type        = number
}

variable "memory_reservation" {
  description = "(optional) memory reservation for task"
  default     = 512
  type        = number
}

variable "requires_compatibilities" {
  description = "(optional) capabilities that the task requires"
  default     = ["FARGATE"]
  type        = set(string)
}

variable "network_mode" {
  description = "(optional) network mode for the task"
  default     = "awsvpc"
  type        = string
}

variable "efs_mounts" {
  description = "(optional) efs mount set of objects. Components should include dns_name, container_mount_point, efs_mount_point"
  default     = []
  type = set(object({
    file_system_id = string
    efs_path       = string
    container_path = string
  }))
}

variable "env_vars" {
  description = "(optional) environment variables to be passed to the container. By default, only passes SSM_PATH"
  default     = null
  type        = set(map(any))
}

variable "command" {
  description = "(optional) command to run in the container as an array. e.g. [\"sleep\", \"10\"]. If null, does not set a command in the task definition."
  default     = null
  type        = list(string)
}

variable "entrypoint" {
  description = "(optional) entrypoint to run in the container as an array. e.g. [\"sleep\", \"10\"]. If null, does not set an entrypoint in the task definition."
  default     = null
  type        = list(string)
}
