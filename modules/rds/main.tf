resource "aws_db_instance" "default" {
    
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instanceclass
  username             = var.username
  password             = random_password.password.result
  parameter_group_name = "postgresgroup"
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.sgs]
  db_subnet_group_name = aws_db_subnet_group.dbsubnetgroup.name
}

resource "aws_db_subnet_group" "dbsubnetgroup" {
    
  name       = "dbsubgroup"
  subnet_ids = var.dbsubgrp


  tags = {
    Name = "My DB subnet group"
  }
}