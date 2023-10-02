#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause or GPL-3.0-or-later
# SPDX-FileCopyrightText: (C) 2023 silipwn (Ashwin)
# Finis coronat opus; Run at this code at your own peril ~ silipwn;
# File                   : suspend.sh
# Author                 : silipwn <contact at as-hw.in>
# Description            : This file is responsible for <insert task>
# Date                   : 2023-10-01T23:04:31-0400
# Last Modified          : 2023-10-01T23:06:32-0400
# Last Modified By       : silipwn <contact at as-hw.in>
playerctl pause
notify-send "Suspending now"
xscreensaver-command -lock
sleep 3
systemctl suspend
