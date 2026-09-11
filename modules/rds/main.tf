resource "aws_security_group" "rds" {
  name        = "phase6-rds-sg"
  description = "Allow PostgreSQL only from application EC2"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from application"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phase6-rds-sg"
  }
}

resource "aws_db_subnet_group" "this" {
  name = "phase6-rds-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "phase6-rds-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "phase6-postgres"

  engine = "postgres"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 7

  deletion_protection = false

  skip_final_snapshot = true

  tags = {
    Name = "phase6-postgres"
  }
}