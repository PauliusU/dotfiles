#!/bin/zsh

# Get basic info about the system

sw_vers # macOs and build version
sw_vers -productVersion # macOs version only
uname -a # Info about Darwin (Unix base for macOS)
system_profiler SPSoftwareDataType # OS version, computer name, user name, etc.