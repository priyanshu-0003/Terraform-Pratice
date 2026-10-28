resource "aws_instance" "name" {
    ami = "ami-002192a70217ac181"
    instance_type = "t3.micro"
    tags = {
        Name = "david-2"
    }
  
}
# here we can create a instance and  use teeraform athen open tofu for migrating the code it saam eas the tofu init,tofupaln,tofu apply.