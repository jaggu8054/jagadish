
# step :vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.100.0.0/16"
  tags ={
    name = "newserver"
  }

}
#step 2 :subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.100.1.0/24"
}

#step3 :private subnet 
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.100.2.0/24"
}
# step4 : internet 
resource "aws_internet_gateway" "isw" {
  vpc_id = aws_vpc.myvpc.id
}
# step 4 :route table

resource "aws_route_table" "table" {
  vpc_id = aws_vpc.myvpc.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.isw.id}"
  }
  tags = {
    Name = "MyRoute"
  }
}

