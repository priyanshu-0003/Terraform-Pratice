resource "aws_instance" "name" {
    ami = "ami-0d27e0fb3bac4d7245"
    instance_type = "t2.micro"
    availability_zone = "us-east-1b"
    tags = {
        Name = "nit"
    }

  
#   lifecycle {
#     ignore_changes = [tags]
#   }
lifecycle {
  create_before_destroy = true
}

# lifecycle {
#    prevent_destroy = true
# }
}