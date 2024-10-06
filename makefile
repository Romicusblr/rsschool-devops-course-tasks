.PHONY: create-s3-bucket

REGION=us-east-1
PROFILE=rss-devops

create-s3-bucket:
	aws s3 mb s3://rm-rsschool-devops-tfstate --region $(REGION) --profile $(PROFILE)
