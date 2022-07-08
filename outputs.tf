output "task_arn" {
  description = "Task ARN"
  value       = local.task_arn
}

output "cron" {
  description = "Cron"
  value       = var.cron
}
