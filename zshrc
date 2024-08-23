export GPG_TTY=$(tty)
export EDITOR=vim
export GIT_EDITOR=vim
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export WINDOWS_HOST=`grep -m 1 nameserver /etc/resolv.conf | awk '{print$2}'`
export ASDF_DATA_DIR=~/.asdf
export BAT_THEME="TwoDark"
export NNN_OPTS="H"
export LESS=-RS
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export CDPATH=~/dev

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

function zsh_platform_init() {
  case "$(uname -sr)" in
     Darwin*)
       echo 'Mac OS X'
       ssh-add --apple-use-keychain
       ;;

     # Linux*Microsoft*)
     #   echo 'WSL'  # Windows Subsystem for Linux
     #   ssh-add ~/.ssh/id_ed25519_ssh > /dev/null 2>&1  
     #   ;;
     #
     # Linux*)
     #   echo 'Linux'
     #   ssh-add ~/.ssh/id_ed25519_ssh > /dev/null 2>&1  
     #   ;;
     #
     # CYGWIN*|MINGW*|MINGW32*|MSYS*)
     #   echo 'MS Windows'
     #   ;;
     *)
       echo 'Other OS'
       ssh-add ~/.ssh/id_ed25519_ssh > /dev/null 2>&1  
       ;;
  esac
}

# echo "$(ps -o command $$ | tail -n 10)" >> ~/log.txt
#[[ "$(ps -o command $$ | tail -n 1)" != *"environ"* ]] && [[ "$(ps -o command $$ | tail -n 6)" != *"vscode"* ]] && [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}


eval "$(ssh-agent -s)" > /dev/null 2>&1  
zsh_platform_init

source /opt/asdf-vm/asdf.sh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

alias vim="nvim"
alias vi="nvim"
alias timed="hyperfine"
alias cls="clear"
alias catx="\cat"
alias cat="bat"

alias ls="eza --icons -G"
alias l="eza --icons -l"
alias lss='nnn -de'
alias lsx="\ls"

alias open="explorer.exe"
alias tree="eza -T --icons"
alias treex="\tree"
alias du="dust"
alias dux="\du"
alias g="lazygit"
alias stats="tokei"
alias ps="procs"
alias loc="tokei"
alias psx="\ps"
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias refresh="source ~/.zshrc"
alias zshrc="vim ~/.zshrc"
alias compose-reset='docker compose ls --format=json | jq ".[].ConfigFiles" --raw-output | tr -d "\n" |  xargs -d "," -I "compose_file"  docker-compose -f "compose_file" down --remove-orphans'
alias docker-up-rm="docker-compose rm -fsv; docker-compose up && docker-compose rm -fsv"
alias docker-force-reset="compose-reset; docker rm -f $(docker ps -q -a); docker system prune -fa"

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

function zvm_after_init() {
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
}

eval $(thefuck --alias)
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh 
eval "$(fasd --init auto)"

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey -v

takedir () {
  mkdir -p $@ && cd ${@:$#}
}

takeurl () {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

takegit () {
 git clone "$1"
 cd "$(basename ${1%%.git})"
}

take () {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]
  then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]
  then
    takegit "$1"
  else
    takedir "$@"
  fi
}

try_exec() {
  test -x $1 && $1
}

try_source() {
  test -x $1 && source $1
}

start_postgres () {
  docker run --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=p      ostgres -p 5432:5432 -d postgres
}

# vi mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | clip.exe
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.asdf/installs/rust/1.59.0/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Dev env
try_source $ASDF_DATA_DIR/plugins/dotnet/set-dotnet-env.zsh

[ -f "/home/lucasteles/.ghcup/env" ] && . "/home/lucasteles/.ghcup/env" # ghcup-env
