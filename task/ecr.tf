resource "aws_ecr_repository" "jenkins_app" {
  name                 = "my-jenkins-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}
