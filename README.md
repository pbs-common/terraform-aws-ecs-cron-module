# PBS TF ecs cron module

## Installation

### Using the Repo Source

```hcl
module "cron" {
    source = "github.com/pbs/terraform-aws-ecs-cron-module?ref=0.0.1"
}
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an ECS scheduled task that will start up an ECS task on a given cron.

Integrate this module like so:

```hcl
module "cron" {
  source = "github.com/pbs/terraform-aws-ecs-cron-module?ref=0.0.1"

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
  image_repo = "hello-world"
  image_tag  = "latest"
  cron       = "00 7 * * ? *"
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`0.0.1`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | github.com/pbs/terraform-aws-ecs-cluster-module | 0.0.1 |
| <a name="module_task"></a> [task](#module\_task) | github.com/pbs/terraform-aws-ecs-task-definition-module | 0.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_security_group.task_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.mysql_to_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.redis_to_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.task_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.task_to_mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.task_to_redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_policy_document.default_role_policy_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.ecs_events_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (sharedtools, dev, staging, prod) | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization using this module. Used to prefix tags so that they are easily identified as being from your organization | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Tag used to group resources according to product | `string` | n/a | yes |
| <a name="input_repo"></a> [repo](#input\_repo) | Tag used to point to the repo using this module | `string` | n/a | yes |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | The name of the ECS Cluster this task runs in. | `string` | `null` | no |
| <a name="input_command"></a> [command](#input\_command) | (optional) command to run in the container as an array. e.g. ["sleep", "10"]. If null, does not set a command in the task definition. | `list(string)` | `null` | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | (optional) JSON container definitions for task | `string` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | (optional) name of the primary container for this service. Defaults to local.name if null. | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port the container will expose | `number` | `80` | no |
| <a name="input_cpu_reservation"></a> [cpu\_reservation](#input\_cpu\_reservation) | (optional) CPU reservation for task | `number` | `256` | no |
| <a name="input_cron"></a> [cron](#input\_cron) | (optional) cron controlling schedule of task. Is set to 07:00 GMT (02:00 EST) by default. | `string` | `"00 7 * * ? *"` | no |
| <a name="input_efs_mounts"></a> [efs\_mounts](#input\_efs\_mounts) | (optional) efs mount set of objects. Components should include dns\_name, container\_mount\_point, efs\_mount\_point | <pre>set(object({<br>    file_system_id = string<br>    efs_path       = string<br>    container_path = string<br>  }))</pre> | `[]` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | (optional) entrypoint to run in the container as an array. e.g. ["sleep", "10"]. If null, does not set an entrypoint in the task definition. | `list(string)` | `null` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | (optional) environment variables to be passed to the container. By default, only passes SSM\_PATH | `set(map(any))` | `null` | no |
| <a name="input_event_rule_description"></a> [event\_rule\_description](#input\_event\_rule\_description) | Value to use for the CloudWatch Event Rule. Will default to name if not defined. | `string` | `null` | no |
| <a name="input_event_rule_name"></a> [event\_rule\_name](#input\_event\_rule\_name) | Name of the CloudWatch Event Rule. Will default to name if not defined. | `string` | `null` | no |
| <a name="input_image_repo"></a> [image\_repo](#input\_image\_repo) | Image repo. e.g. image\_repo = hello-world --> hello-world:image\_tag. Ignored if task\_def\_arn is defined. | `string` | `"hello-world"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Tag of the image. e.g. image\_tag = latest --> image\_repo:latest. Ignored if task\_def\_arn is defined. | `string` | `"latest"` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | (optional) is enabled | `bool` | `true` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service | `string` | `"FARGATE"` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | (optional) memory reservation for task | `number` | `512` | no |
| <a name="input_mysql_sg_ids"></a> [mysql\_sg\_ids](#input\_mysql\_sg\_ids) | MySQL DB Security group IDs | `set(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the service. Will default to product if not defined. | `string` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | (optional) network mode for the task | `string` | `"awsvpc"` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | The platform version on which to run your service | `string` | `"LATEST"` | no |
| <a name="input_redis_sg_ids"></a> [redis\_sg\_ids](#input\_redis\_sg\_ids) | Redis Security group IDs | `set(string)` | `[]` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | (optional) capabilities that the task requires | `set(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_role_policy_json"></a> [role\_policy\_json](#input\_role\_policy\_json) | (optional) the policy to apply for this service. Defaults to a valid ECS role policy if null. | `string` | `null` | no |
| <a name="input_ssm_path"></a> [ssm\_path](#input\_ssm\_path) | (optional) path to the ssm parameters you want pulled into your container during execution of the entrypoint. | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets for the service. If null, private and public subnets will be looked up based on environment tag and one will be selected based on public\_service. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra tags | `map(string)` | `{}` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | (optional) number of tasks to spin up on this schedule. | `number` | `1` | no |
| <a name="input_task_def_arn"></a> [task\_def\_arn](#input\_task\_def\_arn) | Task definition ARN. If null, task will be created with default values, except that image\_repo and image\_tag may be defined. | `string` | `null` | no |
| <a name="input_task_family"></a> [task\_family](#input\_task\_family) | (optional) task family for task. This is effectively the name of the task, without qualification of revision | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID. If null, one will be looked up based on environment tag. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cron"></a> [cron](#output\_cron) | Cron |
| <a name="output_task_arn"></a> [task\_arn](#output\_task\_arn) | Task ARN |
