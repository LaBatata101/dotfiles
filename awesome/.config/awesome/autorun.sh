#!/usr/bin/env bash

function run {
    if ! pgrep $1 ;
    then 
        $@& > /dev/null 2>&1
    fi
}


run ulauncher
