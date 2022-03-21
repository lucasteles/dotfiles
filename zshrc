[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

eval "$(ssh-agent -s)" > /dev/null 2>&1  
ssh-add ~/.ssh/id_ed25519_ssh > /dev/null 2>&1  

#set clipboard terminal
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
 
#fpath+=$HOME/.zsh/typewritten
#TYPEWRITTEN_PROMPT_LAYOUT="half_pure"
#TYPEWRITTEN_RIGHT_PROMPT_PREFIX=" "
#TYPEWRITTEN_SYMBOL="❯"
#autoload -U promptinit; promptinit
#prompt typewritten

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NNN_OPTS="H"
export BAT_THEME="TwoDark"
export LESS=-RS
export EDITOR=vim
export GIT_EDITOR=vim

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
 
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

alias vim="nvim"
alias vi="nvim"
alias cls="clear"
alias catx="\cat"
alias cat="bat"

alias ls="exa --icons -G"
alias l="exa --icons -l"
alias lss='nnn -de'
alias lsx="\ls"

alias open="explorer.exe"
alias tree="exa -T --icons"
alias treex="\tree"
alias du="dust"
alias dux="\du"
alias g="lazygit"
alias stats="tokei"
alias ps="procs"
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
alias lvim="/home/lucasteles/.local/bin/lvim"
export CDPATH=~/dev:~/dev/a55

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

function zvm_after_init() {
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	ssh-add ~/.ssh/id_ed25519_ssh > /dev/null 2>&1
}

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /opt/asdf-vm/asdf.sh
eval $(thefuck --alias)
eval $(thefuck --alias oops)
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh 
 
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

export PATH=/home/lucasteles/.asdf/installs/rust/1.59.0/bin:$PATH

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

# vi mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | clip.exe
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

