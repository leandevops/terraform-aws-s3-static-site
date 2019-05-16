provider "aws" {
  region = "${var.region}"
}

# create a root bucket
module "website_root" {
  source         = "../../../module"
  region         = "${var.region}"
  domain_name    = "${var.domain_name}"
  index_document = "${var.index_document}"
  error_document = "${var.error_document}"
  tags           = "${var.tags}"
}

# create a redirect bucket that points to root
module "website_redirect" {
  source = "../../../module"

  region                   = "${var.region}"
  domain_name              = "www.${var.domain_name}"
  redirect_all_requests_to = "https://${var.domain_name}"

  tags = "${var.tags}"
}

output "s3_bucket_website_domain_root" {
  value = "${module.website_root.s3_bucket_website_domain}"
}

output "s3_bucket_website_domain_redirect" {
  value = "${module.website_redirect.s3_bucket_website_domain}"
}

# ---------------------------------------------
# find the ACM certificate domain
# ---------------------------------------------

data "aws_acm_certificate" "cert" {
  domain   = "domain.name"
  statuses = ["ISSUED"]
}
