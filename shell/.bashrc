# .bashrc for git-bash on Windows
echo ".bashrc"

if [[ $- == *i* ]]; then
    # Toggle between foreground and background processes with ctrl-z
    #
    # When ctrl-z is pressed, check if it is “i” is set in the shell options
    # – meaning “are we in an interactive shell”. If so, it is in bash and
    # fg process (e.g. vim) is suspended to background.
    # REF: https://schulz.dk/2022/01/26/using-ctrl-z-to-toggle-process-in-fg-bg/
    stty susp undef
    bind '"\C-z":" fg\015"'
fi

bind '"\e[20~":"tmux-sessionizer\n"' # bind F9 to run tmux-sessionizer script
bind '"\e[24~":"pwd\n"' # bind F12 to run pwd command
bind '"\C-f":"path-switcher\n"'
# Get list of key bindings
# bind -p

eval "$(zoxide init bash)"

source "$DOTFILES/shell/.shellrc.sh"
