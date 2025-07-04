# Lines configured by zsh-newuser-install

# PS1 and colors
autoload -U colors && colors
# PROMPT='%F{5}%1~ %(?.%F{2}λ.%F{9}λ)%F{15} '
# PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]%(?.%F{2}λ.%F{9}λ)%F{15} "
PROMPT="%B%{$fg[red]%}[%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]%(?.%F{2}λ.%F{9}λ)%F{15} "

autoload -Uz vcs_info
zstyle ':vsc_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats '%m%u%c %b'
precmd() {
    print -Pn "\e]133;A\e\\"
    vcs_info
}

setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'

HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
export LC_ALL=en_US.UTF-8
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit -C

# use vim keys
bindkey -v
export KEYTIMEOUT=1

#Loak syntax highliting
source "$HOME/.config/zsh/plugins/alias.zsh" 2>/dev/null
source "$HOME/.config/zsh/plugins/functions.zsh" 2>/dev/null
source $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
