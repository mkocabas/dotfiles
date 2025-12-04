# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

source ~/.antidote/antidote.zsh

antidote load

autoload -Uz promptinit && promptinit && prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
[ -f ~/.zsh_aliases.zsh ] && source ~/.zsh_aliases.zsh

if [ -d ~/.pixi/ ]; then
  # add pixi to path
  export PATH="$HOME/.pixi/bin:$PATH"

  # zsh, default on macOS
  fpath+=($HOME/.pixi/completions/zsh)
  autoload -Uz compinit
  compinit
fi

# initialize pixi-base environment
pixi-base
