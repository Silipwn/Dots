#!/bin/bash
##lock.sh Author "silipwn <c2lsaXB3bmVkQGdtYWlsLmNvbQ==>" Date 18.06.2020
## toggl stop
## XSECURELOCK_BLANK_TIMEOUT=900 \
## XSECURELOCK_PASSWORD_PROMPT=time_hex \
## XSECURELOCK_NO_COMPOSITE=1 \
## XSECURELOCK_SAVER_RESET_ON_AUTH_CLOSE=1 \
## XSECURELOCK_SHOW_DATETIME=1 \
## exec xsecurelock
dunstctl set-paused true 
playerctl pause
xscreensaver-command -lock
dunstctl set-paused false
