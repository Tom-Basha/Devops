terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-west-1"
  access_key = ""
  secret_key = ""

}
resource "aws_vpc" "TomBasha-dev-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TomBasha-dev-vpc"
  }
}

resource "aws_internet_gateway" "awsIG" {
  vpc_id = aws_vpc.TomBasha-dev-vpc.id

  tags = {
    Name = "Tom-awsIG"
  }
}

resource "aws_route" "routeAWSIG" {
  route_table_id         = aws_vpc.TomBasha-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.awsIG.id
}

resource "aws_subnet" "Tom-Basha-k8s-subnet" {
  vpc_id            = aws_vpc.TomBasha-dev-vpc.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "us-west-1a"

  tags = {
    Name = "Tom-Basha-k8s-subnet "
  }
}