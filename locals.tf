locals {
  name                   = var.name != null ? var.name : var.product
  task_family            = var.task_family != null ? var.task_family : local.name
  task_def_arn           = var.task_def_arn != null ? var.task_def_arn : module.task[0].arn
  vpc_id                 = var.vpc_id != null ? var.vpc_id : data.aws_vpc.vpc[0].id
  subnets                = var.subnets != null ? var.subnets : data.aws_subnets.private_subnets[0].ids
  role_policy_json       = var.role_policy_json != null ? var.role_policy_json : data.aws_iam_policy_document.default_role_policy_json.json
  event_rule_name        = var.event_rule_name != null ? var.event_rule_name : local.name
  event_rule_description = var.event_rule_description != null ? var.event_rule_description : local.name
  ssm_path               = var.ssm_path != null ? var.ssm_path : "/${var.environment}/${local.name}/"
  create_cluster         = var.cluster == null
  cluster_arn            = local.create_cluster ? module.cluster[0].arn : data.aws_ecs_cluster.cluster[0].arn
  task_arn               = var.task_def_arn != null ? var.task_def_arn : module.task[0].arn

  creator = "terraform"

  defaulted_tags = merge(
    var.tags,
    {
      Name                                      = local.name
      "${var.organization}:billing:product"     = var.product
      "${var.organization}:billing:environment" = var.environment
      creator                                   = local.creator
      repo                                      = var.repo
    }
  )

  tags = merge({ for k, v in local.defaulted_tags : k => v if lookup(data.aws_default_tags.common_tags.tags, k, "") != v })
}

data "aws_default_tags" "common_tags" {}
