module "cluster" {
  count  = local.create_cluster ? 1 : 0
  source = "github.com/pbs/terraform-aws-ecs-cluster-module?ref=1.0.1"

  vpc_id  = local.vpc_id
  subnets = local.subnets

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
