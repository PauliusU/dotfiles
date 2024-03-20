echo ".functions.sh"

function ytpl() {
    #  Download youtube playlist or channel

    builtin cd ~/Downloads || return 1

    # Format for h264 and h265 codec:   -f "bestvideo[vcodec~='^((he|a)vc|h26[45])'][ext=mp4][height>=720][height<=1080][fps>=23]+bestaudio[ext=m4a]" \
    # --add-metadata                    Alias for --embed-metadata but supports youtube-dl as well
    # --embed-thumbnail                 yt-dlp: Embed thumbnail in the video as cover art || youtube-dl: Embed thumbnail in the audio as cover art
    # -i                                alias for --ignore-errors
    yt-dlp \
        -f "bestvideo[ext=mp4][height<=1080][fps>=23]+bestaudio[ext=m4a]" \
        -o "%(upload_date)s-%(title)s_%(height)sp%(fps)s.%(ext)s" \
        --restrict-filenames \
        --add-metadata \
        --embed-thumbnail \
        -i \
        "$@"
}

function ytpl-beggining() {
    #  Download youtube playlist or channel from the beginning
    # --restrict-filenames              Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
    ytpl --playlist-reverse "$@"
}

function ytpl-chapters() {
    #  Download youtube playlist or channel splitting chapters into separate files
    ytpl --split-chapters "$@"
}

function batch_convert() {
    # Converts an entire directory with ffmpeg
    # Usage: batch_convert mkv mp4
    # Ref: https://stackoverflow.com/a/52338741

    old_extension=$1
    new_extension=$2

    for i in *."$old_extension"; do
        ffmpeg -i "$i" "${i%.*}.$new_extension"
    done
}

function convert_to_hevc() {
    # Convert video to High Efficiency Video Coding (HEVC) / H.265

    if [ -z "$1" ]; then
        echo 'Input file is missing. E.g. "video.webm"'
        # non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # -preset medium    (default)
    # -c:a copy			stream copy audio instead of re-encoding
    ffmpeg -i "$1" -c:v libx265 -preset ultrafast -vtag hvc1 -c:a copy "${1%.*}".hevc.mp4
}

function convert_to_avc() {
    # Convert video to Advanced Video Coding (AVC) / H.264

    if [ -z "$1" ]; then
        echo 'Input file is missing. E.g. "video.webm"'
        # non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # -c:a copy			stream copy audio instead of re-encoding
    # -preset medium    (default)
    ffmpeg -i "$1" -c:v libx264 -c:a copy "${1%.*}".avc.mp4
}

function convert_to_mp3s() {
    # Convert all files of the same format in the folder to MP3s

    if [ -z "$1" ]; then
        echo 'FILE FILTER ARGUMENT IS MISSING. E.g. "*.opus"'
        # non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    for f in "$1"; do ffmpeg -i "$f" "${f%.*}.mp3"; done
}

function merge_mp3s() {
    # Merge all *.mp3 files into single MP3 file

    for file in *.mp3; do
        echo "Processing $file"
        echo "file '$file'" >>list.txt
        ffprobe "$file" 2>&1 | awk '/Duration/ {print $2}'
    done
    ffmpeg -f concat -safe 0 -i list.txt -c copy merged.mp3
    rm list.txt
    mv merged.mp3 "${PWD##*/}".mp3
}

function git_change_origin() {
    # Change old git repo remote origin to new

    if [ -z "$1" ]; then
        echo 'ERROR: new remote is missing'
        # non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # Remove old remote
    git remote rm origin
    # Add new remote
    git remote add origin "$1"
    git push --set-upstream origin master
    git push -u origin master
}

function extract_audio() {
    # Extract audio from video

    # -vn					skips the inclusion of the video stream,
    # -acodec copy			copies the picked audio streams (without re-encoding)
    ffmpeg -i "$1" -vn -acodec copy "${1%.*}.aac"
}

function ver() {
    # os-check - get basic info about OS running the script, OS version, build.

    echo "uname: $(uname)"; echo # Linux, Darwin, MINGW64_NT-10.0-25211
    echo "OSTYPE: $OSTYPE"; echo # linux-gnu, darwin21, msys (Windows in Git Bash)
    uname -a; echo

    if [[ "$(uname)" == "Darwin" ]]; then
        sw_vers                            # macOS and build version
        sw_vers -productVersion            # macOS version only
        system_profiler SPSoftwareDataType # OS version, computer name, user name, etc.
    fi
}

function get_os() {
    # Check OS and set environment variables

    export IS_LINUX=false
    export IS_MAC=false
    export IS_WINDOWS=false
    export IS_WSL=false
    export OSFOUND=""

    # Determine OS by OS name (-s) and OS release (-r) like "Darwin 21.6.0"
    case "$(uname -sr)" in #
    Darwin*)
        OSFOUND="macOS"
        IS_MAC=true
        ;;
    Linux*microsoft*)
        OSFOUND="WSL" # Windows Subsystem for Linux
        IS_WSL=true
        ;;
    Linux*)
        OSFOUND="Linux"
        IS_LINUX=true
        ;;
    MINGW* | CYGWIN* | MSYS*) # E.g. Git Bash for Windows
        OSFOUND="Windows"
        IS_WINDOWS=true
        ;;
    *)
        OSFOUND="Other OS"
        ;;
    esac
}

function append_less_pipe() {
    # Add "| less" to passed param

    if [ -z "$1" ]; then
        echo "ERROR: missing params"
        return 1
    fi
    $1 | less
}

function mpv_detached() {
    # Run detached MPV player which allows closing terminal without ending MPV
    mpv --no-terminal 2 "$1" &>/dev/null &
}

function path-selector() {
    # Fuzzy find folders

    find \
        ~ \
        ~/.config \
        ~/Dropbox/code \
        ~/Dropbox/code/lanuages \
        ~/Dropbox/dev \
        ~/Dropbox/DropsyncFiles \
        ~/Dropbox/projects \
        ~/repos \
        -mindepth 1 -maxdepth 1 -type d | fzf
}

function path-switcher() {
    # Natigate to common folders
    cd "$(path-selector)" || return 1
}
