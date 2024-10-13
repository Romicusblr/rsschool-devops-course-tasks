resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu_22.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  subnet_id     = element(aws_subnet.private[*].id, 0)

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = merge(local.common_tags, {
    Name = "app"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
