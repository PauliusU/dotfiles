#!/usr/bin/env bash

# One-stop entry point for dotfiles environment setup
# This script is idempotent - safe to run multiple times

set -e  # Exit on error

# Get the directory where this script is located
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "DOTFILES: $DOTFILES"
cd "$DOTFILES" || exit 1

echo "================================================================"
echo "  Dotfiles Installation Script"
echo "  Repository: $DOTFILES"
echo "================================================================"
echo ""

# Detect platform
detect_platform() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macOS"
    elif [[ "$(uname -sr)" == *"microsoft"* ]] || [[ "$(uname -sr)" == *"Microsoft"* ]]; then
        echo "WSL"
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "Linux"
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
        read -p "Press Enter to continue after installing Homebrew, or Ctrl+C to exit..."
    fi

    # File system setup (creates directories and symlinks)
    if [ -f "$DOTFILES/setup-macos/file-system.sh" ]; then
        echo "📁 Setting up file system..."
        source "$DOTFILES/setup-macos/file-system.sh"
        echo "✓ File system setup complete"
        echo ""
    fi

    # Install software via Homebrew
    if [ -f "$DOTFILES/setup-macos/install-soft.sh" ]; then
        echo "📦 Installing software..."
        source "$DOTFILES/setup-macos/install-soft.sh"
        echo "✓ Software installation complete"
        echo ""
    fi

    # Setup terminal commands (symlinks scripts to ~/.local/bin)
    if [ -f "$DOTFILES/scripts/1-setup-scripts.sh" ]; then
        echo "🔧 Setting up terminal commands..."
        source "$DOTFILES/scripts/1-setup-scripts.sh"
        echo "✓ Terminal commands setup complete"
        echo ""
    fi

    # Terminal and shell configuration
    if [ -f "$DOTFILES/setup-macos/terminal-and-shell.sh" ]; then
        echo "💻 Configuring terminal and shell..."
        source "$DOTFILES/setup-macos/terminal-and-shell.sh"
        echo "✓ Terminal configuration complete"
        echo ""
    fi

    # File associations
    if [ -f "$DOTFILES/setup-macos/file-associations.sh" ]; then
        echo "🔗 Setting up file associations..."
        source "$DOTFILES/setup-macos/file-associations.sh"
        echo "✓ File associations setup complete"
        echo ""
    fi

    # macOS system settings
    if [ -f "$DOTFILES/setup-macos/settings-macos.sh" ]; then
        echo "⚙️  Applying macOS system settings..."
        source "$DOTFILES/setup-macos/settings-macos.sh"
        echo "✓ System settings applied"
        echo ""
    fi

    # Development tools
    if [ -f "$DOTFILES/setup-macos/dev-tools.sh" ]; then
        echo "🛠️  Setting up development tools..."
        source "$DOTFILES/setup-macos/dev-tools.sh"
        echo "✓ Development tools setup complete"
        echo ""
    fi

    # Private git setup (if exists)
    if [ -f "$DOTFILES/setup-macos/private/git.setup.sh" ]; then
        echo "🔐 Setting up private git configuration..."
        source "$DOTFILES/setup-macos/private/git.setup.sh"
        echo "✓ Private git setup complete"
        echo ""
    fi

    # AI tools setup (if exists)
    if [ -f "$DOTFILES/setup-macos/ai-tools.private.sh" ]; then
        echo "🤖 Setting up AI tools..."
        source "$DOTFILES/setup-macos/ai-tools.private.sh"
        echo "✓ AI tools setup complete"
        echo ""
    fi

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
