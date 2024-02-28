# provision vpc 
resource "aws_vpc" "terra_vpc" {
  cidr_block = "10.0.0.0/16"
}

# create a subnet
resource "aws_subnet" "terra_subnet" {
  vpc_id = aws_vpc.terra_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2"
}

# create security group to allow ingoing ports
resource "aws_security_group" "terra_SG" {
  name        = "allow_web"
  description = "security group for the EC2 instance"
  vpc_id      = aws_vpc.terra_vpc.id
  
  ingress = {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress = {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "terra_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  user_data = file("${path.module}/file.sh")
  
  tags = {
    name = "web_server"
  }
}