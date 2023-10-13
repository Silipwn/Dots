#!/bin/bash
# Based on https://willbush.netlify.app/blog/fast-ocr-to-clipboard/
# Requires flameshot+tesseract+xclip
# Date                   : 2023-10-13T09:36:19-0400
# Last Modified          : 2023-10-13T09:36:50-0400
 flameshot gui --raw \
                              | tesseract stdin stdout -l eng \
                              | xclip -in -selection clipboard
