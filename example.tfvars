aws_region = "us-east-2"
vpc_cidr   = "10.0.0.0/16"
availability_zone = [
  "us-east-2a",
  "us-east-2b",
  "us-east-2c",
]

public_subnet_cidr = [
  "10.0.0.0/24",
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnet_cidr = [
  "10.0.3.0/24",
  "10.0.4.0/24",
  "10.0.5.0/24",
]
