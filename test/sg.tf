resource "aws_security_group" "ec2_sg" { 
    name = local.ec2_sg_name
    # vpc_id = aws_vpc.bg_vpc.id

    dynamic "ingress" {
        for_each = local.web_allow_traffic

        content {
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = local.ec2_sg_name
    }
}