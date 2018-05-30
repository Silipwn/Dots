#!/bin/bash
curl wttr.in/Kollam?T?q?0?m 2>/dev/null | awk '/°(C|F)/ {printf $(NF-1) $NF " ("a")"} /,/ {a=$0}'
