provider "aws" {
  region = "${var.region}"
}

# create a root bucket
module "module_test_root" {
  source = "../../../module"

  region         = "${var.region}"
  domain_name    = "${var.domain_name}"
  index_document = "${var.index_document}"
  error_document = "${var.error_document}"

  tags = "${var.tags}"
}

output "s3_bucket_website_domain_root" {
  value = "${module.module_test_root.s3_bucket_website_domain}"
}

# create a redirect bucket that points to root
module "module_test_redirect" {
  source = "../../../module"

  region                   = "${var.region}"
  domain_name              = "www.${var.domain_name}"
  redirect_all_requests_to = "https://${var.domain_name}"

  tags = "${var.tags}"
}

output "s3_bucket_website_domain_redirect" {
  value = "${module.module_test_redirect.s3_bucket_website_domain}"
}
