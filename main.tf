module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"

  name = "Kubernetes the Hard Way"

  cidr            = var.vpc_cidr
  azs             = var.availability_zone
  public_subnets  = var.public_subnet_cidr
  private_subnets = var.private_subnet_cidr

  enable_nat_gateway   = true
  enable_vpn_gateway   = false
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {},
  )
}

module "k8s" {
  source         = "./modules/k8s-cluster-static"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnets
  private_subnet = module.vpc.private_subnets
  stack_tags = merge(
    local.common_tags,
    {},
  )
}
