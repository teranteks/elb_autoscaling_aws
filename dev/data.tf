data "aws_availability_zones" "work" {
  
}

data "aws_caller_identity" "identity" {
  
}

data "aws_region" "current" {
  
}

data "aws_vpcs" "all" {
  
}

# data "aws_vpc" "vpc_my" {
#   tags = {
#     Name = "test"
#   }
# }

data "aws_ami" "ec2_ami" {
        most_recent = true
        owners = ["amazon"]
        
        filter {
            name = "name" #specify filter criteria key for name 
            values = ["RHEL-*-x86_64*"]
        }
}