variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro" # Provides 1 vCPU and 1 GiB of memory. Just about enough for this project!
}

variable "my_ip_address" {
  type        = string
  description = "The IP address to be used"
}
