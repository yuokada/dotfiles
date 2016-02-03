#!/bin/bash

PWD=`pwd`

#CMD="ls -l"
#CMD="diff -uw"
CMD="ln -s"

for F in .zshrc .gitignore_global
do
    $CMD ${PWD}/${F} ${HOME}/${F}
    #ln -s ${PWD}/.zshrc ${HOME}/.zshrc
    echo "$F Link Done"
done
