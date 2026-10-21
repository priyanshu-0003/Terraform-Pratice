resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  depends_on = [ aws_s3_bucket.name ]
}

resource "aws_s3_bucket" "name" {
    bucket = "veera-test-nareshit"
  
}
# it should be noted that the aws_vpc resource has a dependency on the aws_s3_bucket resource. This means that the VPC will only be created after the S3 bucket has been successfully created. The depends_on argument is used to explicitly specify this dependency, ensuring that Terraform creates the resources in the correct order.