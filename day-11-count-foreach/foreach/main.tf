variable "bitu" {
  type = list(string)
  default = ["dev", "prod"]
}



resource "aws_instance" "bitu" {
    ami = "ami-0829b74b2a8c619b7"
    instance_type = "t2.medium"
    for_each=toset(var.bitu)
    tags = {
        Name = each.key
    }
}
# it is used as create and destroy the resources based on the changes in the variable. If we remove any value from the variable, it will destroy that resource and if we add any value to the variable, it will create that resource.