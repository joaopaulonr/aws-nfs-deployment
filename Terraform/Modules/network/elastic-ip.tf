resource "aws_eip" "linux_instance_server_eip" {
  instance   = var.linux_id
}

resource "aws_eip" "linux_instance_client_eip" {
  instance   = var.client_id
}