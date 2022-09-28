#Launch Configuration(Template) that used for AutoScaling Groups of EC2 Instances
resource "aws_launch_configuration" "ec2_conf" {
 # name          = local.ec2_conf_name
  name_prefix = "${local.ec2_conf_name}-"
  image_id      = data.aws_ami.ec2_ami.id
  instance_type = local.ec2_instance_type
  security_groups = [ aws_security_group.ec2_sg.id ]
  user_data = file("./stat_files/bootstrap.sh")
  
  lifecycle {
    create_before_destroy = true
  }

}



resource "aws_autoscaling_group" "bg_ec2" {
  name_prefix = "${local.autoscaling_group_name}-"
  launch_configuration = aws_launch_configuration.ec2_conf.name
    
  min_size = local.min_autoscale
  max_size = local.max_autoscale

  min_elb_capacity = local.elb_scale_min
  vpc_zone_identifier = [ aws_default_subnet.bg_pub_sub1.id, aws_default_subnet.bg_pub_sub2.id ] #where ec2 resides after creation

  health_check_type = "ELB" #ELB check health by loading page
  load_balancers = [ aws_elb.bg_elb.id ]
  force_delete              = true

  dynamic "tag" {
    for_each = local.autoscale_group_tags

    content {
        key = tag.value.key
        value = tag.value.value
        propagate_at_launch = tag.value.propagate_at_launch
    }
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_elb" "bg_elb" {
  name = local.elb_name
#   subnets = [ aws_subnet.bg_pub_sub.id ]
  availability_zones = [ data.aws_availability_zones.avail.names[0], data.aws_availability_zones.avail.names[1]]
  security_groups = [ aws_security_group.ec2_sg.id ]
  cross_zone_load_balancing   = true
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 80
    instance_protocol = "http"

  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3 
    target              = "HTTP:80/"
    interval            = 10
  }

  tags = {
    Name = "bg-elb"
  }
  
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.bg_ec2.id
  elb                    = aws_elb.bg_elb.id
}