data "aws_ami" "web_ami" { # Data source for retrieving the latest Bitnami Tomcat AMI
  most_recent = true
  filter { # Filter AMIs by name
    name   = "name_regex"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }
  filter { # Filter AMIs by virtualization type
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["979382823631"] # Specify the owner of the AMIs
}

module "web_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.environment.name
  cidr   = "${var.environment.network_prefix}.0.0/16"
  azs    = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets = [
    "${var.environment.network_prefix}.101.0/24",
    "${var.environment.network_prefix}.102.0/24",
    "${var.environment.network_prefix}.103.0/24"
  ]
  tags = {
    Terraform   = "true"
    Environment = var.environment.name
  }
}

module "autoscaling" {
  source              = "terraform-aws-modules/autoscaling/aws"
  name                = "web-app"
  min_size            = var.asg_min
  max_size            = var.asg_max
  vpc_zone_identifier = module.web_vpc.public_subnets
  target_group_arns   = module.alb.target_groups_arns
  security_groups     = [module.web_sg_new.security_group_id]
  instance_type       = var.instance_type
  image_id            = data.aws_ami.web_ami.id
}

# Resource definition for launching an EC2 instance
resource "aws_instance" "web_app" {
  ami                    = data.aws_ami.web_ami.id # Use the AMI retrieved from the data source
  instance_type          = var.instance_type       # Specify the instance type using a variable
  vpc_security_group_ids = [module.web_sg_new.security_group_id]
  subnet_id              = module.web_vpc.public_subnets[0]
}

# Add load balancer 
module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 6.0"
  name               = "my-alb"
  load_balancer_type = "application"
  vpc_id             = module.web_vpc.vpc_id

  subnets         = module.web_vpc.public_subnets
  security_groups = [module.web_sg_new.security_group_id]

  target_groups = [
    {
      name_prefix      = "web"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets          = []
    }
  ]
  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type               = "forward"
        target_group_index = 0
      }
    }
  ]

  tags = {
    Environment = "dev"
  }
}
module "web_sg_new" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "new_sg"
  vpc_id = module.web_vpc.vpc_id
  # Rule for HTTP-inbound traffic
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}
