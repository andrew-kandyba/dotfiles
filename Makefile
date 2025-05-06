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
    signingkey: "your signing key"
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
	@echo "Checking if yq is installed..."
	-@which yq >/dev/null || (echo "Installing yq..." && brew install yq)

	@echo "Uninstalling brew packages..."
	-@for pkg in $$(yq e '.brew.cask_packages[]' ansible/roles/system/brew/vars/main.yml); do \
		echo "Uninstalling cask: $$pkg"; \
		brew uninstall --force --cask "$$pkg" || true; \
	done

	-@for pkg in $$(yq e '.brew.packages[]' ansible/roles/system/brew/vars/main.yml); do \
		echo "Uninstalling formula: $$pkg"; \
		brew uninstall --force "$$pkg" || true; \
	done

	-@for pkg in $$(yq e '.brew.fonts[]' ansible/roles/system/brew/vars/main.yml); do \
		echo "Uninstalling font: $$pkg"; \
		brew uninstall --force --cask "$$pkg" || true; \
	done

	-@for pkg in $$(yq e '.git.packages[]' ansible/roles/system/git/vars/main.yml); do \
		echo "Uninstalling git package: $$pkg"; \
		brew uninstall --force "$$pkg" || true; \
	done

	@echo "Removing shell configuration..."
	-@rm -f $$HOME/.zshrc
	-@rm -f $$HOME/.p10k.zsh
	-@rm -f $$HOME/.hushlogin
	-@[ -f $$HOME/.oh-my-zsh/tools/uninstall.sh ] && $$HOME/.oh-my-zsh/tools/uninstall.sh || true
	-@rm -rf $$HOME/.oh-my-zsh # На випадок, якщо скрипт деінсталяції не видалив каталог

	@echo "Removing configuration files..."
	-@rm -f $$HOME/.gitconfig
	-@rm -f $$HOME/.gitignore
	-@rm -f $$HOME/.ssh/allowed_signers
	-@rm -f $$HOME/.ssh/config
	-@ssh-keygen -R github.com # Видаляє github.com з known_hosts

	@echo "Removing tool configurations..."
	-@rm -rf $$HOME/.config/ghostty
	-@rm -rf $$HOME/.config/zed
	-@rm -rf $$HOME/.1password
	-@launchctl unload ~/Library/LaunchAgents/com.1password.SSH* 2>/dev/null || true

	@echo "Restoring macOS defaults..."
	-@defaults delete NSGlobalDomain NSAutomaticSpellingCorrectionEnabled 2>/dev/null || true
	-@defaults delete NSGlobalDomain KeyRepeat 2>/dev/null || true
	-@defaults delete NSGlobalDomain InitialKeyRepeat 2>/dev/null || true
	-@defaults delete com.apple.controlcenter.plist BatteryShowPercentage 2>/dev/null || true
	-@defaults delete com.apple.controlcenter.plist BatteryModule 2>/dev/null || true
	-@defaults delete com.apple.dock autohide 2>/dev/null || true
	-@defaults delete com.apple.dock tilesize 2>/dev/null || true
	-@defaults delete com.apple.dock magnification 2>/dev/null || true
	-@defaults delete com.apple.dock largesize 2>/dev/null || true
	-@defaults delete NSGlobalDomain com.apple.swipescrolldirection 2>/dev/null || true
	-@defaults delete NSGlobalDomain AppleShowAllExtensions 2>/dev/null || true
	-@defaults delete com.apple.finder AppleShowAllFiles 2>/dev/null || true
	-@defaults delete com.apple.finder ShowPathbar 2>/dev/null || true
	-@defaults delete com.apple.finder ShowRecentTags 2>/dev/null || true
	-@defaults delete com.apple.finder NewWindowTargetPath 2>/dev/null || true
	-@defaults delete com.apple.finder FXDefaultSearchScope 2>/dev/null || true
	-@killall Dock Finder SystemUIServer 2>/dev/null || true


	-@rm -rf $$HOME/.cache/p10k-* 2>/dev/null || true
	-@rm -f $$HOME/.ansible.log 2>/dev/null || true

	@echo "Uninstalling Homebrew..."
	-@which brew >/dev/null && /bin/bash -c "$$(curl -fsSL ${BREW_UNINSTALL})" || true

	@echo "System reset completed. You may need to restart your terminal."

vault: ## Create vault
	@echo "Creating vault..."
	@openssl rand -base64 32 > ${VAULT_PASSWORD}
	@chmod 600 ${VAULT_PASSWORD}
	@mkdir -p ansible/inventories/home/group_vars
	@echo "$$VAULT_TEMPLATE" > ${VAULT}
	@echo "Vault created. Don't forget to:"
	@echo "1. Update data in ${VAULT}"
	@echo "2. Run 'make encrypt' to secure the vault"
	@echo "3. Run 'make play' to run the playbook"

encrypt: ## Encrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault encrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

decrypt: ## Decrypt vault
	@[ ! -f ${VAULT_PASSWORD} ] && echo ${VAULT_PASSWORD_UNDEFINED} && exit 1 || exit 0;
	@ansible-vault decrypt --vault-password-file ${VAULT_PASSWORD} ${VAULT};

lint: ## Run ansible-lint
	@echo "Running ansible-lint..."
	@docker run --rm -v ${PWD}:/ws ${ANSIBLE_LINT_IMG} -c /ws/.ansible-lint /ws/ansible/
