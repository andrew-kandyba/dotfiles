DOTBOT_DIR := "$(PWD)/dotbot"
DOTBOT_BIN := "bin/dotbot"
DOTBOT_CONFIG := "$(PWD)/dotbot.yaml"

BASEDIR := "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run-dotbot: ## Run dotbot
	@cd "${BASEDIR}"
	@git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
	@git submodule update --init --recursive "${DOTBOT_DIR}"
	@"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}"

## Internal stuff
.install-git-submodules:
	@git submodule update --init --recursive

.install-brew:
	@[ ! -f "`which brew`" ] && sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash || exit 0;

.install-oh-my-zsh:
	@[ ! -d ~/.oh-my-zsh ] && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /bin/bash || exit 0;

.install-ansible:
	@[ ! -f "`which ansible`" ] && brew install ansible || exit 0;

