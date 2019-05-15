# ---------------------------------------------
# create a S3 bucket leandevops.io website
# ---------------------------------------------
provider "aws" {
  region = "us-east-1"
}

# ---------------------------------------------
# find the ACM certificate leandevops.io
# ---------------------------------------------

data "aws_acm_certificate" "cert" {
  domain   = "leandevops.io"
  statuses = ["ISSUED"]
}

output "cert" {
  value = "${data.aws_acm_certificate.cert.arn}"
}
