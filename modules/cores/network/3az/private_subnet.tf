/** 
# Private Subnet
*/
resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_az1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-subnet-${substr(var.az1, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_az2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-subnet-${substr(var.az2, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_subnet" "private_az3" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_az3_cidr
  availability_zone       = var.az3
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-subnet-${substr(var.az3, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}


/** 
# Route Table ( Private )
*/
resource "aws_route_table" "private_az1" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-rt-${substr(var.az1, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_route_table" "private_az2" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-rt-${substr(var.az2, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_route_table" "private_az3" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.common.project}-${var.common.environment}-private-rt-${substr(var.az3, -2, -2)}${var.sfx}"
    Environment = var.common.environment
    Createdby   = "Terraform"
  }
}

resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_az1.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_az2.id
}

resource "aws_route_table_association" "private_az3" {
  subnet_id      = aws_subnet.private_az3.id
  route_table_id = aws_route_table.private_az3.id
}

resource "aws_route" "private_az1" {
  route_table_id         = aws_route_table.private_az1.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_az1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_az2" {
  route_table_id         = aws_route_table.private_az2.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_az2.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_az3" {
  route_table_id         = aws_route_table.private_az3.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_az3.id
  destination_cidr_block = "0.0.0.0/0"
}