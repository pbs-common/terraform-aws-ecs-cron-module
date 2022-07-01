resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = local.event_rule_name
  description         = local.event_rule_description
  schedule_expression = "cron(${var.cron})"
  is_enabled          = var.is_enabled

  tags = local.tags
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = local.event_rule_name
  arn       = local.cluster_arn
  role_arn  = data.aws_iam_role.ecs_events_role.arn

  ecs_target {
    task_count          = var.task_count
    task_definition_arn = local.task_def_arn
    launch_type         = var.launch_type
    platform_version    = var.platform_version

    network_configuration {
      security_groups = [aws_security_group.task_sg.id]
      subnets         = local.subnets
    }
  }

  input = var.input
}
