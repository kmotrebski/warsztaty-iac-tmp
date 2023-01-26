resource "aws_instance" "instance" {

  ami = data.aws_ami.most_recent_amazon_linux_2.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.firewall.id]
  availability_zone = "${data.aws_region.current.name}a"
  key_name = aws_key_pair.deployer.key_name
  iam_instance_profile = aws_iam_instance_profile.ecr_profile.name

  root_block_device {
    volume_type = "gp2"
    volume_size = 60
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "${var.instance_name}-key"
  public_key = var.ssh_key
}
