# (FZF) CTRL-J - open selected file with $EDITOR
fzf-open-file() {
  local cmd="${FZF_CTRL_J_COMMAND:-fd --type f --hidden --follow --exclude '.git'}"
  setopt localoptions pipefail 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_J_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  vi "$dir"
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}
zle     -N   fzf-open-file
bindkey '^J' fzf-open-file

# Quickly spawn readonly psql session to employment-hero mainapp database
dbsession () {
  readonly local DB_HOST=${DB_HOST}
  readonly local DB_USER=${DB_USER}
  readonly local DB_PASS=${DB_PASS}
  readonly local DB_NAME=${DB_NAME}

  docker run -it \
    postgres:alpine \
      psql postgres://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME}
}

function mkcd() {
  local _ARV="$@"
  mkdir $_ARV || return 2

  # I use enhanced cd, so it need to be disabled
  unalias cd 2> /dev/null
  cd $_ARV
}

