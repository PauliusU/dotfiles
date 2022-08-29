#!/bin/zsh

# Get the default app id for .sh and .jpg files (without a dot)
duti -x sh
duti -x jpg

# TEXT FILES com.microsoft.VSCode
duti -s com.microsoft.VSCode .md all
duti -s com.microsoft.VSCode .sh all

# AUDIO io.mpv
duti -s io.mpv .m4a all
duti -s io.mpv .opus all

# VIDEO io.mpv

# IMAGES