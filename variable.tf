variable "aws_instance_type" {
  description = "Type of AWS instance to create"
  type        = string
  default     = "t2.micro"
}

variable "root_store_size"{
    description = "Size of the root block device in GB"
    type        = number
    default     = 12
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "aws_ami_id" {
  description = "AMI ID for the AWS instance"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
  
}