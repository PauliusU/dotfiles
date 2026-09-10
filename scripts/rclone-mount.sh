#!/usr/bin/env bash
# Mounts an rclone remote as a local drive/folder - mechanism differs per OS, see below.
#
# Usage: rclone-mount.sh <remote-name> <target> [stop]
#   Windows: target = drive letter, e.g. G:      (needs `scoop install winfsp-np` once)
#   macOS:   target = mount point path, e.g. ~/mnt/my_remote (one mount at a time - the
#            local WebDAV port below is fixed, so a second concurrent mount would conflict)

remote="$1"
target="$2"
action="$3"

if [ -z "$remote" ] || [ -z "$target" ]; then
    echo "Usage: rclone-mount.sh <remote-name> <target> [stop]"
    exit 1
fi

case "$(uname)" in
    MINGW*|MSYS*)
        # WinFsp lets rclone mount the remote directly, no bridge needed.
        if [ "$action" = "stop" ]; then
            taskkill //F //IM rclone.exe 2>/dev/null
            echo "Stopped"
            exit 0
        fi
        rclone mount "${remote}:" "$target" --vfs-cache-mode writes
        ;;
    Darwin)
        # No FUSE-free direct mount - serve locally as WebDAV, mount_webdav connects to that.
        port=8082 # avoids the common 3000/5000/8080 dev-server defaults
        if [ "$action" = "stop" ]; then
            umount "$target" 2>/dev/null
            pkill -f "rclone serve webdav ${remote}:" 2>/dev/null
            echo "Stopped"
            exit 0
        fi
        pkill -f "rclone serve webdav ${remote}:" 2>/dev/null
        umount "$target" 2>/dev/null
        rclone serve webdav "${remote}:" --addr ":${port}" --vfs-cache-mode writes &
        sleep 1
        mkdir -p "$target"
        mount_webdav -S -v "$remote" "http://localhost:${port}" "$target"
        ;;
    *)
        echo "Unsupported OS: $(uname)"
        exit 1
        ;;
esac
