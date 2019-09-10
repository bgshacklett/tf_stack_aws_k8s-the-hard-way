variable "aws_region" {
  description = "The AWS region in which resources will be built"
}

variable "vpc_cidr" {
  description = "The CIDR range of the VPC"
}

variable "availability_zone" {
  description = "A list of availability zones to use"
  type        = "list"
}

variable "public_subnet_cidr" {
  description = "A list of public subnet CIDR ranges"
  type        = "list"
}

variable "private_subnet_cidr" {
  description = "A list of private subnet CIDR ranges"
  type        = "list"
}

#variable "" {
#  description = ""
#}
