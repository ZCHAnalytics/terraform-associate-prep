variable "region" {
  type = string
  description = "AWS region"
  default = "eu-west-2"
}

variable "instance_type" {
  description = "The type of EC2 instance used to create the instance."
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "The availability zone where the resources will reside."
  type        = string
  default     = "eu-west-2a"
}

variable "ami" {
  description = "The ID of the Amazon Machine Image (AMI) used to create the EC2 instance."
  type        = string
  default     = "ami-0261755***b8c4a84"
}
variable "instance_type" {
  description = "The type of EC2 instance used to create the instance."
  type        = string
  default     = "t2.micro"
}