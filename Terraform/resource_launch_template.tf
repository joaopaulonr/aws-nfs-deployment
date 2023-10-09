resource "aws_launch_template" "linux_template" {

  placement {
    availability_zone = "us-east-1a"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name       = "linux-nfs-nginx"
      Project    = "PB UFC"
      CostCenter = "C092000004"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name       = "linux-nfs-nginx"
      Project    = "PB UFC"
      CostCenter = "C092000004"
    }
  }
}