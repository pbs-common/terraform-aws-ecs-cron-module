module "task_def" {
  source = "github.com/pbs/terraform-aws-ecs-task-definition-module?ref=0.0.2"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "cron" {
  source = "../.."

  task_def_arn = module.task_def.arn

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
