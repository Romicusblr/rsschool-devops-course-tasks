resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu_22.id
  instance_type          = "t3.nano"
  key_name               = aws_key_pair.key.key_name
  private_ip             = cidrhost(aws_subnet.public[0].cidr_block, 10)
  subnet_id              = element(aws_subnet.public[*].id, 0)
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = merge(local.common_tags, {
    Name = "bastion"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
