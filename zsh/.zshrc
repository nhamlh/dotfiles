# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=xterm-256color
export ZSH_CACHE_DIR="/tmp"

# Install zinit if not installed
if [ ! -d "${HOME}/.zinit" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/mod-install.sh)"
fi

# Load zinit
source ~/.zinit/mod-bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Functions to make configuration less verbose
zt() { zinit ice wait"${1}" lucid             "${@:2}"; } # Turbo
z()  { [ -z $2 ] && zinit light "${@}" || zinit "${@}"; } # zplugin

# Prompt settings
z romkatv/powerlevel10k

# Misc plugins
zt 0b; z "zdharma/fast-syntax-highlighting"
zt 0b; z "djui/alias-tips"
zt 0b; z "zlsun/solarized-man"
zt 0b; z "joel-porquet/zsh-dircolors-solarized"
zt 0b; z "skx/sysadmin-util"
zt 0b; z "zpm-zsh/ls"
zt 0b atload"_zsh_autosuggest_start" ; z "zsh-users/zsh-autosuggestions"
zt 0b; z "hlissner/zsh-autopair"
zt 0b src"init.sh"; z "b4b4r07/enhancd"
zt 0b from"gh-r" as"program"; z "dflemstr/rq"
zt 0b from"gh-r" pick"*-linux-x64" mv"ffsend-* -> ffsend" as"program";z "timvisee/ffsend"
z "asdf-vm/asdf"

# Git plugins
zt 0b; z "Seinh/git-prune"
z snippet "OMZ::lib/git.zsh"; z "mdumitru/git-aliases"
zt 0b; z "voronkovich/gitignore.plugin.zsh"
zt 0b pick"diff-so-fancy" as"program"; z "so-fancy/diff-so-fancy"
zt 0b from"gh-r" mv"fzf-* -> fzf" as"program"; z "junegunn/fzf-bin"
zt 0b pick"shell/*.zsh"; z "junegunn/fzf"

## Container related plugins
z snippet "OMZ::plugins/kubectl/kubectl.plugin.zsh"
zt 0b; z "webyneter/docker-aliases"
zt 0b pick"kube*" as"program"; z "ahmetb/kubectx"

###
### FZF configuration
###
export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude ".git"'
export FZF_CTRL_T_OPTS='
  --preview "bat --color=always {}"
'

export FZF_CTRL_J_COMMAND='fd --type f --hidden --follow --exclude ".git"'
export FZF_CTRL_J_OPTS='
  --preview "bat --color=always {}"
'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude ".git"'
export FZF_ALT_C_OPTS="
  --preview 'ls --color=always {}'
"

__gen_fzf_color_scheme() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Solarized Dark color scheme for fzf
 cat <<EOF
--color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
--color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
EOF
}

export FZF_DEFAULT_OPTS="
--exact
$(__gen_fzf_color_scheme)
"

###
### Environment variables
###
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

export ENHANCD_FILTER="fzf"
export ENHANCD_DOT_SHOW_FULLPATH=1

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="💡 Alias tip: "
export ZSH_PLUGINS_ALIAS_TIPS_FORCE=1
ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1

export EDITOR=nvim
export WORDCHARS=''               # Make M-f and M-b work better for me
export EXTENDEDGLOB=1             # globbing

export BAT_THEME="Solarized (light)"

###
### Aliases
###
alias vi=nvim
alias cat=bat
alias du="du -h"
alias df="df -h"
alias dig="dig +short"
alias eio="exercism"
alias tf="terraform"
alias ktx="kubectx"
alias kns="kubens"
alias em='emacsclient -create-frame --alternate-editor=""'
alias u="ffsend upload --copy"
alias dc="docker-compose"
alias a="asdf"
alias ls="exa --icons --sort type"
alias cdpr="cd $PROOT"

###
### Configurations
###

bindkey -e # Use emacs input mode
#bindkey '^ ' autosuggest-accept
bindkey '\C-h' backward-delete-word

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
setopt interactivecomments

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Import my own custom zsh customizations
for src (~/.zsh.d/*.zsh) source $src
