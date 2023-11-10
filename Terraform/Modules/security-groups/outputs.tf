output "linux_security_group" {
    value = aws_security_group.linux_security_group.id
}

output "client_security_group" {
    value = aws_security_group.client_security_group.id
}