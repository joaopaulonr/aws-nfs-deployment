resource "aws_route_table_association" "linux_public_association" {
    subnet_id = aws_subnet.linux_subnet_public.id
    route_table_id = aws_route_table.linux_rt.id
}