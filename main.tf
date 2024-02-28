data "aws_ami" "web_ami" {  # Data source for retrieving the latest Bitnami Tomcat AMI
  most_recent = true
  filter {                  # Filter AMIs by name
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }
  filter {                  # Filter AMIs by virtualization type
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["979382823631"] # Specify the owner of the AMIs (Bitnami)
}
# Data source for retrieving the default VPC
data "aws_vpc" "vpc_nm" {   
  default = true
}

module "web_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "dev"
  cidr = "10.0.0.0/16"
  azs  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Resource definition for launching an EC2 instance
resource "aws_instance" "web_app" {       
  ami           = data.aws_ami.web_ami.id # Use the AMI retrieved from the data source
  instance_type = var.instance_type       # Specify the instance type using a variable
  vpc_security_group_ids = [aws_security_group.webpage.id] # Add a list of security group IDs to the instance 
  subnet_id = module.web_vpc.public_subnets[0]

}
# Add Security Group
resource "aws_security_group" "webpage" { 
  name = "webpage"
  vpc_id = module.web_vpc.vpc_id
}

# Rule for HTTP-inbound traffic
resource "aws_security_group_rule" "web_inbound" {
  type              = "ingress"                     # Type of rule (ingress for inbound traffic)
  from_port         = 80                            # Port 80 is the default port for HTTP traffic 
  to_port           = 80                         
  protocol          = "tcp"                         # Protocol "tcp" explicitly specified for security
  cidr_blocks       = [var.my_ip_address]           # List of allowed IP addresses
  security_group_id = aws_security_group.webpage.id # ID of the security group
}

# Rule for HTTPS-inbound traffic
resource "aws_security_group_rule" "web_secure_inbound" {
  type              = "ingress"       
  from_port         = 443  # Port 443 is the default port for HTTPS traffic           
  to_port           = 443         
  protocol          = "tcp"           
  cidr_blocks       = [var.my_ip_address]
  security_group_id = aws_security_group.webpage.id  
}

# Rule for outbound traffic
resource "aws_security_group_rule" "web_outbound" {
  type              = "egress"  # Type of rule (egress for outbound traffic)
  from_port         = 0         # Wildcard value allows all outbound traffic
  to_port           = 0               
  protocol          = "-1"      # "-1" allows all outbound traffic from the security group
  cidr_blocks       = [var.my_ip_address]
  security_group_id = aws_security_group.webpage.id 
}