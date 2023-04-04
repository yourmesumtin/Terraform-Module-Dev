#----------database/main.tf---------------
resource "aws_db_instance" "your_db" {
  allocated_storage      = var.db_storage
  db_name                = var.dbname
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.dbuser
  password               = var.dbpassword
  skip_final_snapshot    = var.skip_db_snapshot
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.db_identifier
  tags = {
    Name = "your-db"
  }

}