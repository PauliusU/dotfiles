echo ".functions.sh ◘"

function yt() {
    #  Download youtube playlist or channel

    # Format for h264 and h265 codec:   -f "bestvideo[vcodec~='^((he|a)vc|h26[45])'][ext=mp4][height>=720][height<=1080][fps>=23]+bestaudio[ext=m4a]" \
    # --restrict-filenames              Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
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

function yyt() {
    # Download with archive
    yt --download-archive "downloads.log" "$@"
}

function yt-fk() {
    # Download videos in 4K resolution
    yt -f "bestvideo[ext=mp4][height<=2160]+bestaudio[ext=m4a]" "$@"
}

function ytt() {
    # Download videos in max resolution
    yt -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]" "$@"
}

function yt-beginning() {
    #  Download youtube playlist or channel from the beginning
    yt --playlist-reverse "$@"
}

function yt-chapters() {
    #  Download youtube playlist or channel splitting chapters into separate files
    yt --split-chapters "$@"
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

function convert_to_av1() {
    # Convert video to av1 format

    if [ -z "$1" ]; then
        echo 'Input file is missing. E.g. "video.webm"'
        # Non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # -c:a copy         stream copy audio instead of re-encoding
    ffmpeg -hide_banner -i "$1" -c:a copy -c:v libaom-av1 -crf 30 -cpu-used 8 "${1%.*}".av1-30.mkv
}

function convert_to_hevc() {
    # Convert video to High Efficiency Video Coding (HEVC) / H.265

    if [ -z "$1" ]; then
        echo 'Input file is missing. E.g. "video.webm"'
        # Non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # -preset medium    (default)
    # -c:a copy         stream copy audio instead of re-encoding
    # -crf 28           (default)
    # -tag:v hvc1       Make file compatible with Apple "industry standard" H.265. Gives Final Cut and Apple stuff compatibility
    ffmpeg -hide_banner -i "$1" -c:a copy -c:v libx265 -preset ultrafast -crf 20 -vtag hvc1 "${1%.*}".hevc-ultrafast-20.mp4
}

function convert_to_avc() {
    # Convert video to Advanced Video Coding (AVC) / H.264

    if [ -z "$1" ]; then
        echo 'Input file is missing. E.g. "video.webm"'
        # Non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    # -c:a copy         stream copy audio instead of re-encoding
    # -preset medium    (default)
    ffmpeg -hide_banner -i "$1" -c:v libx264 -c:a copy "${1%.*}".avc.mp4
}

function convert_to_mp3s() {
    # Convert all files of the same format in the folder to MP3s

    if [ -z "$1" ]; then
        echo 'FILE FILTER ARGUMENT IS MISSING. E.g. "*.opus"'
        # Non-zero decimal number in the 1 - 255 range for failure
        return 1
    fi

    for f in "$1"; do ffmpeg -i "$f" "${f%.*}.mp3"; done
}

function merge_mp3s() {
    # Merge all *.mp3 files into single MP3 file

    for file in *.mp3; do
        echo "Processing $file"
        echo "file '$file'" >> list.txt
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
        # Non-zero decimal number in the 1 - 255 range for failure
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

    echo "uname: $(uname)"
    echo # Linux, Darwin, MINGW64_NT-10.0-25211
    echo "OSTYPE: $OSTYPE"
    echo # linux-gnu, darwin21, msys (Windows in Git Bash)
    uname -a
    echo

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
        ~/Dropbox/dev \
        ~/Dropbox/DropsyncFiles \
        ~/Dropbox/projects \
        ~/repos \
        -mindepth 1 -maxdepth 1 -type d | fzf
}

function path-switcher() {
    # Navigate to common folders
    cd "$(path-selector)" || return 1
}

function open_in_file_explorer() {
    # Open current directory in system specific file explorer or open file

    local path_or_file_to_open
    if [ -z "$1" ]; then
        path_or_file_to_open=.
    else
        path_or_file_to_open="$1"
    fi

    if [[ "$(uname)" == "Darwin" ]]; then open "$path_or_file_to_open" && return; fi
    if [[ $(uname) == "Linux" ]]; then xdg-open "$path_or_file_to_open" && return; fi
    start "$path_or_file_to_open"
}

function pwdc() {
    # Copy current working directory to clipboard

    if [ "$(uname)" = "Darwin" ]; then pwd | pbcopy && return; fi
    if [ "$(uname)" = "Linux" ]; then pwd | xclip && return; fi
    # When using Bash for Windows
    pwd | clip
}
