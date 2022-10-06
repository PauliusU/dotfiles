# Ubuntu 18.10 with Gnome shell settings

# Alt + Tab to switch only on current workspace in GNOME shell) [18.10]
gsettings set org.gnome.shell.app-switcher current-workspace-only true

# Enable Ubuntu Dock Minimize on Click [18.10]
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# Auto-hide the Ubuntu Dock [18.10]
# ref: https://askubuntu.com/questions/1005470/how-to-auto-hide-the-ubuntu-dock-using-gsettings-in-ubuntu-17-10
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
# gsettings set org.gnome.shell.extensions.dash-to-dock autohide true  # pagal aprasyma turi buti abi komandos, bet as tycia palikau tik viena

# KEYBOARD SHORTCUTS
# <Primary> = control

# Media keys
dconf write /org/gnome/settings-daemon/plugins/media-keys/on-screen-keyboard "'<Control><Alt><Super>k'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-mute "'XF86AudioMute'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up "'<Super>KP_Add'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down "'<Super>KP_Subtract'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/play "'<Super>F9'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/pause "'<Super>F8'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/stop "'<Super>F8'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/previous "'<Super>F9'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/next "'<Super>F10'"

# Programs and folders
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'open_home'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>e'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'xdg-open $HOME'"

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'shutdown_menu'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Primary><Shift><Alt>Delete'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'gnome-session-quit --power-off'"

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/name "'open_dowloans'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/binding "'<Primary><Super>KP_3'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/command "'xdg-open $HOME/Downloads'"

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/name "'open_applications'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/binding "'<Primary><Super>KP_2'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/command "'xdg-open /usr/share/applications'"

# Enable keyboard shortcuts
c0="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/'"
c1="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/'"
c2="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/'"
c3="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/'"

dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "[$c0, $c1, $c2, $c3]"