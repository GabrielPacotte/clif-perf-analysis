resource "aws_vpc" "main_vpc" {
    cidr_block = "11.0.0.0/24"

    tags = {
        Project = "TP-Perfs"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "11.0.0.128/25"

    availability_zone = "eu-west-3a"

    tags = {
        Project = "TP-Perfs"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Project = "TP-Perfs"
    }
}

resource "aws_route_table" "main_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main_rt.id
}
