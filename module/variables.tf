variable "region" {
  description = "Region to create a bucket"
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Domain name"
  default     = ""
}

variable "index_doc" {
  description = "Index document name"
  default     = "index.html"
}

variable "error_doc" {
  description = "Error document name"
  default     = "error.html"
}

variable "tags" {
  default = {}
}

