# Terraform :: Stack :: AWS :: Kubernetes the Hard Way

This repository contains a Terraform configuration which will deploy an entire
stack required to follow Kelsey Hightower's [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)
installation guide.

## Warning
Applying this stack will create AWS resources which may or not be in the free
tier depending upon your account status. By making use of this repository, you
agree that any costs incurred are your own responsibility.


# Usage

This stack will build all of the infrastructure required to follow Kelsey
Hightower's "Kubernetes the Hard Way" guide. It is intended to fast-track the
user through the items which are not core to the goal of this guide so that
they can begin learning as quickly as possible.

This stack does _not_ perform any significant bootstrapping or configuration of
the generated instances. That's the user's job as a student!

## Requirements
* An active AWS account
* Terraform version 1.1.x

## Steps to Apply

1. Clone this repository to your local machine.
1. Log into your AWS account (guidance on configuring your CLI environment in is available at https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
1. Verify your credential configuration
   ```
   aws sts get-caller-identity
   ```
1. Run Terraform Init

# Components

Applying this stack will result in the following significant resources being
created:

* An AWS VPC—[Terraform AWS Modules :: terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)
    * Three public subnets
    * Three private subnets
* EC2 Instances (seven total)
    * One Bastion instance in a Public subnet
    * Three instances to function as Kubernetes Master nodes in Private subnets
    * Three instances to function as Kubernetes worker nodes in Private subnets
* A Load Balancer for the Kubernetes API in the Public subnets

An exhaustive list of every resource may be generated prior to applying by
running `terraform plan`.


# Notes
