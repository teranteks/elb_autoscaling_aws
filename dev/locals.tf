locals {
  web_rules_in = [{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  },
  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  },
  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }]

  web_egress_in = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_block       = ["0.0.0.0/0"]
  }]

  name_fol = "hello"
  name_file = "hello.txt"
}

