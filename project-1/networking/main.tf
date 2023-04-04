#------networking/main.tf--------

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# generates random values from a given range, This resource can be used in conjunction with resources that have the 
# "create_before_destroy" lifecycle flag set, to avoid conflicts with unique names during the brief period where both the old and new resources exist concurrently.

resource "random_integer" "random" {
  min = 1
  max = 100

}

# generating randomized subsets of AWS availability zones

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

# Create VPC

resource "aws_vpc" "your_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "your_vpc_${random_integer.random.id}"
  }
  # The create_before_destroy Lifecycle Meta Argument, you have resources that will depend your VPC
  lifecycle {
    create_before_destroy = true
  }
}

# Create public and private subnets

resource "aws_subnet" "your_public_subnet" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.your_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "your_public_subnet${count.index + 1}"
  }
}

resource "aws_subnet" "your_private_subnet" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.your_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "your_private_subnet${count.index + 1}"
  }
}

# Create the Internet Gateway

resource "aws_internet_gateway" "your_internet_gateway" {
  vpc_id = aws_vpc.your_vpc.id

  tags = {
    Name = "your_igw"
  }

}

# Create Route Table

resource "aws_route_table" "your_public_rt" {
  vpc_id = aws_vpc.your_vpc.id

  tags = {
    Name = "your_public_route_table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.your_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.your_internet_gateway.id
}

resource "aws_default_route_table" "your_private_rt" {
  default_route_table_id = aws_vpc.your_vpc.default_route_table_id
  tags = {
    Name = "your_private_route_table"
  }
}

resource "aws_route_table_association" "your_public_rt_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.your_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.your_public_rt.id
}

# Create Security Group
resource "aws_security_group" "your_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.your_vpc.id

  # making the security group more Dynamic use dynamic block and for_each

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_db_subnet_group" "your_rds_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0 # it evaluates the variable and if sets to true it creates 1, if set to false it creates 0
  name       = "your_rds_subnetgroup"
  subnet_ids = aws_subnet.your_private_subnet.*.id
  tags = {
    Name = "your_rds_sng"
  }
}
