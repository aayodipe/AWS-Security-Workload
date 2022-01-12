provider "aws"{
    region ="us-west-2"
}
//Variables
variable cornel-server-ports {
    type = list(number)
    default = [ 22,80,443 ]
}
#vpc deployment
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "cornel_dev_vpc"
  }
}
//Private Subnets
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private-Subnet"
  }
}
//Public Subnet
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet"
  }
}

#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Cornel-IGW"
  }
}


#NACL

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id
 subnet_ids = ["subnet-0b02b7511226286c7", "subnet-0d4f855af43d53b04"]
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = var.cornel-server-ports[0]
    to_port    = var.cornel-server-ports[0]
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = var.cornel-server-ports[0]
    to_port    = var.cornel-server-ports[0]
  }

  tags = {
    Name = "cornel-ACL"
  }
}


#Instance

resource "aws_instance" "web" {
  ami           = "ami-066333d9c572b0680"
  instance_type = "t2.micro"

  subnet_id   = aws_subnet.public1.id
  associate_public_ip_address = true
  tags = {
    Name = "Cornel-Bastion"
  }
}


resource "aws_instance" "Private1" {
  ami           = "ami-066333d9c572b0680"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.private1.id
  tags = {
    Name = "Cornel-File Server"
  }
}

resource "aws_instance" "Private2" {
  ami           = "ami-066333d9c572b0680"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.private1.id
  tags = {
    Name = "Cornel-Web Server"
  }
}

resource "aws_instance" "Private3" {
  ami           = "ami-066333d9c572b0680"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.private1.id
  tags = {
    Name = "Cornel-Application Server"
  }
}