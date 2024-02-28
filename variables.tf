variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}

variable "ip_address" {
  type        = string
  description = "The IP address to be used"
}
