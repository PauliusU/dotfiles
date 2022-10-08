#!/bin/zsh

# Add symlinks for common files and folders. -f forces linking if file aready exists.

ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/dev
ln -sf ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv
ln -sf ~/dev/config/.aws ~/.aws
ln -sf $(pwd)/hammerspoon ~/.hammerspoon
ln -sf $(pwd)/terminal/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/terminal/.aliases ~/.aliases
ln -sf $(pwd)/terminal/.shellrc ~/.shellrc
ln -sf $(pwd)/nvim ~/.config/nvim
ln -sf $(pwd)/nvim ~/.vim
ln -sf $(pwd)/nvim/init.vim ~/.vimrc
if [[ "$(uname)" == "Darwin" ]]; then
    ln -sf $(pwd)/espanso ~/Library/Application\ Support/espanso
    ln -sf $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
fi
