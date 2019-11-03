set -ex

export SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Go to $HOME
cd "$HOME"

# Link stuff
ln -s $SCRIPTPATH/.tmux.conf .tmux.conf
ln -s $SCRIPTPATH/.bash_profile .bash_profile
ln -s $SCRIPTPATH/.gitconfig .gitconfig

# Create nvim dir and link
mkdir -p .config/nvim/
cd .config/nvim/
ln -s $SCRIPTPATH/init.vim init.vim
