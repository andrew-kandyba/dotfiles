# .dotfiles (macOS)

[![ansible-lint](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml) &nbsp; [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) &nbsp;

This setup uses `make` coupled with [ansible 🤖](https://docs.ansible.com/ansible/latest/getting_started/introduction.html) to automate environment configuration.

## Usage
```bash
> git clone git@github.com:andrew-kandyba/dotfiles.git
> cd ./dotfiles

> xcode-select --install # install make (optional)
> make play
```

## Make
```bash
> make

play       Run playbook
lint       Run ansible-lint
reset      Reset system to initial state
encrypt    Encrypt vault
decrypt    Decrypt vault
```
