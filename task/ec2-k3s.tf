resource "aws_instance" "k3s_master" {
  ami           = data.aws_ami.ubuntu_22_amd64.id
  instance_type = "t2.micro" # Free tier eligible
  key_name      = aws_key_pair.key.key_name
  private_ip    = cidrhost(aws_subnet.private[0].cidr_block, 10)
  subnet_id     = element(aws_subnet.private[*].id, 0)

  vpc_security_group_ids = [aws_security_group.k3s_sg.id]

  tags = merge(local.common_tags, {
    Name = "k3s-master"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_instance" "k3s_worker" {
  count         = var.worker_count
  ami           = data.aws_ami.ubuntu_22_amd64.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name

  # Assign a unique private IP for each worker instance
  private_ip = cidrhost(aws_subnet.private[count.index % length(aws_subnet.private)].cidr_block, 11 + count.index)

  # Assign a subnet in a round-robin fashion
  subnet_id = element(aws_subnet.private[*].id, count.index % length(aws_subnet.private))

  vpc_security_group_ids = [aws_security_group.k3s_sg.id]

  tags = merge(local.common_tags, {
    Name = "k3s-worker-${count.index + 1}"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
