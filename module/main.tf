# ---------------------------------------------
# local variables for default and redirection
# ---------------------------------------------

locals {
  website_config = {
    redirect_all = [{
      redirect_all_requests_to = "${var.redirect_requests_to}"
    }]

    default = [{
      index_document = "${var.index_document}"
      error_document = "${var.error_document}"
      routing_rules  = "${var.routing_rules}"
    }]
  }
}

# ---------------------------------------------
# root bucket
# ---------------------------------------------
resource "aws_s3_bucket" "website" {
  bucket        = "${var.domain_name}"
  region        = "${var.region}"
  acl           = "public-read"
  force_destroy = "${var.force_destroy}"

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }

  tags = "${merge(var.tags, map("Name", format("%s", var.domain_name)))}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }
}

# AWS only supports a single bucket policy on a bucket.
# You can combine multiple Statements into a single policy.
resource "aws_s3_bucket_policy" "website" {
  bucket = "${aws_s3_bucket.website.id}"
  policy = "${data.aws_iam_policy_document.website.json}"
}

data "aws_iam_policy_document" "website" {
  statement = {
    sid       = "PublicRead"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
