# Will populate outputs from modules like VPC ID, public IPs, etc.
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "web_sg_id" {
  value = module.security_group.security_group_id
}

output "ec2_public_ip" {
  value = module.ec2_instance.public_ip
}
