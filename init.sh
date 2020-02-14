#!/bin/bash

sh ./link.sh
sh ./anyenv.sh

echo "\n
---------------\n
you should install some latest language environments with *env packages:\n
ruby, node, python, go\n
and then, run 'sh ~/dotfiles/install-dependencies.sh'
---------------\n
if you should install some tools for kubernates \n
run 'sh ~/dotfiles/setup-kubetools.sh'
"
