#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause or GPL-3.0-or-later
# SPDX-FileCopyrightText: (C) 2024 silipwn (Ashwin)
# Finis coronat opus; Run at this code at your own peril ~ silipwn;
# Written with help of Gemini LLM  
# File                   : notify_log.sh
# Author                 : silipwn <contact at as-hw.in>
# Description            : This file is responsible for <insert task>
# Date                   : 2024-02-15T09:48:00-0500
# Last Modified          : 2024-02-15T12:34:03-0500
# Last Modified By       : silipwn <contact at as-hw.in>

# Check if the notify-send is theere
command -v notify-send >/dev/null 2>&1 || {
  echo "Error: 'notify-send' command not found. Please install it."
  exit 1
}

# Check if screen is locked with help of xscreensaver
# xscreensaver-command -time
# If screen is locked, then exit
if [[ $(xscreensaver-command -time | grep -o "locked") == "locked" ]]; then
  exit 0
fi


# Based on https://stackoverflow.com/questions/16519673/cron-with-notify-send 
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Set notification title and message
title="Remember to Logseq!"
message="What are you upto?"

# Define unicode characters for bell and notebook
bell="🛎"
notebook="📓"

# Combine notification with unicode characters
notification="$bell $title $message $notebook"

# Send notification using notify-send
notify-send -u normal "$notification"
