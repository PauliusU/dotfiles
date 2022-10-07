#!/bin/zsh

echo "Add symlinks for common folders"
ln -s ~/Dropbox/code ~/code
ln -s ~/Dropbox/dev ~/dev
ln -s ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv
ln -s ~/dev/config/.aws ~/.aws
mv ~/.hammerspoon ~/.hammerspoon.bak
ln -s $(pwd)/.hammerspoon ~/.hammerspoon
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s $(pwd)/terminal/.tmux.conf ~/.tmux.conf
mv ~/.aliases ~/.aliases.bak
ln -s $(pwd)/terminal/.aliases ~/.aliases
mv ~/.shellrc ~/.shellrc.bak
ln -s $(pwd)/terminal/.shellrc ~/.shellrc
mv ~/.config/nvim ~/.config/nvim.bak
ln -s $(pwd)/nvim ~/.config/nvim
mv ~/.vim ~/.vim.bak
ln -s $(pwd)/nvim ~/.vim
mv ~/.vimrc ~/.vimrc.bak
ln -s $(pwd)/nvim/init.vim ~/.vimrc
if [[ "$(uname)" == "Darwin" ]]; then
    ln -s $(pwd)/espanso ~/Library/Application\ Support/espanso
    ln -s $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
fi