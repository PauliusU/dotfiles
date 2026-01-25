#!/usr/bin/env bash

# One-stop entry point for dotfiles environment setup
# This script is idempotent - safe to run multiple times
#
# Usage:
#   ./install.sh                    # Run all setup scripts
#   ./install.sh --dry              # Dry-run (show what would run)
#   ./install.sh file-system        # Run only scripts matching "file-system"
#   ./install.sh --dry terminal     # Dry-run scripts matching "terminal"

# Get the directory where this script is located
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES="$DOTFILES"
echo "DOTFILES: $DOTFILES"

# Ensure FS is set (used by setup scripts for symlinks)
[ -z "$FS" ] && export FS="$(cd "$DOTFILES/../.." && pwd)"

cd "$DOTFILES" || exit 1

# Parse script arguments
grep_pattern=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    else
        grep_pattern="$1"
    fi
    shift
done

# Log function: prefixes with [DRY_RUN] when in dry-run mode
log() {
    if [[ $dry_run == "1" ]]; then
        echo "[DRY_RUN]: $1"
    else
        echo "$1"
    fi
}

echo "================================================================"
echo "  Dotfiles Installation Script"
echo "  Repository: $DOTFILES"
if [[ $dry_run == "1" ]]; then
    echo "  Mode: DRY RUN"
fi
if [[ -n "$grep_pattern" ]]; then
    echo "  Filter: $grep_pattern"
fi
echo "================================================================"
echo ""

# Detect platform
detect_platform() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macOS"
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "Linux"
    elif [[ "$(uname -sr)" == *"microsoft"* ]] || [[ "$(uname -sr)" == *"Microsoft"* ]]; then
        echo "WSL"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "Windows"
    else
        echo "Unknown"
    fi
}

PLATFORM=$(detect_platform)
echo "Detected platform: $PLATFORM"
echo ""

# Check if running on macOS
if [[ "$PLATFORM" == "macOS" ]]; then
    echo "================================================================"
    echo "  macOS Setup"
    echo "================================================================"
    echo ""

    # Check for Homebrew (required for macOS setup)
    if ! command -v brew &> /dev/null; then
        echo "⚠️  Homebrew not found. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo ""
        if [[ $dry_run == "0" ]]; then
            read -p "Press Enter to continue after installing Homebrew, or Ctrl+C to exit..."
        fi
    fi

    # Find all .sh scripts in setup-macos (top-level only, excludes nested folders if any)
    scripts=$(find "$DOTFILES/setup-macos" -maxdepth 1 -type f -name "*.sh" | sort)

    for script in $scripts; do
        script_name=$(basename "$script")

        # Skip scripts that do not match the grep pattern
        if [[ -n "$grep_pattern" ]] && ! echo "$script_name" | grep -q "$grep_pattern"; then
            log "skipping: grep \"$grep_pattern\" filtered out $script_name"
            continue
        fi

        log "running: $script_name"

        if [[ $dry_run == "0" ]]; then
            source "$script"
            echo "✓ $script_name complete"
            echo ""
        fi
    done

    echo "================================================================"
    echo "  ✓ macOS setup complete!"
    echo "================================================================"

elif [[ "$PLATFORM" == "WSL" ]] || [[ "$PLATFORM" == "Linux" ]]; then
    echo "================================================================"
    echo "  WSL/Linux Setup"
    echo "================================================================"
    echo ""

    # File system setup (includes WSL-specific symlinks)
    if [ -f "$DOTFILES/setup-macos/file-system.sh" ]; then
        echo "📁 Setting up file system..."
        source "$DOTFILES/setup-macos/file-system.sh"
        echo "✓ File system setup complete"
        echo ""
    fi

    echo "ℹ️  For full Linux/WSL setup, please run platform-specific scripts manually."
    echo "   See setup-macos/ directory for available scripts."
    echo ""

elif [[ "$PLATFORM" == "Windows" ]]; then
    echo "================================================================"
    echo "  Windows Setup"
    echo "================================================================"
    echo ""
    echo "ℹ️  Windows setup requires batch files (.bat) and PowerShell scripts."
    echo "   Please run the appropriate scripts from setup-windows/ directory:"
    echo ""
    echo "   Recommended order:"
    echo "   1. base-0-file-system.setup.private.bat"
    echo "   2. base-1-env-variables.setup.private.bat"
    echo "   3. base-2-scoop.setup.bat"
    echo "   4. base-3-git.setup.bat"
    echo "   5. base-4-ahk.setup.bat"
    echo "   6. Other setup scripts as needed"
    echo ""

else
    echo "❌ Unsupported platform: $PLATFORM"
    echo "   This script currently supports macOS, WSL, Linux, and Windows."
    exit 1
fi

echo ""
echo "================================================================"
echo "  Installation Summary"
echo "================================================================"
echo "  Platform: $PLATFORM"
echo "  Dotfiles: $DOTFILES"
echo ""
echo "  Next steps:"
echo "  1. Review and customize configuration files as needed"
echo "  2. Restart your terminal to apply shell changes"
echo "  3. Run this script again anytime to update your setup"
echo ""
echo "  This script is idempotent - safe to run multiple times!"
echo "================================================================"
