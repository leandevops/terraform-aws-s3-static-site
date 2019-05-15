# ---------------------------------------------
# create a S3 bucket leandevops.io website
# ---------------------------------------------
provider "aws" {
  region = "${var.region}"
}

# ---------------------------------------------
# root bucket
# ---------------------------------------------
resource "aws_s3_bucket" "root" {
  bucket = "${var.domain_name}"
  acl = "public-read"

  website {
    index_document = "${var.index_doc}"
    error_document = "${var.error_doc}"
  }

  tags = "${merge(var.tags, map("Name", format("%s", var.domain_name)))}"
}

resource "aws_s3_bucket_policy" "root" {
  bucket = "${aws_s3_bucket.root.id}"
  policy = "${data.aws_iam_policy_document.root.json}"
}
data "aws_iam_policy_document" "root" {
  statement = {
    sid = "PublicRead"

    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_s3_bucket.root.arn}/*",
    ]
  }
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
