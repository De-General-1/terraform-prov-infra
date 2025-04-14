vpc_cidr = "10.0.0.0/16"

vpc_name = "modular-vpc-terra"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]

ami_id   = "ami-0df368112825f8d8f"
key_name = "web-keyPair"
cluster_name = "modular-eks-cluster"
bucket_name= "modular-terraform-bucket-state-degen"
instance_type = "t2.micro"
aws_region = "eu-west-1"