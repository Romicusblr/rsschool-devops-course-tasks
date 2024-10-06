.PHONY: create-s3-bucket init plan apply destroy

REGION=us-east-1
PROFILE=rss-devops

create-s3-bucket:
	aws s3 mb s3://rm-rsschool-devops-tfstate --region $(REGION) --profile $(PROFILE)

init:
	terraform init

plan:
	terraform plan -var-file env.tfvars

apply:
	terraform apply -var-file env.tfvars

destroy:
	terraform destroy -var-file env.tfvars
