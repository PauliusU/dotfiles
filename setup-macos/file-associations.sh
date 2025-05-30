#!/bin/sh

# Get the default app id for .sh and .jpg files (without a dot)
duti -x sh
duti -x jpg
duti -x mp4

# TEXT FILES com.microsoft.VSCode
duti -s com.microsoft.VSCode .js all
duti -s com.microsoft.VSCode .json all
duti -s com.microsoft.VSCode .md all
duti -s com.microsoft.VSCode .sh all

# AUDIO io.mpv
duti -s io.mpv .aac all
duti -s io.mpv .m4a all
duti -s io.mpv .ogg all
duti -s io.mpv .opus all

# VIDEO io.mpv
duti -s io.mpv .avi all
duti -s io.mpv .mkv all
duti -s io.mpv .mov all
duti -s io.mpv .mp4 all

# IMAGES

echo
echo "FILE ASSOCIATIONS ARE DONE"
