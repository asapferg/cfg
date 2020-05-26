#!/usr/bin/env bash

rm -f $HOME/.bashrc
rm -f $HOME/.bash_aliases
rm -f $HOME/.profile
rm -f $HOME/.ssh/config

ln -s $(pwd)/bashrc       $HOME/.bashrc
ln -s $(pwd)/bash_aliases $HOME/.bash_aliases
ln -s $(pwd)/profile      $HOME/.profile
ln -s $(pwd)/ssh-config    $HOME/.ssh/config