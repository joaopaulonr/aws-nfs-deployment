resource "aws_instance" "linux_instance" {
    ami = "ami-03a6eaae9938c858c"
    instance_type = "t3.small"
    key_name = "vockey"
    subnet_id = aws_subnet.linux_subnet_public.id
    vpc_security_group_ids = [aws_security_group.linux_security_group.id]
    associate_public_ip_address = true
    
    root_block_device {
      volume_size = 16
      volume_type = "gp3"
    }
    
    tags = {
      Name = "linux-nfs-nginx"
    }
}