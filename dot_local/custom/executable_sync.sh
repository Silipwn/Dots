#!/bin/bash
# Finis coronat opus; Run at this code at your own peril ~ silipwn;
# File                  : sync.sh
# SPDX-License-Identifer: BSD-3-Clause
# Author                : silipwn <contact at as-hw.in>
# Description           : This is for syncing files from a development machine to hw
#                       : Depends upon rsync + inotifywait
# Date                  : 2022-03-21T10:52:09-0400
# Last-Modified         : 2023-07-28T19:08:48-0400

if [[ $# -lt 2 ]] ; then
    echo 'usage <script> <src> <dest> ; Full path only; An example:'
    echo 'sync.sh cs500/assignments/assignment1/srcs/ aws-networks-vm:/home/ubuntu/assignment1'
    exit 1
fi

while inotifywait -r -e modify,create,delete $1; do
    # Should ignore git cause generally bad idea
    rsync --exclude='.git/' -avz $1 $2
done
