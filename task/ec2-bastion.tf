resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu_22_amd64.id
  instance_type               = "t2.micro" # Free tier eligible
  key_name                    = aws_key_pair.key.key_name
  private_ip                  = cidrhost(aws_subnet.public[0].cidr_block, 10)
  subnet_id                   = element(aws_subnet.public[*].id, 0)
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true # Ensure the instance has a public IP
  source_dest_check           = false

  user_data                   = file("${path.module}/templates/bastion-user-data.sh")
  user_data_replace_on_change = true

  tags = merge(local.common_tags, {
    Name = "bastion"
  })

  lifecycle {
    ignore_changes        = [ami]
  }
}
