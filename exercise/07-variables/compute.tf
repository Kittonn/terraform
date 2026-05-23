data "aws_ami" "ubuntu_ami" {
  most_recent = true

  # To find the AMI Owner ID, you can use the following AWS CLI command:
  # aws ec2 describe-images \
  #   --image-ids ami-02dd44faa40720bb8 \
  #   --region ap-southeast-1 \
  #   --query 'Images[0].OwnerId'
  owners = ["099720109477"]

  # To find the AMI Name, you can use the following AWS CLI command:
  # aws ec2 describe-images \
  #   --image-ids ami-02dd44faa40720bb8 \
  #   --region ap-southeast-1 \
  #   --query 'Images[0].Name'
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
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.ec2_volume_config.volume_size
    volume_type           = var.ec2_volume_config.volume_type
    delete_on_termination = true
  }

  tags = merge(local.common_tags, var.additional_tags)
}
