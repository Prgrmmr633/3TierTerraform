# Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each   = var.private_subnets
  vpc_id     = data.aws_vpc.default.id
  cidr_block = cidrsubnet(data.aws_vpc.default.cidr_block, 8, each.value)

  tags = {
    Terraform = true
  }
}

# Security Groups
resource "aws_security_group" "sg_prgrmmr_633_development" {
  name        = "sg_prgrmmr_633_development"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description = "SSH Inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.250.0/24", "120.29.76.169/32"]
  }
  egress {
    description = "Global Outbound"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "sg_prgrmmr_633_development"
    Purpose = "For development"
  }
}

resource "aws_instance" "sg_prgrmmr_633_development" {
  ami                         = "ami-0b029b1931b347543"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnets["sg_prgrmmr_633_development"].id
  security_groups             = [aws_security_group.sg_prgrmmr_633_development.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.prgrmmr_633.key_name
  #   iam_instance_profile        = "CloudWatchAgentServerPolicy"

  tags = {
    Name = "prgrmmr_633-development"
  }
}