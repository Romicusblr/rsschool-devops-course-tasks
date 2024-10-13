resource "aws_key_pair" "key" {
  key_name   = "${var.project}-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
