variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be built"
  default     = "us-east-2"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR range of the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zone" {
  description = "A list of availability zones to use"
  type        = list(string)
  default     = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
  ]
}

variable "public_subnet_cidr" {
  description = "A list of public subnet CIDR ranges"
  type        = list(any)
  default     = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "private_subnet_cidr" {
  description = "A list of private subnet CIDR ranges"
  type        = list(any)
  default     = [
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24",
  ]
}
