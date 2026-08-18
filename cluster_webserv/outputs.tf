output "public_ips" {
  description = "Public IP addresses of all instances in ASG"
  value       = data.aws_instances.asg_instances.public_ips
}