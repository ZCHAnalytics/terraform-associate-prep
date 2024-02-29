variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro" # Provides 1 vCPU and 1 GiB of memory. Just about enough for this project!
}

variable "my_ip_address" {
  type        = string
  description = "The IP address to be used"
}

variable "environment" {
  description = "Deployment environment"
  type = object({
    network_prefix = string
  })
  default = {
    name           = "dev"
    network_prefix = "10.0"
  }
}

variable "asg_min" {
  description = "Minimum instance count for the ASG"
  default     = 1
}

variable "asg_max" {
  description = "Maximum instance count for the ASG"
  default     = 2
}