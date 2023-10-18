#!/usr/bin/env bash
set -euo pipefail

# Check if there's a URL in the clipboard
content=`xclip -o sel clip`
if [[ "$content" == http* ]]; then
  notify-send -t 5000 -i '/usr/share/icons/Adwaita/32x32/mimetypes/video-x-generic-symbolic.symbolic.png' \
  "Playing in Spawned U-MPV" ""
# plays the link in mpv
  ~/.local/bin/umpv `xclip -o -sel clip`

fi
