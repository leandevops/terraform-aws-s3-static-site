.PHONY: help all init update validate plan apply run-tests destroy clean tflint deps post-action
.DEFAULT_GOAL := help

BLUE	= \033[0;34m
GREEN	= \033[0;32m
RED   = \033[0;31m
NC    = \033[0m

export PUBLISH_DIR ?= public

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: init validate plan apply run-tests destroy ## run nit validate plan apply run-tests destroy
	@echo "$(GREEN)✓ 'make all' has completed $(NC)\n"


init: ## initial terraform setup
	@echo "$(GREEN)✓ Initializing terraform $(NC)\n"
	@terraform init -input=false -lock=true \
			   -upgrade -force-copy -backend=true -get=true \
			   -get-plugins=true -verify-plugins=true \
			   tests/fixtures/tf_module
	@$(MAKE) -s post-action


update: ## update terraform
	@echo "$(GREEN)✓ Updating terraform $(NC)\n"
	@terraform get -update tests/fixtures/tf_module
	@$(MAKE) -s post-action


validate: ## validate terraform
	@echo "$(GREEN)✓ Validating terraform $(NC)\n"
	@terraform validate -check-variables=true \
			   -var-file=tests/fixtures/tf_module/testing.tfvars \
			   tests/fixtures/tf_module
	@terraform validate -check-variables=false module
	@$(MAKE) -s post-action


plan: ## run terraform plan
	@echo "$(GREEN)✓ Planning terraform $(NC)\n"
	@terraform plan -lock=true -input=false \
			   -parallelism=4 -refresh=true \
			   -var-file=tests/fixtures/tf_module/testing.tfvars \
			   tests/fixtures/tf_module
	@$(MAKE) -s post-action


apply: ## run terraform apply
	@echo "$(GREEN)✓ Applying terraform $(NC)\n"
	@terraform apply -lock=true -input=false \
			   -auto-approve=true -parallelism=4 -refresh=true \
			   -var-file=tests/fixtures/tf_module/testing.tfvars \
			   tests/fixtures/tf_module
	@$(MAKE) -s post-action


run-tests: ## run tests with RSPEC
	@echo "$(GREEN)✓ Running rspec tests $(NC)\n"
	@bundle exec rspec -c -f doc --default-path '.'  -P 'tests/scenarios/test_module.rb'
	@$(MAKE) -s post-action


destroy: ## destroy all resources
	@echo "$(RED)✓ Destroying terraform resources $(NC)\n"
	@terraform destroy -force -input=false -parallelism=4 -refresh=true \
			   -var-file=tests/fixtures/tf_module/testing.tfvars \
			   tests/fixtures/tf_module
	@rm terraform.tfstate*
	@$(MAKE) -s post-action


deploy: ## Deploy static site to S3
	aws s3 sync --delete --acl public-read --exact-timestamps \
		$(PUBLISH_DIR)/ s3://$(S3_BUCKET_NAME)/

clean: ## module cleanup
	@echo "$(RED)✓ Cleaning directory $(NC)\n"
	@rm -rf test/fixtures/tf_module/.terraform
	@rm -f terraform.tfstate*
	@$(MAKE) -s post-action


tflint: ## run tflint
	@echo "$(RED)✓ Running tflint $(NC)\n"
	@cd module && tflint
	@$(MAKE) -s post-action


deps: ## install bundler and dependencies
	@echo "$(RED)✓ Installing dependencies $(NC)\n"
	@gem install bundler
	@bundle check || bundle install
	@$(MAKE) -s post-action

post-action: ; @echo "$(BLUE)✓ Done. $(NC)\n"
