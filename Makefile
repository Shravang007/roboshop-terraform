dev:
	@rm -rf .terrafrom
	@terraform init -backend-config=end-dev/state.tfvars
	@terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod:
	@rm -rf .terrafrom
	@terraform init -backend-config=end-prod/state.tfvars
	@terraform apply -auto-approve -var-file=env-prod/main.tfvars
