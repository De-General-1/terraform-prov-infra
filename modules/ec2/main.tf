resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.key_name
  associate_public_ip_address = true

  user_data     = <<-EOF
    #!/bin/bash
    set -e
    # Update and upgrade system packages
    apt update -y
    apt upgrade -y
    # Install Docker
    if ! command -v docker &> /dev/null; then
      curl -fsSL https://get.docker.com -o get-docker.sh
      sh get-docker.sh
      rm get-docker.sh
    fi
    # Start and enable Docker service
    systemctl start docker
    systemctl enable docker
    # Add current user to the docker group (non-root Docker use)
    usermod -aG docker ubuntu
    # Run nginx container in detached mode
    docker run -d -p 80:80 nginx
  EOF

  tags = {
    Name = var.name
  }
}
