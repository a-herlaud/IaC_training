provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "instance" {

  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_launch_template" "example" {
  name_prefix   = "example-"
  image_id        = "ami-0fb653ca2d3203ac1"
  instance_type   = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
  EOF
  )

  # Let git manage template versioning and destroy and replace each old template in AWS
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_template {
              id      = aws_launch_template.example.id
            }
  vpc_zone_identifier  = data.aws_subnets.default.ids

  min_size = 2
  max_size = 10
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}