resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true


    tags = {
    Name = "myvpc"
  }
  
}

resource "aws_internet_gateway" "myvpcigw" {

    vpc_id = aws_vpc.myvpc.id
    depends_on = [
      aws_vpc.myvpc
    ]
  
}

resource "aws_subnet" "pubsubnets" {
  
  vpc_id     = aws_vpc.myvpc.id
  count = length(var.vpc_sub_pub)
  cidr_block = element(var.vpc_sub_pub,count.index)
  availability_zone = element(var.azones,count.index)
  map_public_ip_on_launch = true


  tags = {
    Name = "Public Subnets"
  }
}

resource "aws_subnet" "prisubnets" {
  vpc_id     = aws_vpc.myvpc.id
  count = length(var.vpc_sub_pri)
  cidr_block = element(var.vpc_sub_pri,count.index)
  availability_zone = element(var.azones,count.index)

  tags = {
    Name = "Private Subnets"
  }
}

resource "aws_route_table" "pub_route_table" {
    vpc_id = aws_vpc.myvpc.id

  
}

resource "aws_route" "mypubroute" {
    route_table_id = aws_route_table.pub_route_table.id
    depends_on = [
      aws_route_table.pub_route_table
    ]
    destination_cidr_block = var.opentointernet
    gateway_id = aws_internet_gateway.myvpcigw.id
  
}

resource "aws_route_table_association" "pubassoc" {
  
  count = length(var.vpc_sub_pub)
  route_table_id = aws_route_table.pub_route_table.id
  subnet_id = element(aws_subnet.pubsubnets.*.id,count.index)

  
}

resource "aws_eip" "myeip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.myvpcigw
  ]

}

resource "aws_nat_gateway" "mynat" {
  subnet_id = element(aws_subnet.pubsubnets.*.id,0)
  depends_on = [
    aws_internet_gateway.myvpcigw
  ]
  allocation_id = aws_eip.myeip.id
  
    
}

resource "aws_route_table" "pri_route_table" {
  vpc_id = aws_vpc.myvpc.id
  depends_on = [
    aws_vpc.myvpc
  ]
}

resource "aws_route" "mypriroute" {
  route_table_id = aws_route_table.pri_route_table.id
  nat_gateway_id = aws_nat_gateway.mynat.id 
  depends_on = [
    aws_route_table.pri_route_table
  ] 
  destination_cidr_block = var.opentointernet
}

resource "aws_route_table_association" "priassoc" {
  count = length(var.vpc_sub_pri)
  route_table_id = aws_route_table.pri_route_table.id
  subnet_id = element(aws_subnet.prisubnets.*.id,count.index)

  
}

resource "aws_security_group" "vpcsecgrp" {

 name = "vpc_sec_grp"
 description = "VPC security group"
 vpc_id = aws_vpc.myvpc.id

   ingress {
    description      = "SSH into VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.opentointernet]
    
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.opentointernet]
   
  }

}



