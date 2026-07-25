echo ".functions.sh ◘"

function yt() {
    #  Download youtube video, playlist or channel

    # Format for h264 and h265 codec:   -f "bestvideo[vcodec~='^((he|a)vc|h26[45])'][ext=mp4][height>=720][height<=1080][fps>=23]+bestaudio[ext=m4a]" \
    # --merge-output-format             Force container format when merging video and audio streams (MP4 for better device/player compatibility)
    # --add-metadata                    Alias for --embed-metadata but supports youtube-dl as well
    # --restrict-filenames              Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
    # --embed-thumbnail                 yt-dlp: Embed thumbnail in the video as cover art || youtube-dl: Embed thumbnail in the audio as cover art
    # --embed-subs                      Embed subtitles directly into the video file
    # --sub-langs                       Languages of subtitles to download (set YT_SUBS_LANGS in private shell rc; default en)
    # --write-auto-subs                 Also download auto-generated subtitles if manual subtitles aren't available
    # --cookies                         Use cookie file for authentication
    # --cookies-from-browser            Extract cookies from browser to avoid YouTube bot detection
    # -i                                alias for --ignore-errors
    yt-dlp \
        -f "bestvideo+bestaudio" \
        -o "%(upload_date)s-%(title)s_%(height)sp%(fps)s-%(vcodec)s.%(ext)s" \
        --merge-output-format mp4 \
        --add-metadata \
        --restrict-filenames \
        --embed-thumbnail \
        --embed-subs \
        --sub-langs "${YT_SUBS_LANGS:-en}" \
        --write-auto-subs \
        --cookies-from-browser chrome \
        -i \
        "$@"
}

function yyt() {
    #  Download youtube playlist or channel with archive
    yt \
        --download-archive "$DOTFILES/.config/yt-dlp/downloads.log" \
        "$@"
}

function yt-beginning() {
    #  Download youtube playlist or channel from the beginning
    yt --playlist-reverse "$@"
}

function yt-chapters() {
    #  Download youtube playlist or channel splitting chapters into separate files
    yt --split-chapters "$@"
}

function ytl() {
    # Download youtube playlist or channel but limit resolution to 1080p
    yt -f "bestvideo[height<=1080]+bestaudio" "$@"
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

    if [[ "$(uname)" == "Darwin" ]]; then
        # Hardware accelerated HEVC encoding on macOS (Apple Silicon)
        ffmpeg -hide_banner -i "$1" -c:a copy -c:v hevc_videotoolbox -q:v 50 -allow_sw 1 -tag:v hvc1 "${1%.*}.hevc-q50.mp4"
        return
    fi

    if [[ "$(uname)" == "Windows" ]]; then
        # Hardware accelerated HEVC encoding on Windows (NVIDIA GPU)
        # p1                fastest NVENC preset for windows
        ffmpeg -hide_banner -i "$1" -c:a copy -c:v hevc_nvenc -preset p3 -b:v 0 -qp 20 -vtag hvc1 "${1%.*}.hevc-p3-20.mp4"
        return
    fi

    # Software HEVC encoding
    # -preset medium    (default)
    # -c:a copy         stream copy audio instead of re-encoding
    # -crf 28           (default)
    # -tag:v hvc1       Make file compatible with Apple "industry standard" H.265. Gives Final Cut and Apple stuff compatibility
    ffmpeg -hide_banner -i "$1" -c:a copy -c:v libx265 -preset ultrafast -crf 20 -tag:v hvc1 "${1%.*}".hevc-ultrafast-20.mp4
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


function extract_audio() {
    # Extract audio from video

    # -vn                   skips the inclusion of the video stream,
    # -acodec copy			copies the picked audio streams (without re-encoding)
    ffmpeg -i "$1" -vn -acodec copy "${1%.*}.aac"
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
    # Run detached mpv per-OS: sensible hwdec, and on macOS launch the mpv.app
    # bundle (see below) instead of the Homebrew CLI formula.
    local _uname hwdec
    _uname="$(uname -s)"
    case "$_uname" in
        Darwin)
            hwdec="videotoolbox"
            ;;
        Linux)
            hwdec="auto"
            ;;
        MINGW*|CYGWIN*|MSYS*|Windows_NT)
            hwdec="dxva2"
            ;;
        *)
            hwdec="auto"
            ;;
    esac

    if [ "$_uname" = "Darwin" ]; then
        # macOS: launch mpv.app via `open`. A backgrounded CLI mpv renders fine
        # but its window won't foreground / isn't in Cmd+Tab — a bare CLI binary
        # doesn't get window activation, while an .app bundle does via
        # LaunchServices. Cask is deprecated (fails Gatekeeper, disabled
        # 2026-09-01); when gone, wrap the formula binary in a tiny .app instead.
        open -na mpv --args --force-window=immediate --hwdec="$hwdec" "$@"
    else
        mpv --no-terminal --force-window=immediate \
            --hwdec="$hwdec" "$@" >/dev/null 2>&1 &
    fi
}

function path-selector() {
    # Fuzzy find folders

    find -L \
        ~ \
        ~/.config \
        $FS \
        $FS/dev \
        $FS/github \
        $FS/projects \
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

function pdf-password-remove() {
    # Remove password from PDF file using qpdf
    # Usage: pdf-password-remove filename.pdf password
    # Output: filename_unlocked.pdf in the same directory

    if [ -z "$1" ]; then
        echo 'ERROR: PDF filename is missing. Usage: pdf-password-remove filename.pdf password'
        return 1
    fi

    if [ -z "$2" ]; then
        echo 'ERROR: Password is missing. Usage: pdf-password-remove filename.pdf password'
        return 1
    fi

    local input_file="$1"
    local password="$2"

    # Check if input file exists
    if [ ! -f "$input_file" ]; then
        echo "ERROR: File '$input_file' does not exist"
        return 1
    fi

    # Generate output filename: replace .pdf with _unlocked.pdf
    local output_file="${input_file%.pdf}_unlocked.pdf"

    # Check if output file already exists
    if [ -f "$output_file" ]; then
        echo "ERROR: Output file '$output_file' already exists"
        return 1
    fi

    # Remove password using qpdf
    qpdf --password="$password" --decrypt "$input_file" "$output_file"

    if [ $? -eq 0 ]; then
        echo "Successfully removed password. Output: $output_file"
    else
        echo "ERROR: Failed to remove password from PDF"
        return 1
    fi
}
