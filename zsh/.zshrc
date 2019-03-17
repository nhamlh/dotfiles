export TERM=xterm-256color

source ~/.zplug/init.zsh

# install plugins which haven't been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  else
      echo
  fi
fi

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# Powerlevel9k configuration need to be set before zplug load otherwise it doesn't affect
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-fontconfig'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir virtualenv rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time custom)

POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─%B➤%b "
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

# Misc plugins
zplug "zdharma/fast-syntax-highlighting"
zplug "djui/alias-tips"
zplug "zlsun/solarized-man"
zplug "joel-porquet/zsh-dircolors-solarized"
zplug "skx/sysadmin-util"
zplug "zpm-zsh/ls"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-autosuggestions"
zplug "dflemstr/rq", from:gh-r, as:command
zplug "hlissner/zsh-autopair"

# Git plugins
zplug "Seinh/git-prune"
zplug "mdumitru/git-aliases"
zplug "voronkovich/gitignore.plugin.zsh"
zplug "so-fancy/diff-so-fancy"

zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", use:"shell/*.zsh"

# Container related plugins
zplug "plugins/kubectl", from:oh-my-zsh
zplug "ahmetb/kubectx", use:kubectx, as:command
zplug "ahmetb/kubectx", use:kubens, as:command
zplug "webyneter/docker-aliases"

zplug load


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

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
alias kns="kns"

###
### Configurations
###

bindkey -e # Use emacs input mode
bindkey '^ ' autosuggest-accept
bindkey '\C-h' backward-delete-word

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

# Setup rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Import my own custom zsh customizations
for src (~/.zsh.d/*) source $src

