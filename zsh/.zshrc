export TERM=xterm-256color
export ZSH_CACHE_DIR="/tmp"

# Install zplugin if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

# Load zplugin
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Functions to make configuration less verbose
zt() { zplugin ice wait"${1}" lucid               "${@:2}"; } # Turbo
zi() { zplugin ice lucid                            "${@}"; } # Regular Ice
z()  { [ -z $2 ] && zplugin light "${@}" || zplugin "${@}"; } # zplugin

# Prompt settings
zi src"powerlevel10k.zsh-theme"; z romkatv/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir virtualenv rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time custom)

POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─%B➤%b "
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

#zi pick"async.zsh" src"pure.zsh"; z "sindresorhus/pure"

# Misc plugins
zt 0b; z "zdharma/fast-syntax-highlighting"
zt 0b; z "djui/alias-tips"
zt 0b; z "zlsun/solarized-man"
zt 0b; z "joel-porquet/zsh-dircolors-solarized"
zt 0b; z "skx/sysadmin-util"
zt 0b; z "zpm-zsh/ls"
z "zsh-users/zsh-autosuggestions"
zt 0b; z "hlissner/zsh-autopair"
zt 0b src"init.sh"; z "b4b4r07/enhancd"
zt 0b from"gh-r" as"program"; z "dflemstr/rq"
zt 0b from"gh-r" pick"*-linux-x64" mv"ffsend-* -> ffsend" as"program";z "timvisee/ffsend"
zt 0b multisrc"asdf.sh completions/asdf.bash";z "asdf-vm/asdf"

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

###
### Configurations
###

bindkey -e # Use emacs input mode
bindkey '^ ' autosuggest-accept
bindkey '\C-h' backward-delete-word

eval $(direnv export zsh)

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
setopt interactivecomments

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Import my own custom zsh customizations
for src (~/.zsh.d/*) source $src

