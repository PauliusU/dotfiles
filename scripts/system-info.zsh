#!/bin/zsh

# Get basic info about the system (e.g. OS version, build)

uname -a # Info about Darwin (Unix base for macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    echo "macOs"
    sw_vers # macOs and build version
    sw_vers -productVersion # macOs version only
    system_profiler SPSoftwareDataType # OS version, computer name, user name, etc.
fi