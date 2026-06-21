############################################
# General / Region
############################################
variable "aws_region" {
  description = "AWS region to deploy all resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project/name prefix used to tag and name resources"
  type        = string
  default     = "ha-web-app"
}

############################################
# Networking
############################################
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

# Driving variable for for_each: one entry per public subnet.
# Keying by AZ makes each subnet's identity stable and self-describing,
# and lets us add/remove AZs just by editing this map.
variable "public_subnets" {
  description = "Map of public subnets to create, keyed by availability zone"
  type = map(object({
    cidr_block = string
  }))
  default = {
    "us-east-1a" = { cidr_block = "10.20.10.0/24" }
    "us-east-1b" = { cidr_block = "10.20.20.0/24" }
  }
}

variable "map_public_ip_on_launch" {
  description = "Whether instances launched in the public subnets receive a public IP"
  type        = bool
  default     = true
}

############################################
# Security Groups
############################################
variable "alb_ingress_cidr" {
  description = "CIDR block allowed to reach the ALB on port 80"
  type        = string
  default     = "0.0.0.0/0"
}

variable "app_port" {
  description = "Port the web application listens on"
  type        = number
  default     = 80
}

############################################
# Load Balancer / Target Group
############################################
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "web-alb"
}

variable "target_group_health_check" {
  description = "Health check configuration for the ALB target group"
  type = object({
    path                = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    matcher             = string
  })
  default = {
    path                = "/index.html"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

############################################
# Launch Template / ASG
############################################
variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
  default     = "t3.micro"
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = "web-asg"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

############################################
# Tags
############################################
variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project   = "terraform-alb-asg-assignment"
    ManagedBy = "Terraform"
  }
}
