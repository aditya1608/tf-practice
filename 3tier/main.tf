provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "tt" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "tt"
    }
}

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public1"
    }
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.16.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "public2"
    }
}

resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.128.0/24"  
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "private1"
    }
}

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.144.0/24"  
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "private2"
    }
}

resource "aws_subnet" "private3" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.160.0/24"  
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "private3"
    }
}

resource "aws_subnet" "private4" {
    vpc_id = aws_vpc.tt.id
    cidr_block = "10.0.176.0/24"  
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "private4"
    }
}

resource "aws_internet_gateway" "ig-public" {
    vpc_id = aws_vpc.tt.id
    tags = {
        Name = "ig_public"
    }   
}

resource "aws_route_table" "rt-main-public" {
    vpc_id = aws_vpc.tt.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig-public.id
    } 
    tags = {
        Name = "rt-main-public" 
    }
}

resource "aws_main_route_table_association" "main-rt" {
    vpc_id = aws_vpc.tt.id
    route_table_id = aws_route_table.rt-main-public.id
}

resource "aws_route_table_association" "rt-pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rt-main-public.id
}

resource "aws_route_table_association" "rt-pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rt-main-public.id
}

resource "aws_eip" "nat-eip" {
    domain = "vpc"  
}

resource "aws_nat_gateway" "public-nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.public1.id
    tags = {
        Name = "nat-gw"
    } 
}

resource "aws_route_table" "rt-private" {
    vpc_id = aws_vpc.tt.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.public-nat.id
    } 
    tags = {
        Name = "rt-private" 
    }
}

resource "aws_route_table_association" "rt-pvt1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_route_table_association" "rt-pvt2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_route_table_association" "rt-pvt3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_route_table_association" "rt-pvt4" {
  subnet_id      = aws_subnet.private4.id
  route_table_id = aws_route_table.rt-private.id
}

