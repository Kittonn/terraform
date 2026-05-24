locals {
  instance_type = "t3.micro"
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


resource "aws_instance" "ec2_instance" {
  instance_type = local.instance_type

  ami = data.aws_ami.ubuntu_ami.id

  subnet_id = module.vpc.public_subnets["public"].subnet_id

  tags = {
    Name = "ec2-instance-demo"
  }
}
