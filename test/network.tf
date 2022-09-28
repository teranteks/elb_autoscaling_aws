# resource "aws_vpc" "bg_vpc" {
#     cidr_block = local.bg_vpc_cidr
#     instance_tenancy = "default"

#     tags = {
#       Name = local.bg_vpc_name
#     }
# }


resource "aws_default_subnet" "bg_pub_sub1" {
#   vpc_id = aws_vpc.bg_vpc.id
  #cidr_block = local.bg_sub_pub_cidr
  availability_zone = data.aws_availability_zones.avail.names[0]
  #map_public_ip_on_launch = true
  
  tags = {
    Name = local.bg_pub_sub_name
  }
}

resource "aws_default_subnet" "bg_pub_sub2" {
#   vpc_id = aws_vpc.bg_vpc.id
  #cidr_block = local.bg_sub_pub_cidr
  availability_zone = data.aws_availability_zones.avail.names[1]
  #map_public_ip_on_launch = true
  
  tags = {
    Name = local.bg_pub_sub_name1
  }
}

resource "aws_internet_gateway" "gw-test" {
#   vpc_id = aws_vpc.bg_vpc.id

  tags = {
    Name = "gw-test"
  }
}