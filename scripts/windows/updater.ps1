ECHO "**** UPDATE SOFT ****"

ECHO "**** NPM ****"
npm list -g --depth=0 --long

ECHO "**** PIP ****"
python -m pip list --user
python -m pip install --upgrade pip --user

ECHO "**** Rust ****"
rustup update
cargo install --list

ECHO "**** SCOOP ****"
scoop status
scoop update *
# Update global scoop installs. "scoop update --global" does not work
scoop update CascadiaCode-NF-Mono --global
scoop update FiraCode-NF-Mono --global
# Remove old versions of apps installed by scoop
scoop cleanup *

ECHO "**** WINGET [silent] ****"
winget upgrade --all --silent

Start-Sleep -Seconds 3
