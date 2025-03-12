resource "aws_vpc" "twot_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "twot_vpc"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "twot_igw" {
  vpc_id = aws_vpc.twot_vpc.id

  tags = {
    Name = "twot_igw"
  }
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.twot_igw.id
  vpc_id              = aws_vpc.twot_vpc.id
}

#Public-Subnet-1
resource "aws_subnet" "pubsub_1" {
  vpc_id     = aws_vpc.twot_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet-1"
  }
}

#Public-Subnet-2
resource "aws_subnet" "pubsub_2" {
  vpc_id     = aws_vpc.twot_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public-Subnet-2"
  }
}

#Private-Subnet-1
resource "aws_subnet" "privsub_1" {
  vpc_id     = aws_vpc.twot_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Private-Subnet-1"
  }
}

#Private-Subnet-2
resource "aws_subnet" "privsub_2" {
  vpc_id     = aws_vpc.twot_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private-Subnet-2"
  }
}

#Public Route Table
resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.twot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.twot_igw.id
  }

  tags = {
    Name = "Public RT"
  }
}

#Route Table Association to both Pub-Sub-1 and Pub-Sub-2
resource "aws_route_table_association" "rt_pubsub_1" {
  subnet_id      = aws_subnet.pubsub_1.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_route_table_association" "rt_pubsub_2" {
  subnet_id      = aws_subnet.pubsub_2.id
  route_table_id = aws_route_table.pubrt.id
}
