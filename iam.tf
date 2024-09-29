resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "GithubActionsRole" {
  name = "GithubActionsRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:${var.github_repository}:*"
          }
        }
      }
    ]
  })
  tags = local.common_tags
}

locals {
  policy_names = [
    "AmazonEC2FullAccess",
    "AmazonRoute53FullAccess",
    "AmazonS3FullAccess",
    "IAMFullAccess",
    "AmazonVPCFullAccess",
    "AmazonSQSFullAccess",
    "AmazonEventBridgeFullAccess"
  ]
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_policies" {
  for_each   = toset(local.policy_names)
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}
