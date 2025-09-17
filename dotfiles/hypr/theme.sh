#!/usr/bin/env bash

sleep 0.5

dconf write /org/gnome/desktop/interface/gtk-theme "'rose-pine-dawn'"
dconf write /org/gnome/desktop/interface/font-name "'Ubuntu Nerd Font Regular 11'"
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/font-hinting "'full'"
dconf write /org/gnome/desktop/interface/font-antialiasing "'rgba'"
dconf write /org/gnome/desktop/interface/cursor-theme "'Kokomi_Cursor'"
dconf write /org/gnome/desktop/interface/cursor-size 24
