variable "ami" {
  description = "ami for the instance"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tag" {
  description = "tags to be placed on resources"
  type        = string
  default     = "EC2 Project"
}

variable "region" {
  description = "region of aws account"
  type        = string
  default     = "us-east-1"
}






