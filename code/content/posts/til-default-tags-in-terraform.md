---
draft: false
date: 2021-05-18T20:12:00-06:00
title: Terraform and Default Tags for AWS Resources
description: 
tags: [terraform, aws]
post_type: "TIL"
---

I haven't had a chance to use Terraform lately, and was pleasantly surprised that you can now specify default tags for nearly all resources at the provider level.

```hcl
provider "aws" {
    alias = "ohio" 
    region  = "us-east-2"

    default_tags {
        tags = {
            Automation = "Terraform"
            Repo = "Infrastructure.Network"
            Project = "Sandbox"
            Terraform_Workspace = "${var.ATLAS_WORKSPACE_NAME}"            
        }
    }
}
```

### References
- [Docs](https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider)
