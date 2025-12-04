#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
OS="$(uname)"

echo "Setting up dotfiles for $OS..."

# Install Homebrew if on macOS and not present
if [[ "$OS" == "Darwin" ]] && ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install antidote if not installed
if [ ! -d "${ZDOTDIR:-$HOME}/.antidote" ]; then
    echo "Installing antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${ZDOTDIR:-$HOME}/.antidote"
fi

# Install fzf if not installed
if [ ! -d ~/.fzf ]; then
    echo "======================"
    echo "== FZF INSTALLATION =="
    echo "======================"
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# Prompt for pixi installation
echo ""
echo "======================"
echo "== PIXI SETUP ========"
echo "======================"
read -p "Do you want to install pixi package manager? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v pixi &> /dev/null; then
        echo "Installing pixi..."
        curl -fsSL https://pixi.sh/install.sh | sh
        
        # Source the pixi environment to make it available in current session
        export PATH="$HOME/.pixi/bin:$PATH"
    else
        echo "pixi is already installed."
    fi
    
    # Create global pixi environment
    if [ ! -d ~/.pixi/global ]; then
        echo "Creating global pixi environment..."
        mkdir -p ~/.pixi/global
        cd ~/.pixi/global
        pixi init
        cd - > /dev/null
        echo "✓ Global pixi environment created at ~/.pixi/global"
    else
        echo "Global pixi environment already exists at ~/.pixi/global"
    fi
else
    echo "Skipping pixi installation."
fi


# Create symlinks
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES/zsh/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
ln -sf "$DOTFILES/zsh/.zsh_aliases.zsh" "$HOME/.zsh_aliases.zsh"
ln -sf "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

echo "✓ Dotfiles installed successfully!"
echo "  Restart your shell or run: source ~/.zshrc"