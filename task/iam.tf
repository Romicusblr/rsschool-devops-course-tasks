resource "aws_iam_user" "ecr_user" {
  name = "ecr-user"
}

resource "aws_iam_user_policy_attachment" "ecr_policy_attachment" {
  user       = aws_iam_user.ecr_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}


resource "aws_iam_access_key" "ecr_access_key" {
  user = aws_iam_user.ecr_user.name
}
