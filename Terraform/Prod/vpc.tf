resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "prod_vpc"
  }
}

resource "aws_subnet" "prod_public_subnet_1" {
  vpc_id                  = aws_vpc.prod_vpc.id
  availability_zone       = "ca-central-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_subnet" "prod_public_subnet_2" {
  vpc_id                  = aws_vpc.prod_vpc.id
  availability_zone       = "ca-central-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "prod_public_subnet"
  }
}

resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod_igw"
  }
}

resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }
}
resource "aws_route_table_association" "prod_rta_public_subnet_1" {
  count          = 1
  subnet_id      = aws_subnet.prod_public_subnet_1.id
  route_table_id = aws_route_table.prod_rt.id
}

resource "aws_route_table_association" "prod_rta_public_subnet_2" {
  count          = 1
  subnet_id      = aws_subnet.prod_public_subnet_2.id
  route_table_id = aws_route_table.prod_rt.id
}