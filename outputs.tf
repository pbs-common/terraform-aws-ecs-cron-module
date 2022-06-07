output "task_arn" {
  description = "Task ARN"
  value       = module.task[0].arn
}

output "cron" {
  description = "Cron"
  value       = var.cron
}
