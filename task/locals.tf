locals {
  subnet_cidr_blocks = {
    public  = cidrsubnets(aws_vpc.main.cidr_block, 8, 8)[0]
    private = cidrsubnets(aws_vpc.main.cidr_block, 8, 8)[1]
  }

  common_tags = {
    ManagedBy = "terraform"
    Project   = "rsschool-devops"
  }
}
