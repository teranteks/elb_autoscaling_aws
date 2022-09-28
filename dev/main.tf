  resource "aws_vpc" "test" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    
    tags = {
      Name = "test"
    }
  }

  resource "aws_subnet" "sub" {
    vpc_id     = aws_vpc.test.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true
    
    tags = { 
      Name = "test sub"
    }
   }

 resource "aws_security_group" "test_group" {
   name = "allow_http"
   description = "allow http and 8080 traffic come"
   vpc_id = aws_vpc.test.id

   dynamic "ingress" {
    for_each = local.web_rules_in

    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
    
   }
  
  dynamic "egress" {
    for_each = local.web_egress_in

    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_block
    }
  }
  
  # tags = {
  #   Name = "allow_http"
  # }
  
 }

  resource "aws_eip" "ip" {
    count = 2
    instance = aws_instance.web[count.index].id
    vpc = true


  }

 resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.test.id
  }

 resource "aws_instance" "web" {
  count = 2
  ami           = data.aws_ami.ec2_ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub.id
  
  user_data = templatefile("./bootsh.sh.tpl", { name_fol = local.name_fol, name_file = local.name_file })

  vpc_security_group_ids = [aws_security_group.test_group.id]
  tags = {
    Name = "HelloWorld.${count.index}"
  }
}