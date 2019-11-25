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
#zle     -N   fzf-open-file
#bindkey '^J' fzf-open-file

fzf-select-tmux-window() {
  local cmd="tmux list-windows | awk -F' ' '{print $1\" \"$2}'"
  setopt localoptions pipefail 2> /dev/null
  local chosen="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_J_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$chosen" ]]; then
    zle redisplay
    return 0
  fi

  local window_num=$(awk -F' ' '{print $1}')
  tmux select-window  $window_num

  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}

# Quickly spawn a psql session
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
  mkdir -p $_ARV || return 2

  builtin cd $_ARV
}

# Create a file/folder under /tmp if not exist
# Jump to folder or open file with EDITOR
function tmp() {
  while (( $# )); do
    case "$1" in
    "-d")
      mkdir "/tmp/$2" 2> /dev/null
      cd "/tmp/$2"
      shift
      shift
      ;;
    *)
      $EDITOR "/tmp/$1"
      shift
    esac
  done
}

# Quickly boostrap a dev environment
function dev() {
  tmux_panes=$(tmux list-panes | wc -l)

  if ! [[ $tmux_panes -eq 1 ]]; then
    tmux new-window
  fi

  tmux rename-window $(basename $PWD)
  tmux split-pane -l 12
  tmux send-key -t 0 "vi" Enter
  tmux select-pane -t 0
}

