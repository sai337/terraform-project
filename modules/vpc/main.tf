###########VPC###########
resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.main.id
}

# Public Subnets
resource "aws_subnet" "public" {
    count = 3

    vpc_id                  = aws_vpc.main.id
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    availability_zone       = element(var.azs, count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-${count.index}"
    }
}

# Private Subnets
resource "aws_subnet" "private" {
    count = 3
    vpc_id                  = aws_vpc.main.id
    cidr_block              = element(var.private_subnet_cidrs, count.index)
    availability_zone       = element(var.azs, count.index)
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-${count.index}"
    }
}

# Public Route Table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
}

# Private Route Tables (one for each private subnet)
resource "aws_route_table" "private" {
    count  = 3
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.ngw, count.index).id
    }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
    count = 3
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# Associate Private Subnets with Private Route Tables
resource "aws_route_table_association" "private" {
    count = 3
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
    count = 3
    vpc   = true
}

# NAT Gateways
resource "aws_nat_gateway" "ngw" {
    count = 3

    allocation_id = aws_eip.nat[count.index].id
    subnet_id     = aws_subnet.public[count.index].id
    depends_on    = [aws_internet_gateway.igw]
}

# Outputs
output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
    value = aws_internet_gateway.igw.id
}

output "nat_gateway_ids" {
    value = aws_nat_gateway.ngw[*].id
}
