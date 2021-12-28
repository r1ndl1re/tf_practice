locals {
  sample_sg_rule = {
    ## [ type, from_port, to_port, protocol, sg-id, cidr_blocks, description ]
    "rule_2" = ["egress", 0, 0, "-1", null, ["0.0.0.0/0"], "Allow any outbound traffic"]
    "rule_1" = ["ingress", 80, 80, "tcp", null, ["0.0.0.0/0"], "HTTP from Internet"]
  }
}

resource "aws_vpc" "sample_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "sample_vpc"
  }
}

resource "aws_subnet" "sample_subnet" {
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id
}

resource "aws_route_table" "sample_rtb" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }
}

# ルートテーブルに紐付け
resource "aws_route_table_association" "sample_rtb_asso" {
  subnet_id      = aws_subnet.sample_subnet.id
  route_table_id = aws_route_table.sample_rtb.id
}

resource "aws_security_group" "sample_sg" {
  name_prefix = "sample_sg"
  vpc_id      = aws_vpc.sample_vpc.id
  description = "sample security group"
  tags = {
    "Name" = "sample_sg"
  }
}

resource "aws_security_group_rule" "sample_sg_rule" {
  security_group_id        = aws_security_group.sample_sg.id
  for_each                 = local.sample_sg_rule
  type                     = each.value[0]
  from_port                = each.value[1]
  to_port                  = each.value[2]
  protocol                 = each.value[3]
  source_security_group_id = each.value[4]
  cidr_blocks              = each.value[5]
  description              = each.value[6]
}
