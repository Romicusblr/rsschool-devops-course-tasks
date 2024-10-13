resource "aws_key_pair" "key" {
  key_name   = "${var.project}-key"
  public_key = var.public_key
}
