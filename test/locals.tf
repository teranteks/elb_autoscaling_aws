locals {
  web_allow_traffic = [{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  autoscale_group_tags = [{
    key = "Name"
    value = "bg-web-test"
    propagate_at_launch = true #Tags will be added to each ec2 started in autoscaling group

  },
  {
    key = "Owner"
    value = "Me"
    propagate_at_launch = true #Tags will be added to each ec2 started in autoscaling group

  }]

  ec2_sg_name = "ec2-sg-allow-http-ssh"
  ec2_conf_name = "ec2-conf"
  ec2_instance_type = "t2.micro"

  bg_vpc_name = "test-vpc"
  bg_vpc_cidr = "10.0.0.0/16"
  bg_sub_pub_cidr = "10.0.1.0/24"
  bg_pub_sub_name = "test-vpc-pub-sub"
  bg_sub_pub_cidr1 = "10.0.2.0/24"
  bg_pub_sub_name1 = "test-vpc-pub-sub1"

  ami_pattern_ec2 = "amzn2-ami-kernel-*-hvm-*-x86_64-gp2"

  autoscaling_group_name = "bg-web-test"
  min_autoscale = 2
  max_autoscale = 4
  elb_scale_min = 1

  elb_name = "bg-elb"
}