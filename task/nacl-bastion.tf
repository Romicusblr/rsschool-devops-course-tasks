resource "aws_network_acl" "bastion_acl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "bastion-acl"
  }
}

# Allow inbound SSH traffic (port 22) from any IP address
resource "aws_network_acl_rule" "bastion_inbound_ssh" {
  network_acl_id = aws_network_acl.bastion_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

# Allow inbound ICMP traffic (ping) from any IP address
resource "aws_network_acl_rule" "bastion_inbound_icmp" {
  network_acl_id = aws_network_acl.bastion_acl.id
  rule_number    = 110
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = -1
  to_port        = -1
}

# Allow inbound traffic from vpc
resource "aws_network_acl_rule" "bastion_inbound_private_subnets" {
  network_acl_id = aws_network_acl.bastion_acl.id
  rule_number    = 130
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = aws_vpc.main.cidr_block
  from_port      = 0
  to_port        = 0
}

# Allow all outbound traffic to any IP address
resource "aws_network_acl_rule" "bastion_outbound_all" {
  network_acl_id = aws_network_acl.bastion_acl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_association" "bastion_acl_assoc" {
  count = length(aws_subnet.public)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  network_acl_id = aws_network_acl.bastion_acl.id
}
