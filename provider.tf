# Configure the AWS Provider
provider "aws" {
  version = "2.27.0"
  region  = "us-east-2"
  profile = "k8s-lab"
}
