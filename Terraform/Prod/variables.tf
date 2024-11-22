variable "prod_cidr_ipv4" {
  description = "IPv4 CIDR block for developer access"
  type        = string
  sensitive   = true
}

variable "prod_image_name" {
  description = "Image name with shortened commit hash tag"
  type        = string
}