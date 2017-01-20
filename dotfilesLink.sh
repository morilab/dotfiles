#!/bin/sh

# dotfiles
for dotfile in .vimrc .bashrc .bash_aliases
do
    if [ ! -r ~/$dotfile ]; then ln -sf ~/dotfiles/$dotfile ~/$dotfile; fi
done

# .vim
if [ ! -r ~/.vim ]; then mkdir ~/.vim; fi
ln -sf ~/dotfiles/.vim/colors   ~/.vim/
ln -sf ~/dotfiles/.vim/ftdetect ~/.vim/
ln -sf ~/dotfiles/.vim/indent   ~/.vim/
ln -sf ~/dotfiles/.vim/mysnip   ~/.vim/
ln -sf ~/dotfiles/.vim/syntax   ~/.vim/
