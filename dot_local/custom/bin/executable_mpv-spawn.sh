#!/usr/bin/env bash
set -euo pipefail

notify-send -t 5000 -i '/usr/share/icons/Adwaita/32x32/mimetypes/video-x-generic-symbolic.symbolic.png' \
"Playing in Spawned U-MPV" "`xclip -o -sel clip | xargs yt-dlp -e`"

# plays the link in mpv
~/.local/bin/umpv `xclip -o -sel clip`
