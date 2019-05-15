provider "aws" {
  region = "${var.region}"
}

module "module_test" {
  source = "../../../module"

  region   = "${var.region}"
  domain_name     = "${var.domain_name}"
  index_doc = "${var.index_doc}"
  error_doc = "${var.error_doc}"

  tags = "${var.tags}"
}
