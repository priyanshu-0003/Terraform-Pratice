terraform {
  backend "s3" {
    bucket       = "david-martin-1"
    key          = "dev/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}