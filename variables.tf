variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "Existing spoke VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "Existing spoke VPC CIDR"
  type        = string
}

variable "private_subnet_ids" {
  description = "Existing spoke private subnet IDs"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "Provide at least two private subnet IDs."
  }
}

variable "app_subnet_id" {
  description = "Private subnet where EC2 application will run"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_name" {
  type    = string
  default = "practiceapp"
}

variable "db_username" {
  type    = string
  default = "appadmin"
}

variable "db_password" {
  type      = string
  sensitive = true
}