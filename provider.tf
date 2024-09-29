provider "aws" {
  allowed_account_ids = [var.account_id]
  region              = var.region

  default_tags {
    tags = {
      ManagedBy = "terraform"
      Project   = "rsschool-devops"
    }
  }
}
