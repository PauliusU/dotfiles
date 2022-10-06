#!/bin/sh

# os-check - get basic info about OS running the script, OS version, build.

echo "uname: $(uname)" # Linux, Darwin, mysu
echo "OSTYPE: $OSTYPE" # Linux, darwin21, msys
uname -a

case "$(uname -sr)" in # # -s OS name -r OS release. E.g. "Darwin 21.6.0"
Darwin*)
    echo 'macOs / Mac OS X'
    ;;
Linux*Microsoft*)
    echo 'WSL1' # Windows Subsystem for Linux
    ;;
Linux*)
    echo 'Linux'
    ;;
CYGWIN* | MINGW* | MINGW32* | MSYS*)
    echo 'MS Windows'
    ;;
*)
    echo 'Other OS'
    ;;
esac

if [[ "$(uname)" == "Darwin" ]]; then
    sw_vers                            # macOs and build version
    sw_vers -productVersion            # macOs version only
    system_profiler SPSoftwareDataType # OS version, computer name, user name, etc.
fi
