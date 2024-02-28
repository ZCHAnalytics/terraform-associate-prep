data "aws_ami" "web_ami" {  # Data source for retrieving the latest Bitnami Tomcat AMI
  most_recent = true
  filter {                  # Filter AMIs by name
    name   = "name_regex"
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

module "web_sg_new" {
  source  = "terraform-aws-modules/security-group/aws"
  name    = "new_sg"
  vpc_id  = module.web_vpc.vpc_id
# Rule for HTTP-inbound traffic
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  security_group_id   = module.web_sg_new.security_group_id # ID of the security group
}
# Resource definition for launching an EC2 instance
resource "aws_instance" "web_app" {       
  ami           = data.aws_ami.web_ami.id # Use the AMI retrieved from the data source
  instance_type = var.instance_type       # Specify the instance type using a variable
  vpc_security_group_ids = [module.web_sg_new.security_group_id]  
  subnet_id = module.web_vpc.public_subnets[0]
}
# Add load balancer 
module "alb"  {
  source = "terraform-aws-modules/alb/aws"
  name    = "my-alb"
  vpc_id  = module.web_vpc.vpc_id
  load_balancer_type = "application"
  subnets = module.web_vpc.public_subnets
  security_groups = [module.web_sg_new.security_group_id]
  target_groups = [
    {
      name_prefix      = "web"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target  = {
          target_id = aws_instance.web_app.id
          port = 80 
        }
      }
    }  
  ]
  http_tcp_listeners = [
    {
      port                = "80"
      protocol            = "HTTP"
      target_group_index  = 0
    }
  ]
  tags = {
    Environment = "dev"
  }
}


