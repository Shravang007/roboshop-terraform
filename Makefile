dev:
	@rm -rf .terrafrom
	@terraform init
	@terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod:
	@rm -rf .terrafrom
	@terraform init
	@terraform apply -auto-approve -var-file=env-prod/main.tfvars
