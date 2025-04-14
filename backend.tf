terraform {
  backend "s3" {
    bucket       = "modular-terraform-bucket-state-degen"
    key          = "terraform/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}