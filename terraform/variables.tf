variable "key_pair_name" {
  description = "EC2 SSH Key Pair name"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your local IP in CIDR format (ex. 1.2.3.4/32)"
  type        = string
}

variable "project_tag" {
  description = "Common project name tag"
  type        = string
}