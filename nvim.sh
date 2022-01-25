#!/bin/sh
# This script swaps the CAPSLOCK key with ESC key before starting neovim 
# and reset the key configuration to what it was before after the execution of neovim
# FIXME: if the session is suspended the key remap gets back to normal

function get_xkbmap_options() {
    setxkbmap -query | awk 'FNR == 5 {size=split($2, array, ",");
        for (i = 1; i <= size; i++) {
            print array[i];
        }
    }'
}

function is_caps_swapescape_set() {
    options=$(get_xkbmap_options)
    [[ $options =~ "caps:swapescape" ]]
}

if ! is_caps_swapescape_set
then
    setxkbmap -option caps:swapescape
fi

nvim $*

# reset the key configuration back to what it was before
if ! pidof nvim > /dev/null
then
    options=$(get_xkbmap_options)

    setxkbmap -option

    for option in $options
    do
        if [[ $option != "caps:swapescape" ]]; then
            setxkbmap -option $option
        fi
    done
fi
