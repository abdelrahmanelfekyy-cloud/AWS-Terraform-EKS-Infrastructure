resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true  
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true 

  tags = {
    Name                     = "${var.environment}-public-${var.availability_zones[count.index]}"
    "kubernetes.io/role/elb" = "1" 
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                              = "${var.environment}-private-${var.availability_zones[count.index]}"
    "kubernetes.io/role/internal-elb" = "1" 
  }
}


resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.environment}-nat-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id 

  tags = {
    Name = "${var.environment}-nat-gw"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.environment}-public-rt" }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "${var.environment}-private-rt" }
}

# 9. ربط الـ Subnets بجداول التوجيه بتاعتها
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}