# Hourly backup using rsync
#
# rsync [OPTION]... SRC [SRC]... DEST
#  -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
#           -r, --recursive             recurse into directories
#           -l, --links                 copy symlinks as symlinks
#           -p, --perms                 preserve permissions
#           -t, --times                 preserve modification times. This  tells rsync to transfer modification times along with the files and update them on the remote
#           -g, --group                 preserve group
#           -o, --owner                 preserve owner (super-user only)
#           -D                          same as --devices --specials
#                       --devices               preserve device files (super-user only)
#                       --specials              preserve special files
#  -v, --verbose               increase verbosity
#  --delete                    delete extraneous files from dest dirs


mkdir -p ~/Downloads/bak/.config/
rsync -av --delete ~/.config/chromium ~/Downloads/bak/.config/
rsync -av --delete ~/.config/rclone ~/Downloads/bak/.config/
rsync -av --delete ~/.rtorrent ~/Downloads/bak/
rsync -av --delete ~/.ssh ~/Downloads/bak/