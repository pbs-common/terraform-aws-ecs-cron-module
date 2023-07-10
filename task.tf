module "task" {
  count  = var.task_def_arn == null ? 1 : 0
  source = "github.com/pbs/terraform-aws-ecs-task-definition-module?ref=1.0.6"

  image_repo = var.image_repo
  image_tag  = var.image_tag

  role_policy_json = local.role_policy_json

  service_name             = local.name
  task_family              = local.task_family
  container_name           = var.container_name
  container_port           = var.container_port
  container_definitions    = var.container_definitions
  cpu_reservation          = var.cpu_reservation
  memory_reservation       = var.memory_reservation
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  efs_mounts               = var.efs_mounts
  env_vars                 = var.env_vars

  command    = var.command
  entrypoint = var.entrypoint

  ssm_path = var.ssm_path

  mesh_name        = var.mesh_name
  virtual_node     = var.virtual_node
  virtual_gateway  = var.virtual_gateway
  envoy_tag        = var.envoy_tag
  use_xray_sidecar = var.use_xray_sidecar
  runtime_platform = var.runtime_platform

  awslogs_driver_mode = var.awslogs_driver_mode

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
