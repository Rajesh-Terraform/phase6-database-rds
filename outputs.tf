output "app_instance_id" {
  value = module.app.instance_id
}

output "app_private_ip" {
  value = module.app.private_ip
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_port" {
  value = module.rds.port
}

output "database_name" {
  value = module.rds.database_name
}