#!/bin/bash

fortune > /tmp/for_dump
notify-send "$(cat /tmp/for_dump)"
