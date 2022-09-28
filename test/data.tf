data "aws_availability_zones" "avail" {
  
}

data "aws_caller_identity" "cur_iden" {
  
}

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = ["${local.ami_pattern_ec2}"]
  }
}

