resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-main-route-table"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.main.id
}

### public subnet
resource "aws_subnet" "public_alb_1a" {
  cidr_block              = var.public_subnet_alb_1a_cidr_block
  vpc_id                  = var.vpc_id
  availability_zone       = var.subnet_az_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_alb_1b" {
  cidr_block              = var.public_subnet_alb_1b_cidr_block
  vpc_id                  = var.vpc_id
  availability_zone       = var.subnet_az_1b
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-public-subnet-1b"
  }
}

resource "aws_route_table" "public_alb" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-public-route-table"
  }
}

resource "aws_route_table_association" "public_alb_1a" {
  subnet_id      = aws_subnet.public_alb_1a.id
  route_table_id = aws_route_table.public_alb.id
}

resource "aws_route_table_association" "public_alb_1b" {
  subnet_id      = aws_subnet.public_alb_1b.id
  route_table_id = aws_route_table.public_alb.id
}

resource "aws_route" "public_alb" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public_alb.id
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_nat_gateway" "ng" {
  // public subnetに作成する
  subnet_id     = aws_subnet.public_alb_1a.id
  allocation_id = var.eip_nat_1a_id

  tags = {
    Name = "${var.name_prefix}-ng"
  }
}

### private subnet
resource "aws_subnet" "private_ec2_1a" {
  cidr_block              = var.private_subnet_alb_1a_cidr_block
  vpc_id                  = var.vpc_id
  availability_zone       = var.subnet_az_1a
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name_prefix}-private-subnet-1a"
  }
}

resource "aws_route_table" "private_ec2" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-private-route-table"
  }
}

resource "aws_route_table_association" "private_ec2_1a" {
  subnet_id      = aws_subnet.private_ec2_1a.id
  route_table_id = aws_route_table.private_ec2.id
}

resource "aws_route" "private_ec2" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_ec2.id
  nat_gateway_id         = aws_nat_gateway.ng.id
}
