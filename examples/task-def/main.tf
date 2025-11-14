module "task_def" {
  source = "github.com/pbs/terraform-aws-ecs-task-definition-module?ref=3.0.0"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
  owner        = var.owner
}

module "cron" {
  source = "../.."

  task_def_arn = module.task_def.arn

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
  owner        = var.owner
}
