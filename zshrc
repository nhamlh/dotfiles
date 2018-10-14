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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time custom)

POWERLEVEL9K_COLOR_SCHEME='dark'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─%B➤%b "
POWERLEVEL9K_VIRTUALENV_BACKGROUND='cyan'

# Misc plugins
zplug "zdharma/fast-syntax-highlighting"
zplug "djui/alias-tips"
zplug "zlsun/solarized-man"
zplug "seebi/dircolors-solarized"
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
zplug "Dbz/zsh-kubernetes"
zplug "ahmetb/kubectx", use:kubectx, as:command
zplug "ahmetb/kubectx", use:kubens, as:command
zplug "webyneter/docker-aliases"

zplug load

###
### Environment variables
###
export HISTFILE=~/.zsh_history
export HISTSIZE=1000

export ENHANCD_FILTER="fzf"
export ENHANCD_DOT_SHOW_FULLPATH=1

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="💡 Alias tip: "
export ZSH_PLUGINS_ALIAS_TIPS_FORCE=1
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1

###
### Aliases
###
alias vi=nvim
alias du="du -h"
alias df="df -h"

###
### Keybindings
###
bindkey '^ ' autosuggest-accept
