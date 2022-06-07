# PBS TF ecs cron module

## Installation

### Using the Repo Source

```hcl
module "cron" {
    source = "github.com/pbs/terraform-aws-ecs-cron-module?ref=x.y.z"
}
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an ECS scheduled task that will start up an ECS task on a given cron.

Integrate this module like so:

```hcl
module "cron" {
  source = "github.com/pbs/terraform-aws-ecs-cron-module?ref=x.y.z"

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

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
