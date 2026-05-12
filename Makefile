.PHONY: install test tf-init tf-plan tf-apply

install:
	pip install -r requirements.txt

test:
	pytest -q

tf-init:
	cd infra/terraform && terraform init

tf-plan:
	cd infra/terraform && terraform plan

tf-apply:
	cd infra/terraform && terraform apply -auto-approve
