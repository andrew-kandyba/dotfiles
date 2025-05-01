.PHONY := help
.DEFAULT_GOAL := help

PLAYBOOK := ${PWD}/ansible/playbook.yml
INVENTORIES := ${PWD}/ansible/inventories/home
VAULT := ${PWD}/ansible/inventories/home/group_vars/home
VAULT_PASSWORD := ${PWD}/vault_key
VAULT_PASSWORD_UNDEFINED := "Vault password is undefined"
BREW_INSTALLER := "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
BREW_UNINSTALL := "https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh"
OMZSH_UNINSTALL := ${HOME}/.oh-my-zsh/tools/uninstall.sh
ANSIBLE_LINT_IMG := "pipelinecomponents/ansible-lint"

define VAULT_TEMPLATE
vault:
  git:
    name: "Your Name"
    email: "your.email@example.com"
endef
export VAULT_TEMPLATE

help:
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}';

play: ## Run playbook
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@[ ! -f "`which brew`" ] && echo "Installing brew...\n" && sudo curl -fsSL ${BREW_INSTALLER} | /bin/bash || exit 0;
	@[ ! -f "`which ansible`" ] && echo "Installing ansible...\n" && brew install ansible || exit 0;
	@echo "Running playbook..."
	@ansible-playbook -i ${INVENTORIES} --vault-password-file ${VAULT_PASSWORD} ${PLAYBOOK};

reset: ## Reset system to initial state
	@echo "Resetting system..."
	@echo "Uninstalling brew packages..."

	-@for pkg in $$(grep -E '^\s*-' ansible/roles/system/brew/vars/main.yml | sed 's/.*-\s*//' | tr -d '"' | tr -d "'"); do \
		echo "Uninstalling cask: $$pkg"; \
		brew uninstall --force --cask "$$pkg" || true; \
	done

	-@for pkg in $$(grep -E '^\s*-' ansible/roles/system/git/vars/main.yml | sed 's/.*-\s*//' | tr -d '"' | tr -d "'"); do \
		echo "Uninstalling formula: $$pkg"; \
		brew uninstall --force "$$pkg" || true; \
	done

	-@for pkg in zsh gnupg pinentry-mac telegram-desktop font-fira-code-nerd-font; do \
		echo "Uninstalling formula: $$pkg"; \
		brew uninstall --force "$$pkg" || true; \
	done

	@echo "Removing configuration files..."
	-@rm -f $$HOME/.gitconfig
	-@rm -f $$HOME/.gitignore
	-@rm -f $$HOME/.zshrc
	-@rm -rf $$HOME/.config/ghostty
	-@rm -rf $$HOME/.config/zed

	@echo "Cleaning up SSH and GPG configurations..."
	-@rm -f $$HOME/.ssh/config
	-@rm -f $$HOME/.ssh/id_ed25519*
	-@rm -rf $$HOME/.gnupg

	@echo "Uninstalling Oh My Zsh..."
	-@[ -f ${OMZSH_UNINSTALL} ] && ${OMZSH_UNINSTALL} || true

	@echo "Uninstalling Homebrew..."
	-@which brew >/dev/null && /bin/bash -c "$$(curl -fsSL ${BREW_UNINSTALL})" || true

	@echo "System reset completed. You may need to restart your terminal."

vault: ## Create vault
	@echo "Creating vault..."
	@echo "vault-secure-password" > ${VAULT_PASSWORD}
	@chmod 600 ${VAULT_PASSWORD}
	@mkdir -p ansible/inventories/home/group_vars
	@echo "$$VAULT_TEMPLATE" > ${VAULT}
	@echo "Vault created. Don't forget to:"
	@echo "1. Change default password ${VAULT_PASSWORD}"
	@echo "2. Update data in ${VAULT}"
	@echo "3. Run 'make encrypt' to secure the vault"
	@echo "4. Run 'make play' to run the playbook"

encrypt: ## Encrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault encrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

decrypt: ## Decrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault decrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

lint: ## Run ansible-lint
	@echo "Running ansible-lint..."
	@docker run --rm -v ${PWD}:/ws ${ANSIBLE_LINT_IMG} -c /ws/.ansible-lint /ws/ansible/
