module "app" {
  source = "./modules/app"

  vpc_id        = var.vpc_id
  subnet_id     = var.app_subnet_id
  instance_type = var.instance_type
}

module "ssm" {
  source = "./modules/ssm"

  vpc_id             = var.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = var.private_subnet_ids
}

module "rds" {
  source = "./modules/rds"

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  app_security_group_id = module.app.security_group_id
}