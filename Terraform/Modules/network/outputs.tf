output "vpc_id" {
    value = aws_vpc.linux_vpc.id
}

output "subnet_id" {
    value = aws_subnet.linux_subnet_public.id
}