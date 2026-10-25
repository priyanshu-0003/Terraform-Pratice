resource "aws_instance" "bitu" {
    ami = "ami-0829b74b2a8c619b7"
    instance_type = "t3.micro"
    subnet_id = "subnet-0db59298c480cd3f3"
}