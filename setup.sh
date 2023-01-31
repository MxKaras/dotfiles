#!/usr/bin/env bash

mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.local/state
mkdir -p ~/.config/iterm2

curl https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Solarized%20Dark%20Higher%20Contrast.itermcolors -o ~/.config/iterm2/"Solarized Dark Higher Contrast.itermcolors"