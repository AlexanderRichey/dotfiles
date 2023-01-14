# dotfiles

These are my dotfiles.

## Setting up a new machine

Create your default SSH key by running `gen_keypair.sh`.

Download [homebrew](https://brew.sh/) and use it to install:

- tmux
- nvim
- go
- python
- nvm
- yarn

Install [Packer](https://github.com/wbthomason/packer.nvim).

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Link dotfiles. Here's an example:

```
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
```

Download and import terminal colorschemes.

- [Linux](https://github.com/denysdovhan/one-gnome-terminal)
- [Mac](https://github.com/nathanbuchar/atom-one-dark-terminal)
