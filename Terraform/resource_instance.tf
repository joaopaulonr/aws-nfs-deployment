resource "aws_instance" "linux_instance" {
    ami = "ami-00c6177f250e07ec1"
    instance_type = "t3.small"
    key_name = "linux"
    subnet_id = aws_subnet.linux_subnet_public.id
    vpc_security_group_ids = [aws_security_group.linux_security_group.id]
    associate_public_ip_address = true
    user_data = "${file("../Scripts/service.sh")}"
    
    launch_template {
      id = aws_launch_template.linux_template.id
    }
    
    root_block_device {
      volume_size = 16
      volume_type = "gp3"
    }
}

resource "aws_instance" "client_instance" {
    ami = "ami-00c6177f250e07ec1"
    instance_type = "t2.micro"
    key_name = "linux"
    subnet_id = aws_subnet.linux_subnet_public.id
    vpc_security_group_ids = [aws_security_group.client_security_group.id]
    associate_public_ip_address = true
    user_data = "${file("../Scripts/client.sh")}"
    
    launch_template {
      id = aws_launch_template.linux_template.id
    }

    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }
}