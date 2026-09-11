resource "aws_security_group" "ssm" {
  name        = "phase6-ssm-endpoint-sg"
  description = "Allow HTTPS from private VPC resources"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phase6-ssm-endpoint-sg"
  }
}

locals {
  ssm_services = [
    "ssm",
    "ssmmessages",
    "ec2messages"
  ]
}

resource "aws_vpc_endpoint" "ssm" {
  for_each = toset(local.ssm_services)

  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${data.aws_region.current.name}.${each.value}"

  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_subnet_ids

  security_group_ids = [
    aws_security_group.ssm.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "phase6-${each.value}"
  }
}

data "aws_region" "current" {}