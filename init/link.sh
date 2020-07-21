#!/bin/bash
this_dir=$(cd $(dirname $0); pwd)
dotfile_dir=${this_dir}/../~config/dotfiles

date=$(date "+%Y%m%d-%H%M%S")
mv ~/.vimrc  ~/.vimrc${date}.old
mv ~/.gvimrc ~/.gvimrc${date}.old

# ln -s $(pwd)/script/ ~/sh
ln -s ${dotfile_dir}/_vimrc ~/.vimrc
ln -s ${dotfile_dir}/_gvimrc ~/.gvimrc
