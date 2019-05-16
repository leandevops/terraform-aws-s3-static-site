######################################		
# output variables		
######################################
output "s3_bucket_name" {
  value       = "${aws_s3_bucket.website.id}"
  description = "DNS record of website bucket"
}

output "s3_bucket_domain_name" {
  value       = "${aws_s3_bucket.website.bucket_domain_name}"
  description = "Name of of website bucket"
}

output "s3_bucket_arn" {
  value       = "${aws_s3_bucket.website.arn}"
  description = "The arn of of website bucket"
}

output "s3_bucket_website_endpoint" {
  value       = "${aws_s3_bucket.website.website_endpoint}"
  description = "The website endpoint URL"
}

output "s3_bucket_website_domain" {
  value       = "${aws_s3_bucket.website.website_domain}"
  description = "The domain of the website endpoint"
}
