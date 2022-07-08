resource "aws_db_subnet_group" "rds-subnet" {
  name       = "database subnet"
  subnet_ids = ["${aws_subnet.wpsubnet-2.id}","${aws_subnet.wpsubnet-3.id}"]
}


resource "aws_db_instance" "database" {
  identifier             = "database"
  instance_class         = "db.t2.micro"
  allocated_storage      = 100
  engine                 = "postgres"
  multi_az               =  true
  db_name                = "postgredb"
  username               = "laughtale"
  password               = "onepiece"
  engine_version         = "11.15"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet.name
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
}

