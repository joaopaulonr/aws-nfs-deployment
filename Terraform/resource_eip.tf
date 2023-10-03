resource "aws_eip" "linux_instance_server_eip" {
    instance = "${aws_instance.linux_instance.id}"
    depends_on = [ aws_internet_gateway.linux_igw ]
}
resource "aws_eip" "linux_instance_client_eip" {
    instance = "${aws_instance.client_instance.id}"
    depends_on = [ aws_internet_gateway.linux_igw ]
}