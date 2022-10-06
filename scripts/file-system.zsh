#!/bin/zsh

echo "Add symlinks for common folders"
ln -s ~/Dropbox/code ~/code
ln -s ~/Dropbox/dev ~/dev
ln -s ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv
ln -s ~/dev/config/.aws ~/.aws
ln -s $(pwd)/.hammerspoon ~/.hammerspoon
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.zsh_aliases ~/.bash_aliases # Zsh aliases in Bash
ln -s $(pwd)/.zsh_aliases ~/.zsh_aliases
ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/nvim ~/.vim
ln -s $(pwd)/nvim/init.vim ~/.vimrc
if [[ "$(uname)" == "Darwin" ]]; then
    ln -s $(pwd)/espanso ~/Library/Application\ Support/espanso
    ln -s $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
fi