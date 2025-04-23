# 🏡 .dotfiles (macOS)

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) &nbsp;
[![ansible-lint](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml) &nbsp;

This setup uses `make` coupled with [ansible 🤖](https://docs.ansible.com/ansible/latest/getting_started/introduction.html) to automate environment configuration.

## Usage
```bash
> git clone git@github.com:andrew-kandyba/dotfiles.git
> cd ./dotfiles
> rm -rf ./.git

> xcode-select --install # install make (optional)
> make vault # create vault (first-time setup)
> make play
```

## Make
```bash
> make

play       Run playbook
lint       Run ansible-lint
reset      Reset changes
vault      Create vault
encrypt    Encrypt vault
decrypt    Decrypt vault
```
