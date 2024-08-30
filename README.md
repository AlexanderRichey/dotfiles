# dotfiles

These are my dotfiles.

## Getting Started

Symlink dotfiles to their appropriate locations.

```bash
# Here's a couple examples...
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

Download and import terminal colorschemes for all the colors 🌈 to match.

- [Mac](https://github.com/nathanbuchar/atom-one-dark-terminal)
- [Linux](https://github.com/denysdovhan/one-gnome-terminal)

## Vim

To get started, install [`nvim`](https://neovim.io/). The easiest way to do this is with [`brew`](https://brew.sh/):

```bash
brew install neovim
```

When you open `nvim`, [LazyVim](https://github.com/LazyVim/LazyVim) should kick in and handle installing everything.


Use a [nerdfont](https://www.nerdfonts.com/) if you see question marks in the UI.

One more note: Some people like to have huge `init.lua`s made of several files and directories. My preferences are closer to the other end of the spectrum. My goal is to have it all in *one file*.

### Features & Key Bindings

All these commands apply in normal mode. `C` means `Ctrl`. All of the [LazyVim defaults](https://www.lazyvim.org/keymaps) apply, plus the following extras:

- `<C-p>`: Fuzzy finder.
- `-`: Browse folder tree with [vim-vinegar](https://github.com/tpope/vim-vinegar).
- `\f`: Project-wide text search.
- `gcc`: Comment in/out code (also works in visual mode).
- `<C-h>`: Move cursor pane-left.
- `<C-j>`: Move cursor pane-down.
- `<C-k>`: Move cursor pane-up.
- `<C-l>`: Move cursor pane-right.
- `<F2>`: Rename all references to the symbol under the cursor. See [:help vim.lsp.buf.rename()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.rename()).
- `<F4>`: Select a code action available at the current cursor position. See [:help vim.lsp.buf.code_action()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.code_action()).
- `ys<motion><surrounding>`: See [vim-surround](https://github.com/tpope/vim-surround).

In visual mode, [multi-cursor](https://github.com/mg979/vim-visual-multi) is available by selecting text and pressing `<C-n>`.

## Extras

If you're bootstrapping a new machine, run the following to install the essentials.

```bash
brew install tmux neovim go python3 gradle openjdk
```

Then install [`nvm`](https://github.com/nvm-sh/nvm#installing-and-updating) and use it to install `yarn`.

```bash
nvm use stable
npm install --global yarn
```
