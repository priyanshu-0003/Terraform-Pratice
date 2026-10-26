variable "bitu" {
  type = list(string)
  default = ["dev", "prod"]
}



resource "aws_instance" "bitu" {
    ami = "ami-0829b74b2a8c619b7"
    instance_type = "t3.micro"
    count=length(var.bitu)
    tags = {
        Name = var.bitu[count.index]
    }
}
#it will create two instances with the names dev and prod.