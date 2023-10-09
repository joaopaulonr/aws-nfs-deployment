resource "aws_route_table" "linux_rt" {
  vpc_id = aws_vpc.linux_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.linux_igw.id
  }
  tags = {
    Name = "linux_rt"
  }
}