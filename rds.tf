resource "aws_db_instance" "MY_RDS" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.user
  password             = var.passwd
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.dbsg.id,]
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet.*.id]
  tags = {
    Name = "DB_subnet_group"
  }
}