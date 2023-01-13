# .dotfiles (WIP)
[![Molecula](https://github.com/andrew-kandyba/sandbox/actions/workflows/main.yml/badge.svg)](https://github.com/andrew-kandyba/sandbox/actions/workflows/main.yml)

This is a repo for my OS X dotfiles.
Bootstrap is based on the awesome [dotbot](https://github.com/anishathalye/dotbot).

## :teddy_bear: Require


[make](https://www.gnu.org/software/make/)    
[molecule](https://github.com/ansible-community/molecule) + docker driver [only for testing]


## :unicorn: Installation

```sh
> git@github.com:andrew-kandyba/sandbox.git .dotfiles
> cd .dotfiles

> make run
```
         
## 🤞🏻 Testing

To run tests that require [molecula](https://github.com/ansible-community/molecule) with docker driver installed.    
Please use `make test` for executing tests.    

```sh
> cd .dotfiles

> make test
```
     
**_! Executing the test script may take some time._**
