#!/bin/bash

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vimrc.plug ~/.vimrc.plug
ln -s ~/dotfiles/.vimrc.general ~/.vimrc.general
ln -s ~/dotfiles/.vimrc.plugin ~/.vimrc.plugin
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux/bin ~/.tmux/bin
ln -s ~/dotfiles/.alacritty.yml ~/.alacritty.yml

# for neovim
mkdir -p ~/.config
mkdir -p ~/.vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/snippets ~/.vim/snippets

ln -s ~/dotfiles/.ignore ~/.config/.ignore
