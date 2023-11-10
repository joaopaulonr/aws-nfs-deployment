output "linux_id" {
    value = aws_instance.linux_instance.id
}

output "client_id" {
  value = aws_instance.client_instance.id
}