variable "region" {
    type = string
    default= "eu-north-1"
}

variable "host_os" {
  description = "Operating system where Terraform is running"
  type        = string
  default     = "windows" # ou "linux"
}

variable "local_public_ip"{
    type = string
}