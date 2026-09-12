# .bashrc for git-bash on Windows
# On Windows, psmux provides tmux-compatible multiplexer (tmux command alias)
echo ".bashrc"

if [[ $- == *i* ]]; then
    # ctrl-z toggles the current job between fg and bg instead of suspending it
    # REF: https://schulz.dk/2022/01/26/using-ctrl-z-to-toggle-process-in-fg-bg/
    stty susp undef
    bind '"\C-z":" fg\015"'
fi

# Key bindings: F9/ctrl-f -> tmux-sessionizer, F12 -> pwd (list all: `bind -p`)
bind '"\e[20~":"tmux-sessionizer\n"'
bind '"\e[24~":"pwd\n"'
bind '"\C-f":"tmux-sessionizer\n"'

eval "$(zoxide init bash)"
# zoxide 0.10.0 breaks __zoxide_pwd - restores 0.9.8 until fixed upstream
__zoxide_pwd() { cygpath -w "$(pwd -L)"; }

[ -z "$FS" ] && export FS="$(cd "$DOTFILES/../.." && pwd)"
source "$DOTFILES/shell/.shellrc.sh"

# Reports cwd via OSC 7, so herdr panes reopen in the right dir after a restart
__herdr_osc7() { printf '\033]7;file:///%s\033\' "$(cygpath -m "$PWD" 2>/dev/null)"; }
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}__herdr_osc7"
