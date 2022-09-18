output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = data.aws_region.current.name
}

output "instance_ip_addr" {
  value = aws_instance.web.private_ip
}

output "private_subnet" {
  value       = aws_instance.web.subnet_id
}