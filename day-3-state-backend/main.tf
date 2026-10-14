resource "aws_instance" "name" {
    ami = "ami-0c766c2cff1b35ed2"
    instance_type = "t3.micro"  #for free tier eligible t3.micro
    subnet_id = "subnet-0db59298c480cd3f3"
    tags = {
        Name = "bitu"
    }

  
}
