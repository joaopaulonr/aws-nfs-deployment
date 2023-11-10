resource "aws_subnet" "linux_subnet_public" {
  vpc_id     = aws_vpc.linux_vpc.id
  cidr_block = "172.21.0.0/24"
  tags = {
    Name = "linux_public_subnet1"
  }
}