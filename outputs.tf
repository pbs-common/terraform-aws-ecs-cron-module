output "task_arn" {
  description = "Task ARN"
  value       = local.task_arn
}

output "cron" {
  description = "Cron"
  value       = var.cron
}

output "sg" {
  description = "Security Group"
  value       = aws_security_group.task_sg.id
}
