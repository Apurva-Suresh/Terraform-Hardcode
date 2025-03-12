#DB subnet group
resource "aws_db_subnet_group" "twot-db-sg" {
  name       = "twot-db-sg"
  subnet_ids = ["aws_subnet.privsub_1.id, aws_subnet.privsub_2.id"]

  tags = {
    Name = "Twot-DB subnet group"
  }
}

#MySQL RDS Database
resource "aws_db_instance" "twot_db" {
  allocated_storage      = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"
  storage_type           = "gp2"
  identifier             = "mydb"
  username               = "admin"
  password               = "admin123"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  availability_zone      = "us-east-1a"
  port                   = 3306
  db_subnet_group_name   = aws_db_subnet_group.twot-db-sg.id
  multi_az               = false
  vpc_security_group_ids = ["aws_security_group.db_sg"]
}
