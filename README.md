# Terraform module for AWS S3 static website creation
[![Maintained by Leandevops.io](https://img.shields.io/badge/maintained%20by-leandevops-green.svg)](https://img.shields.io/badge/maintained%20by-leandevops-green.svg)
[![CircleCI](https://circleci.com/gh/leandevops/terraform-aws-s3-static-site.svg?style=svg)](https://circleci.com/gh/leandevops/terraform-aws-s3-static-site)

## Module Variables

| Name   |    Description |
|--------|--------------|
| `region` | Region to create a bucket |
| `domain_name` | Domain name for static site |
| `index_document` |  (Required, unless using redirect_all_requests_to) Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders |
| `error_document` | (Optional) An absolute path to the document to return in case of a 4XX errors |
| `versioning_enabled` | A state of versioning |
| `redirect_all_requests_to` | A hostname to redirect all website requests for this bucket to. If this is set `index_document` will be ignored |
| `routing_rules` | A json array containing routing rules describing redirect behavior and when redirects are applied |
| `force_destroy` | Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`)|
| `tags` | A map of tags for a bucket |

## Usage

```hcl
provider "aws" {
  region = "${var.region}"
}

# create a website bucket
module "website" {
  source         = "github.com/leandevops/terraform-aws-s3-static-site//module?ref=v0.1.0"
  region         = "${var.region}"

  domain_name    = "${var.domain_name}"

  index_document = "${var.index_document}"
  error_document = "${var.error_document}"
  tags           = "${var.tags}"
}

# create a redirect bucket that points to website
module "website_redirect" {
  source = "github.com/leandevops/terraform-aws-s3-static-site//module?ref=v0.1.0"
  region                   = "${var.region}"

  domain_name              = "www.${var.domain_name}"

  redirect_all_requests_to = "https://${var.domain_name}"
  tags = "${var.tags}"
}

output "website_url" {
  value = "${module.website.s3_bucket_website_domain}"
}

output "website_redirect_url" {
  value = "${module.website_redirect.s3_bucket_website_domain}"
}

```
To see more examples of using this module, refer to [examples](https://github.com/leandevops/terraform-aws-s3-static-site/tree/master/examples) directory.

## Outputs
| Name   |  Description |
|--------|--------------|
| `s3_bucket_name` | DNS record of website bucket |
| `s3_bucket_domain_name` | Name of of website bucket |
| `s3_bucket_arn` | The arn of of website bucket |
| `s3_bucket_website_endpoint` | The website endpoint URL |
| `s3_bucket_website_domain` | The domain of the website endpoint |

## How do I contribute to this Module?
Contributions are very welcome! Check out the 
[Contribution Guidelines](https://github.com/leandevops/terraform-aws-s3-static-site/blob/master/CONTRIBUTING.md) for instructions.

## License
This code is released under the Apache 2.0 License. Please see [LICENSE](https://github.com/leandevops/terraform-aws-s3-static-site/blob/master/LICENSE) for more details.

Copyright © 2019 [LeanDevops](https://leandevops.io).
