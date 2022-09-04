# My Vpc
resource "aws_vpc" "Yaa-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Yaa-vpc"
  }
}
  
# Public Subnet 1
resource "aws_subnet" "public_sub1" {
  vpc_id     = aws_vpc.Yaa-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_sub1"
  }
}

# Public Subnet 2
resource "aws_subnet" "public_sub2" {
  vpc_id     = aws_vpc.Yaa-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_sub2"
  }
}
# Private Subnet 1
resource "aws_subnet" "private_sub1" {
  vpc_id     = aws_vpc.Yaa-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private_sub1"
  }
}
# Private Subnet 2
resource "aws_subnet" "private_sub2" {
  vpc_id     = aws_vpc.Yaa-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private_sub2"
  }
}

# Route Table Public
resource"aws_route_table" "Public-route-table" {
  vpc_id = aws_vpc.Yaa-vpc.id

  tags = {
    Name = "Public-route-table"
  }
}

# Route Table Private
resource "aws_route_table" "Private-route-table" {
  vpc_id = aws_vpc.Yaa-vpc.id

  tags = {
    Name = "Private-route-table"
  }
}

# route table association public
resource "aws_route_table_association" "Public-route-table-association-1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.Public-route-table.id
}

# route table association public
resource "aws_route_table_association" "Public-route-table-association-2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.Public-route-table.id
}

# route table association private
resource "aws_route_table_association" "Private-route-table-association-1" {
  subnet_id      = aws_subnet.private_sub1.id
  route_table_id = aws_route_table.Private-route-table.id
}

# route table association private
resource "aws_route_table_association" "Private-route-table-association-2" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.Private-route-table.id
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Yaa-vpc.id

  tags = {
    Name = "IGW"
  }
}

# Aws route
resource "aws_route" "Public-igw-route" {
  route_table_id            = aws_route_table.Public-route-table.id
  gateway_id                = aws_internet_gateway.IGW.id
  destination_cidr_block    = "0.0.0.0/0"
}

