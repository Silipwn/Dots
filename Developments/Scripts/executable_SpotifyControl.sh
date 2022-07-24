#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause or GPL-3.0-or-later
# SPDX-FileCopyrightText: (C) 2022 silipwn
# Finis coronat opus; Run at this code at your own peril ~ silipwn;
# File                   : SpotifyControl.sh
# Author                 : silipwn <contact at as-hw.in>
# Description            : This file is responsible for connecting to the mac and then controlling 
#                          Spotify
# Date                   : 2022-07-24T09:26:40-0400
# Last-Modified          : 2022-07-24T10:37:17-0400

# Based on https://github.com/dronir/SpotifyControl

# Check if mac is available
ping -c1 ashwins-macbook-air > /dev/null
if [ $? -eq 0 ]
then 
    # Controls stuff?
    # Toggle 
    if [ $1 == "toggle" ]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl play/pause 
    # # Play
    # ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl play
    # Next
    elif [ $1 == "next" ]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl next
    # Prev
    elif [ $1 == "prev" ]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl prev
    elif [ $1 == "decrease_vol" ]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl decreasevolume 10 
    elif [ $1 == "increase_vol" ]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl increasevolume 10 
    # Play the URI specified, it's very difficult to get one honestly :( Weird keybindings
    elif [[ $1 == *"spotify:"* ]]; then
    ssh ashwins-macbook-air -i $HOME/.ssh/Lecal /Users/silipwn/Documents/SpotifyCtrl play $1
    fi
else
    notify-send "Failed to connect to the Mac :("
fi
