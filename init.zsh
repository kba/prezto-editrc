#!/bin/zsh

editor=${EDITOR:-vi}

local findrc

function findrc() {
    for candidate in "$HOME/.$1" "$HOME/.config/$1";do
        if [[ -e "$candidate" ]];then
           [[ -L "$candidate" ]] && echo $(readlink "$candidate") && return 0
           echo "$candidate" && return 0
       fi
    done
}

function editrc() {
    $editor $(findrc $1)
}

compdef _editrc findrc editrc
