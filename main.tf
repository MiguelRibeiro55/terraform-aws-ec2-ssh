resource "aws_vpc" "mtc_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "demovpc"

  }
}

resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "demovpc-public"
  }

}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "demovpc-igw"
  }
}

resource "aws_route_table" "mts_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    Name = "demovpc_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mts_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_assoc" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mts_public_rt.id
}

resource "aws_security_group" "mtc_sg" {
  name        = "demovpc_sg"
  description = "demovpc Security Group"
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "mtc_auth" {
    key_name = "mtckey"
    public_key = file("~/.ssh/mtckey.pub")
}

resource "aws_instance" "demovpc_node" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id

  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "demovpc_node"
  }

  provisioner "local-exec" {
  command = templatefile("${path.module}/${var.host_os}-ssh-config.tpl", {
    hostname     = self.public_ip,
    user         = "ubuntu",
    identityfile = var.host_os == "windows" ? "C:/Users/migue/.ssh/mtckey" : "~/.ssh/mtckey"
  })

  interpreter = var.host_os == "windows"? ["PowerShell", "-Command"]: ["bash", "-c"]
}


}







 