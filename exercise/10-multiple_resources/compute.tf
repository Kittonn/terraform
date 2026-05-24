locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu_ami.id
    nginx  = data.aws_ami.nginx_ami.id
  }
}

data "aws_ami" "ubuntu_ami" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "nginx_ami" {
  most_recent = true

  owners = ["679593333241"]

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.31.0-*-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_instance_from_count" {
  count                       = var.ec2_instance_count
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.subnet[count.index % length(aws_subnet.subnet)].id

  tags = {
    Name = "demo-ec2-instance-${count.index + 1}"
  }
}

resource "aws_instance" "ec2_instance_from_list" {
  count                       = length(var.ec2_instance_config)
  ami                         = local.ami_ids[var.ec2_instance_config[count.index].ami]
  instance_type               = var.ec2_instance_config[count.index].instance_type
  subnet_id                   = aws_subnet.subnet[count.index % length(aws_subnet.subnet)].id
  associate_public_ip_address = true

  tags = {
    Name = "demo-ec2-instance-list-${count.index + 1}"
  }
}

resource "aws_instance" "ec2_instance_from_map" {
  for_each                    = var.ec2_instance_config_map
  ami                         = local.ami_ids[each.value.ami]
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.subnet_from_map[each.value.subnet_name].id
  associate_public_ip_address = true

  tags = {
    Name = "demo-ec2-instance-map-${each.key}"
  }
}
