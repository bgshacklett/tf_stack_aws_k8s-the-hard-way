# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = "k8s-lab"
}
