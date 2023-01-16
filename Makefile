DOTBOT_DIR := "$(PWD)/dotbot"
DOTBOT_BIN := "bin/dotbot"
DOTBOT_CONFIG := "$(PWD)/dotbot.yaml"

PLAYBOOK := "$(PWD)/ansible/local.yml"
BASEDIR := "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

.PHONY := help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-27s[0m %s\n", $$1, $$2}'

run: ## Run setup
	@cd "${BASEDIR}"
	@git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
	@git submodule update --init --recursive "${DOTBOT_DIR}"
	@"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}"

run-lint: ## Run ansible-lint
	@[ -f "`which ansible-lint`" ] && ansible-lint --offline -p "${PLAYBOOK}"

## Internal stuff
.install-git-submodules:
	@git submodule update --init --recursive

.install-brew:
	@[ ! -f "`which brew`" ] && sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash || exit 0;

.install-neovim-plugins:
	@[ -f "`which nvim`" ] && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' || exit 0;

.install-oh-my-zsh:
	@[ ! -d ~/.oh-my-zsh ] && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /bin/bash && \
	ln -sf $(PWD)/../oh-my-zsh/themes/unicorn.zsh-theme ~/.oh-my-zsh/themes/unicorn.zsh-theme && \
	ln -sf $(PWD)/../oh-my-zsh/.zshrc ~/.zshrc || exit 0;

.install-ansible:
	@[ ! -f "`which ansible`" ] && brew install ansible || exit 0;

.run-playbook:
	@cd $(PWD)/ansible && ansible-playbook --connection=local --inventory 127.0.0.1, local.yml
