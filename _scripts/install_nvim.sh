set -ex

# Install nvim
curl -LO https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install the silver searcher
sudo apt install silversearcher-ag

# Install xclip
sudo apt install xclip

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install neovim node
sudo npm i -g neovim

# Install neovim python
pip3 install -U neovim
pip install -U neovim
