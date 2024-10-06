.PHONY: init plan apply destroy

init:
	terraform init

plan:
	terraform plan -var-file ../env.tfvars

apply:
	terraform apply -var-file ../env.tfvars

destroy:
	terraform destroy -var-file ../env.tfvars
