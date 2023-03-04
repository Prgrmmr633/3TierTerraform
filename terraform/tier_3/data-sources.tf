provider "aws" {
  region = "us-west-2"
}

data "aws_availability_zones" "available" {
}

data "aws_region" "current" {}

# Define VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_key_pair" "prgrmmr_633" {
  key_name = "prgrmmr_633"
}

variable "private_subnets" {
  default = {
    "sg_prgrmmr_633_management"  = 122
  }
}