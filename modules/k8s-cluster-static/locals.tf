locals {
  common_tags = merge(
                       var.stack_tags,
                       {},
                     )

  vpc_cidr_range = data.aws_vpc.selected.cidr_block
}
