variable "name_prefix" {
  description = "Name prefix for the S3 bucket"
  type        = string
}

variable "website_index_document" {
  description = "Index document for the static website"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "Error document for the static website"
  type        = string
  default     = "error.html"
}
