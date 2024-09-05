# Define the provider (cloud platform)
provider "aws" {
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region     = "us-west-2"
}

# Define virtual machines
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  count         = 2

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}

# Define a load balancer
resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"

  subnets = ["subnet-12345678", "subnet-87654321"]

  security_groups = [aws_security_group.lb_sg.id]
}

# Define a security group
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Load Balancer Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
