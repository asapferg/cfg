#!/usr/bin/env bash

rm $HOME/.bashrc
rm $HOME/.bash_aliases
rm $HOME/.profile

ln -s $(pwd)/.bashrc       $HOME/.bashrc
ln -s $(pwd)/.bash_aliases $HOME/.bash_aliases
ln -s $(pwd)/.profile      $HOME/.profile
