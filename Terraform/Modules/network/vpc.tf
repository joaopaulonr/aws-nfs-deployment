resource "aws_vpc" "linux_vpc" {
  cidr_block = "172.21.0.0/16"
  tags = {
    Name = "linux_vpc"
  }
}