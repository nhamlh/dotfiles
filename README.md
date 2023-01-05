# [ARCHIVED] in favor of my new [system](https://github.com/nhamlh/nix)

# My dotfiles

## Installation

Clone this repository
```bash
git clone https://github.com/nhamlh/dotfiles $HOME/.dotfiles && cd $HOME/.dotfiles
```

Install [GNU stow](https://www.gnu.org/software/stow/)
```bash
pacman -S stow
```

Symlink component you want. E.g I want to symlink my neovim config:
```bash
stow neovim
```
