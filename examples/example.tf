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
