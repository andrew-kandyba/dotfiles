# .dotfiles (MacOSX)

[![ansible-lint](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/andrew-kandyba/dotfiles/actions/workflows/ansible-lint.yml) &nbsp; [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) &nbsp;

Bootstrap is based on the `make` + [ansible 🤖](https://docs.ansible.com/ansible/latest/getting_started/introduction.html).

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
encrypt    Encrypt vault
decrypt    Decrypt vault
lint       Run lint
tests      Run tests
```
