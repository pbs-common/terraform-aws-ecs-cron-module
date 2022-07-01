module "cron" {
  source = "../.."

  input = jsonencode({
    "containerOverrides" : [
      {
        "name" : "name-of-container-to-override",
        "command" : ["bin/console", "scheduled-task"]
      }
    ]
  })

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
