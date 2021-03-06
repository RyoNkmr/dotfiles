#!/bin/bash

if [ -e "${HOME}/.anyenv" ]; then
  echo "$HOME/.anyenv is found"
  # anyenv install rbenv
  candidates=("pyenv" "nodenv" "goenv" "rbenv")
  for e in ${candidates[@]}; do
    if [ ! -e "${HOME}/.anyenv/envs/${e}" ]; then
      anyenv install ${e}
    else
      echo "${e} is already installed"
    fi
  done
else
  echo "$HOME/.anyenv is not found"
  # setup anyenv
  git clone https://github.com/riywo/anyenv ~/.anyenv
  # install anyenv-update
  mkdir -p $(anyenv root)/plugins
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
  source ~/.zshrc
fi
