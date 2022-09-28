output "ec2_pub_ip" {
  value = aws_instance.web[*].public_ip
  sensitive = false
  description = "Ip address"
}

output "eip_pub_ip" {
  value = aws_eip.ip
  sensitive = false
  description = "Ip address"
}

output "avail_zones" {
  value = data.aws_availability_zones.work.names
}

output "identity_account" {
  value = data.aws_caller_identity.identity.account_id
}

output "identity_user_id" {
  value = data.aws_caller_identity.identity.user_id
}


output "identity_arn" {
  value = data.aws_caller_identity.identity.arn
}

output "region" {
  value = data.aws_region.current.description
}

output "vpcs" {
  value = data.aws_vpcs.all.ids
}

# output "vpc" {
#   value = data.aws_vpc.vpc_my.id
# }

# output "vpc1" {
#   value = data.aws_vpc.vpc_my.cidr_block
# }

output "ami_id" {
  value = data.aws_ami.ec2_ami.name
}