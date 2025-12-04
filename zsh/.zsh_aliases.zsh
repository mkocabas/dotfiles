# ============================================================================
# LS / EZA (modern ls replacement)
# ============================================================================
if command -v eza &> /dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -l --icons --group-directories-first"
    alias la="eza -la --icons --group-directories-first"
    alias lt="eza --tree --level=2 --icons"
    alias lta="eza --tree --level=2 --icons -a"
else
    alias ls="ls --color=auto"
    alias ll="ls -lh"
    alias la="ls -lAh"
fi


# ============================================================================
# COMMON TOOLS
# ============================================================================
alias c="code ."
alias t="tmux"
alias ta="tmux attach"
alias tl="tmux list-sessions"
alias reload='source ~/.zshrc'
alias sz='source ~/.zshrc'


# Safety nets
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -pv"

# ============================================================================
# SYSTEM / UTILITIES
# ============================================================================
alias df="df -h"
alias du="du -h"
alias free="free -h"

# Network
alias myip="curl -s ifconfig.me"
if [[ "$(uname)" == "Darwin" ]]; then
    alias localip="ipconfig getifaddr en0"
else
    alias localip="hostname -I | awk '{print \$1}'"
fi
alias ports="lsof -i -P -n | grep LISTEN"

# ============================================================================
# MACOS SPECIFIC
# ============================================================================
if [[ "$(uname)" == "Darwin" ]]; then
    alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
    alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
    alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
    alias brewup="brew update && brew upgrade && brew cleanup"
    alias o="open ."
    alias pbc="pbcopy"
    alias pbp="pbpaste"
fi

# ============================================================================
# FUN / MISC
# ============================================================================
alias weather="curl wttr.in"
alias please="sudo"
alias fucking="sudo"
alias cls="clear"
alias path='echo -e ${PATH//:/\\n}'  # Print PATH entries on separate lines
alias now="date '+%Y-%m-%d %H:%M:%S'"
alias week="date +%V"  # Week number

# ============================================================================
# FUNCTIONS (alias-like)
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find file by name
ff() {
    find . -type f -iname "*$1*"
}

# Find directory by name
fd() {
    find . -type d -iname "*$1*"
}

# Extract any archive
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick backup of a file
bak() {
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

alias pixi-base='eval "$(pixi shell-hook --manifest-path ~/.pixi/base/pixi.toml)"'
