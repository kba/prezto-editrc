#!/bin/zsh

editor=${EDITOR:-vi}

local findrc findrc_dir

rcprefixes=("$HOME/." "$HOME/.config" "$HOME/dotfiles/repo/")

function findrc() {
    for dir in ${rcprefixes[@]};do
        candidate="$dir$1"
        if [[ -e "$candidate" ]];then
           [[ -L "$candidate" ]] && echo $(readlink "$candidate") && return 0
           echo "$candidate" && return 0
       fi
    done
}
function findrc_dir() {
    for dir in $rcprefixes;do
        candidate="$dir$1"
        if [[ -e "$candidate" ]];then
           [[ -L "$candidate" ]] && echo $(readlink "$candidate") && return 0
           echo "$candidate" && return 0
       fi
    done
}

function editrc() {
    $editor $(findrc $1)
}

function cdrc() {
    cd $(findrc_dir $1)
}

compdef _findrc editrc
compdef _findrc_dir cdrc
