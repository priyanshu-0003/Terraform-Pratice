module "dev" {
    source = "../day-6-ec2-module/"
    ami_id  = var.ami_id          #module-variable = var.local-variable 
    instance_type = var.instance_type
  
  
}
