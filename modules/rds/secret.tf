resource "aws_secretsmanager_secret" "rds_secret" {
  name  = "database_password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = random_password.password.result
}