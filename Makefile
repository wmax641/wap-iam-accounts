ACCOUNT_ID ?= $(shell aws sts get-caller-identity --query 'Account' --output text)
ACCOUNT_NAME ?= "dev"
BASE_NAME ?= $(shell basename $(CURDIR))
REGION ?= "ap-southeast-2"

debug:
	@echo "ACCOUNT = ${ACCOUNT_ID}"
	@echo "ACCOUNT = ${ACCOUNT_NAME}"
	@echo "BASE_NAME = ${BASE_NAME}"

init:
	terraform init \
		-backend-config="bucket=tf-${ACCOUNT_ID}" \
		-backend-config="key=${BASE_NAME}" \
		-backend-config="region=${REGION}"

inits3:
	@echo -n "Create s3 bucket: 'tf-${ACCOUNT_ID}'?   [y/N] " && read ans && [ $${ans:-N} = y ]
	aws s3api create-bucket --bucket "tf-${ACCOUNT_ID}" --region "${REGION}" --create-bucket-configuration LocationConstraint="${REGION}"

fmt:
	terraform fmt -write=true --recursive

validate:
	terraform validate

plan:
	terraform plan -input=false -out=tfplan-${ACCOUNT_ID} -var-file="vars/${ACCOUNT_NAME}.tfvars"

apply:
	terraform apply -input=false tfplan-${ACCOUNT_ID}

destroy:
	terraform plan -destroy -input=false -out=tfplan-${ACCOUNT_ID} -var-file="vars/${ACCOUNT_NAME}.tfvars"
	terraform apply -input=false tfplan-${ACCOUNT_ID}

