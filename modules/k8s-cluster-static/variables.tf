variable "vpc_id" {
  description = "The ID of the VPC which resources should be attached to"
}

variable "public_subnet" {
  type        = list
  description = "A list of public subnets"
}

variable "private_subnet" {
  type        = list
  description = "A list of private subnets"
}

variable "stack_tags" {
  type        = map
  description = "A map of tags designated at the stack level"
}
