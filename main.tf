provider "aws" {
  region = "us-east-1"
  access_key = "AKIAXE7NYYTU3PNDOYVC"
  secret_key = "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"
}


resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"
  tags = {
    "Name" = "wp_vpc"
  }
}

# public subnet for EC2
resource "aws_subnet" "wpsubnet-1" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags = {
    Name = "ec2-subnet"
  }
}

# private subnet for RDS
resource "aws_subnet" "wpsubnet-2" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"

  tags = {
    Name = "rds-subnet-1"
  }
}

# private subnet for RDS
resource "aws_subnet" "wpsubnet-3" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1c"

  tags = {
    Name = "rds-subnet-2"
  }
}

resource "aws_internet_gateway" "terraGW" {
  vpc_id = aws_vpc.wp_vpc.id

}

resource "aws_route_table" "wp_route" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraGW.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id             = aws_internet_gateway.terraGW.id
  }

  tags = {
    Name = "myRouteTable"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.wpsubnet-1.id
  route_table_id = aws_route_table.wp_route.id
}


resource "aws_network_interface" "TerraWebServer" {
  subnet_id       = aws_subnet.wpsubnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.ec2_sg.id]
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.TerraWebServer.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.terraGW]
}

resource "aws_instance" "wp_ec2_terra" {
  ami = "ami-052efd3df9dad4825"
  instance_type = "t2.micro" 
  subnet_id = aws_subnet.wpsubnet-1.id 
  security_groups = [aws_security_group.ec2_sg.id]
  tags = {
    name = "Wordpress-Terra"
  } 
  # depends_on = [aws_db_instance.database] 
}

