# dotfiles

These are my dotfiles.

## Getting Started

Symlink dotfiles to their appropriate locations.

```bash
# Here's a couple examples...
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zshrc ~/.zshrc

# init.lua is a special case. You may have to create this
# directory in order to symlink the file.
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/init.lua ~/.config/nvim/init.lua
```

Download and import terminal colorschemes for all the colors 🌈 to match.

- [Mac](https://github.com/nathanbuchar/atom-one-dark-terminal)
- [Linux](https://github.com/denysdovhan/one-gnome-terminal)

## Vim

To get started, install [`nvim`](https://neovim.io/). The easiest way to do this is with [`brew`](https://brew.sh/):

```bash
brew install neovim
```

Next, install [Packer](https://github.com/wbthomason/packer.nvim), a plugin manager for Neovim.

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

When you open `nvim` for the first time, you'll see some errors. This is expected. Run `:PackerSync` and observe the installation of all the plugins. Sometimes they don't all succeed on the first time. If that happens, close `nvim` and run `:PackerSync` again. For good measure, I'd recommend closing and opening `nvim` again after you finish installing everything.

One thing to know about Packer is `:PackerCompile`. If you make changes to your `init.lua` but don't see any changes in `nvim`'s behavior, then you probably just need to run `:PackerCompile`, which regenerates Packer's compiled loader file.

Use a [nerdfont](https://www.nerdfonts.com/) if you see question marks in the UI.

One more note: Some people like to have huge `init.lua`s made of several files and directories. My preferences are closer to the other end of the spectrum. My goal is to have it all in *one file*.

### Features & Key Bindings

All these commands apply in normal mode. `C` means `Ctrl`. These key bindings are defaults from [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) and [tmux.nvim](https://github.com/aserowy/tmux.nvim), plus a few other things.

- `<C-p>`: Fuzzy finder.
- `-`: Browse folder tree with [vim-vinegar](https://github.com/tpope/vim-vinegar).
- `\f`: Project-wide text search.
- `gcc`: Comment in/out code (also works in visual mode).
- `<C-h>`: Move cursor pane-left.
- `<C-j>`: Move cursor pane-down.
- `<C-k>`: Move cursor pane-up.
- `<C-l>`: Move cursor pane-right.
- `K`: Display hover information about the symbol under the cursor in a floating window. See [:help vim.lsp.buf.hover()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.hover()).
- `gd`: Go to definition of the symbol under the cursor. See [:help vim.lsp.buf.definition()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.definition()).
- `gD`: Go to declaration of the symbol under the cursor. Some servers don't implement this feature. See [:help vim.lsp.buf.declaration()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.declaration()).
- `gi`: List all the implementations for the symbol under the cursor in the quickfix window. See [:help vim.lsp.buf.implementation()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.implementation()).
- `go`: Go to the definition of the type of the symbol under the cursor. See [:help vim.lsp.buf.type_definition()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.type_definition()).
- `gr`: List all the references to the symbol under the cursor in the quickfix window. See [:help vim.lsp.buf.references()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.references()).
- `<F2>`: Rename all references to the symbol under the cursor. See [:help vim.lsp.buf.rename()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.rename()).
- `<F4>`: Select a code action available at the current cursor position. See [:help vim.lsp.buf.code_action()](https://neovim.io/doc/user/lsp.html#vim.lsp.buf.code_action()).
- `gl`: Show diagnostics in a floating window. See [:help vim.diagnostic.open_float()](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()).
- `[d`: Move to the previous diagnostic in the current buffer. See [:help vim.diagnostic.goto_prev()](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.goto_prev()).
- `]d`: Move to the next diagnostic. See [:help vim.diagnostic.goto_next()](https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.goto_next()).
- `ys<motion><surrounding>`: See [vim-surround](https://github.com/tpope/vim-surround).

In visual mode, [multi-cursor](https://github.com/mg979/vim-visual-multi) is available by selecting text and pressing `<C-n>`.

## Extras

If you haven't created a default SSH key for your machine, run the following.

```bash
./gen_keypair.sh
```

If you're bootstrapping a new machine, run the following to install the essentials.

```bash
brew install tmux neovim go python3 gradle openjdk
```

Then install [`nvm`](https://github.com/nvm-sh/nvm#installing-and-updating) and use it to install `yarn`.

```bash
nvm use stable
npm install --global yarn
```
