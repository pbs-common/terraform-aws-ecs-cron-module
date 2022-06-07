resource "aws_security_group" "task_sg" {
  description = "Controls access to the ${local.name} task resources"
  vpc_id      = local.vpc_id
  name_prefix = "${local.name}-task-sg-"

  tags = {
    Name        = "${local.name} task SG"
    application = var.product
    environment = var.environment
    creator     = local.creator
    repo        = var.repo
  }
}

## Allow All Traffic out anywhere for egress
resource "aws_security_group_rule" "task_egress" {
  security_group_id = aws_security_group.task_sg.id
  description       = "Allow all traffic out"
  type              = "egress"
  protocol          = "-1"

  from_port = 0
  to_port   = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "task_to_mysql" {
  for_each          = var.mysql_sg_ids
  security_group_id = each.value
  description       = "Allow MySQL traffic from the ECS task to the DB"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.mysql_port
  to_port   = local.mysql_port

  source_security_group_id = aws_security_group.task_sg.id
}

resource "aws_security_group_rule" "task_to_redis" {
  for_each          = var.redis_sg_ids
  security_group_id = each.value
  description       = "Allow Redis traffic from the ECS task to the cluster"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.redis_port
  to_port   = local.redis_port

  source_security_group_id = aws_security_group.task_sg.id
}

resource "aws_security_group_rule" "mysql_to_task" {
  for_each          = var.mysql_sg_ids
  security_group_id = aws_security_group.task_sg.id
  description       = "Allow MySQL traffic from the DB to the task"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.mysql_port
  to_port   = local.mysql_port

  source_security_group_id = each.value
}

resource "aws_security_group_rule" "redis_to_task" {
  for_each          = var.redis_sg_ids
  security_group_id = aws_security_group.task_sg.id
  description       = "Allow Redis traffic from the cluster to the ECS task"
  type              = "ingress"
  protocol          = "tcp"

  from_port = local.redis_port
  to_port   = local.redis_port

  source_security_group_id = each.value
}
