terraform {
  backend "s3" {
    bucket  = "rm-rsschool-devops-tfstate"
    key     = "rsschool-devops-task.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69"
    }
  }

  required_version = "~> 1.6"
}
