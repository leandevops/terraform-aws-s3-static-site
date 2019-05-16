provider "aws" {
  region = "${var.region}"
}

# create a root bucket
module "module_test" {
  source = "../../../module"

  region         = "${var.region}"
  domain_name    = "${var.domain_name}"
  index_document = "${var.index_document}"
  error_document = "${var.error_document}"

  # set force_destroy to true, consider this
  # parameter in environments that are not 'test'
  force_destroy  = true

  tags = "${var.tags}"
}

output "s3_bucket_website_domain" {
  value = "${module.module_test.s3_bucket_website_endpoint}"
}
