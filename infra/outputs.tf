output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer — open this in a browser"
  value       = aws_lb.web.dns_name
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Map of AZ -> subnet ID for all public subnets created via for_each"
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "alb_security_group_id" {
  description = "Security group ID attached to the ALB"
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "Security group ID attached to the EC2 instances"
  value       = aws_security_group.ec2.id
}

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = aws_lb_target_group.web.arn
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "ami_id" {
  description = "AMI ID resolved by the data source and used in the launch template"
  value       = data.aws_ami.amazon_linux.id
}
