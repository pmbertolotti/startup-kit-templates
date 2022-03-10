REGION ?= us-east-1
PROFILE ?= default
ENV_NAME ?= dev

ACCOUNT_ID := $(shell aws sts get-caller-identity --profile $(PROFILE) --query 'Account' --output text)

.PHONY: create-stack
create-stack:
	@aws cloudformation create-stack \
	--stack-name app-$(ENV_NAME) \
	--region $(REGION) \
	--capabilities CAPABILITY_NAMED_IAM \
	--template-url https://s3.amazonaws.com/cfn-templates-229787120342/vpc-bastion-fargate-rds.cfn.yml \
	--parameters file://params.json

