# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
 # backend "s3" {
 #   bucket         = "kyler-github-actions-demo-terraform-tfstate"
 #   key            = "terraform.tfstate"
 #   region         = "us-east-1"
 #   dynamodb_table = "aws-locks"
 #   encrypt        = true
 # }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.36.0"
}

/*

#Prueba


# Build the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.3.0.0/16"
  instance_tenancy     = "default"

  tags = {
    Name      = "Vpc-2"
    Terraform = "true"
  }
}

# Build route table 1
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable2"
    Terraform = "true"
  }
}

# Build route table 2
resource "aws_route_table" "route_table3" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable3"
    Terraform = "true"
  }
}

*/
  

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.36.0"
}


/*

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "kyler-github-actions-demo-terraform-tfstate"
  dynamo_db_table_name        = "aws-locks"
  iam_user_name               = "GitHubActionsIamUser"
  ado_iam_role_name           = "GitHubActionsIamRole"
  aws_iam_policy_permits_name = "GitHubActionsIamPolicyPermits"
  aws_iam_policy_assume_name  = "GitHubActionsIamPolicyAssume"
}


  
# Build the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"

  tags = {
    Name      = "Vpc"
    Terraform = "true"
  }
}

# Build route table 1
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable1"
    Terraform = "true"
  }
}

# Build route table 2
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable2"
    Terraform = "true"
  }
}


    
#Create user mary
  
resource "aws_iam_user" "users" {
  name = "mary"
}

*/

# use ubuntu 20 AMI for EC2 instance
data "aws_ami" "ubuntu" {
    most_recent = true
filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/*20.04-amd64-server-*"]
    }
filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
owners = ["099720109477"] # Canonical
}
# provision to us-east-2 region
#provider "aws" {
#  region  = "us-east-2"
#}
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
tags = {
    Name = "ubuntu-ec2"
  }
}
