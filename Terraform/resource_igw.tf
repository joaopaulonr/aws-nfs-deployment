resource "aws_internet_gateway" "linux_igw" {
  vpc_id = aws_vpc.linux_vpc.id
  tags = {
    Name = "linux_igw"
  }
}