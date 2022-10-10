#!/bin/sh

# os-check - get basic info about OS running the script, OS version, build.

echo "uname: $(uname)" # Linux, Darwin, MINGW64_NT-10.0-25211
echo "OSTYPE: $OSTYPE" # linux-gnu, darwin21, msys (Windows in Git Bash)
uname -a

if [[ "$(uname)" == "Darwin" ]]; then
    sw_vers                            # macOS and build version
    sw_vers -productVersion            # macOS version only
    system_profiler SPSoftwareDataType # OS version, computer name, user name, etc.
fi
