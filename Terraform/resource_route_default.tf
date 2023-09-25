resource "aws_route" "pratica_default_rt" {
    route_table_id = aws_route_table.linux_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.linux_igw.id
}