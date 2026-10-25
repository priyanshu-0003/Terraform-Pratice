resource "aws_instance" "name" {
     ami = "ami-0829b74b2a8c619b7"
    instance_type = "t3.micro"
    subnet_id = subnet-0db59298c480cd3f3
}  #impoerted the instance using the command terraform import aws_instance.name i-0f3e7b8c9d1e2f3a4.


resource "aws_s3_bucket" "dev" {
    bucket = "david-martin"
}  #impoerted the bucket using the command terraform import aws_s3_bucket.dev david-martin.