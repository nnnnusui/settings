#!/bin/bash
this_dir=$(cd $(dirname $0); pwd)

# ln -s $(pwd)/script/ ~/sh
ln -s $(this_dir)/_vimrc ~/.vimrc
ln -s $(this_dir)/_gvimrc ~/.gvimrc
