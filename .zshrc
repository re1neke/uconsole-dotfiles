# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]];
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

ENABLE_CORRECTION="true"

# DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_CUSTOM=$HOME/.zsh_custom

plugins=(git)

source $ZSH/oh-my-zsh.sh


# Personal aliases

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
