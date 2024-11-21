resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "dev_public_subnet_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  availability_zone = "ca-central-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_subnet" "dev_public_subnet_2" {
  vpc_id     = aws_vpc.dev_vpc.id
  availability_zone = "ca-central-1b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_subnet" "dev_private_subnet_1" {
  vpc_id     = aws_vpc.dev_vpc.id
  availability_zone = "ca-central-1a"
  cidr_block = "10.0.11.0/24"

  tags = {
    Name = "dev_private_subnet"
  }
}

resource "aws_subnet" "dev_private_subnet_2" {
  vpc_id     = aws_vpc.dev_vpc.id
  availability_zone = "ca-central-1b"
  cidr_block = "10.0.12.0/24"

  tags = {
    Name = "dev_private_subnet"
  }
}

/*resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_igw"
  }
}

resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
}
resource "aws_route_table_association" "dev_rta" {
  count          = 1
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}*/