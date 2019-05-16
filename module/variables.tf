######################################		
# input variables		
######################################
variable "region" {
  description = "Region to create a bucket"
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Domain name"
  default     = ""
}

variable "index_document" {
  description = "Index document name"
  default     = "index.html"
}

variable "error_document" {
  description = "Error document name"
  default     = "error.html"
}

variable "versioning_enabled" {
  description = "Versioning enabled (default - false)"
  default     = false
}

variable "redirect_all_requests_to" {
  description = "A hostname to redirect all website requests for this bucket to. If this is set `index_document` will be ignored."
  default     = ""
}

variable "routing_rules" {
  default     = ""
  description = "A json array containing routing rules describing redirect behavior and when redirects are applied"
}

variable "force_destroy" {
  default     = ""
  description = "Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`)"
}

variable "tags" {
  default = {}
}
