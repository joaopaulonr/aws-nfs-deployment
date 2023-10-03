resource "aws_security_group" "linux_security_group" {
    name        = "allow_Protocols"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.linux_vpc.id
    ingress {
    description = "Regra SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }  
    ingress {
    description = "NFS"
    from_port        = 111
    to_port          = 111
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
        ingress {
    description = "NFS"
    from_port        = 111
    to_port          = 111
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description = "NFS"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description = "NFS"
    from_port        = 2049
    to_port          = 2049
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    }    
    ingress {
    description = "Regra HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description = "Regra HTTPs"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description = "Regra ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    tags = {
      Name = "linux_group"
    }
}

resource "aws_security_group" "client_security_group" {
    name        = "allow_Protocols_client"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.linux_vpc.id
    ingress {
    description = "Regra SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }  
    ingress {
    description = "Regra ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    tags = {
      Name = "client_group"
    }
}