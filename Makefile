ACCOUNT_ID ?= $(shell aws sts get-caller-identity --query 'Account' --output text)
TARGET_ENV ?= "dev"
BASE_NAME ?= $(shell basename $(CURDIR))
REGION ?= "ap-southeast-2"

ifeq ($(shell printf '%s' '$(ACCOUNT_ID)' | wc -m),0)
$(error ACCOUNT_ID is not set)
endif

debug:
	@echo "ACCOUNT 	  = ${ACCOUNT_ID}"
	@echo "TARGET_ENV = ${TARGET_ENV}"
	@echo "BASE_NAME  = ${BASE_NAME}"

init:
	terraform init \
		-backend-config="bucket=tf-${ACCOUNT_ID}" \
		-backend-config="key=${BASE_NAME}" \
		-backend-config="region=${REGION}"

fmt:
	terraform fmt -write=true --recursive

validate:
	terraform validate

plan:
	terraform plan -input=false -out=tfplan-${ACCOUNT_ID} -var-file="vars/${TARGET_ENV}.tfvars"

apply:
	terraform apply -input=false tfplan-${ACCOUNT_ID}

deploy: plan apply

destroy: are_you_sure
	terraform plan -destroy -input=false -out=tfplan-${ACCOUNT_ID} -var-file="vars/${TARGET_ENV}.tfvars"
	terraform apply -input=false tfplan-${ACCOUNT_ID}

clean:
	rm -f  tfplan-*  errored.tfstate 

are_you_sure:
	@echo -n "🤔 Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
