#!/usr/bin/env bash

# Tuer toutes les instances existantes de Waybar
pkill -x waybar

# Relancer Waybar en arrière-plan
nohup waybar >/dev/null 2>&1 &
