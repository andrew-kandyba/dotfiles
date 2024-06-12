.PHONY := help
.DEFAULT_GOAL := help

BREW_INSTALLER := "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
PLAYBOOK := ${PWD}/ansible/playbook.yml
INVENTORIES := ${PWD}/ansible/inventories/home
VAULT := ${PWD}/ansible/inventories/home/group_vars/home
VAULT_PASSWORD := ${PWD}/vault_key
VAULT_PASSWORD_UNDEFINED := "Vault password is undefined"

help:
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}';

play: ## Run playbook
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@[ ! -f "`which brew`" ] && sudo curl -fsSL ${BREW_INSTALLER} | /bin/bash || exit 0;
	@[ ! -f "`which ansible`" ] && brew install ansible || exit 0;
	@ansible-playbook -i ${INVENTORIES} --vault-password-file ${VAULT_PASSWORD} ${PLAYBOOK};

encrypt: ## Encrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault encrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

decrypt: ## Decrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault decrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

#todo
lint: ## Run lint
	@exit 0;

#todo
tests: ## Run tests
	@exit 0;
