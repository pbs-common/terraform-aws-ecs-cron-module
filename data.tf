data "aws_vpc" "vpc" {
  count = var.vpc_id == null ? 1 : 0
  tags = {
    "Name" : "*${var.environment}*"
  }
}

data "aws_subnets" "private_subnets" {
  count = var.subnets == null ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-private-*"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "default_role_policy_json" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "kms:ListKeys",
      "ssm:DescribeParameters"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets",
      "xray:GetSamplingStatisticSummaries"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "kms:Decrypt",
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]
    resources = [
      "arn:aws:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${local.ssm_path}",
      "arn:aws:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${local.ssm_path}*"

    ]
  }
}

data "aws_iam_role" "ecs_events_role" {
  name = "ecsEventsRole"
}

data "aws_ecs_cluster" "cluster" {
  count        = local.create_cluster ? 0 : 1
  cluster_name = var.cluster
}
