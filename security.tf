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
