output "task_arn" {
  description = "Task ARN"
  value       = module.cron.task_arn
}

output "cron" {
  description = "Cron"
  value       = module.cron.cron
}
