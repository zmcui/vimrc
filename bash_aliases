# zmc bash configuration
# formated by gg=G

# user defined aliases
## grep
alias gp='egrep -nr --exclude={tags,*.out} --exclude-dir={\.git,obj}'
## dirs operation command
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
## git relevent
source ~/workspace/github/vimrc/git.plugin.sh
## android relevent
source ~/workspace/github/vimrc/android.plugin.sh
## asr relevent
source ~/workspace/github/vimrc/asr.plugin.sh
## open (in vim) all modified files in a git rep
alias diffvim='vim `git diff --name-only` -p'

# Go language environment variables GOROOT , GOPATH and PATH
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export GOPROXY=https://goproxy.io

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
## Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
## Layout
export FZF_DEFAULT_OPTS="--height 50% --border --info=inline --history-size=20000"
## Key bindings: CTRL-T
export FZF_CTRL_T_OPTS="
--walker-skip .git,node_modules,target
--bind 'ctrl-/:change-preview-window(down|hidden|)'"
## Key bindings: CTRL-R
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"
## Key bindings: ALT-C
export FZF_ALT_C_OPTS="
--walker-skip .git,node_modules,target
--preview 'tree -C {}'"
## remove dup lines in history list
export HISTCONTROL=ignoreboth:erasedups
## fd - cd to selected directory
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }
    # fdr - cd to selected parent directory
    fdr() {
        local declare dirs=()
        get_parent_dirs() {
            if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
            if [[ "${1}" == '/' ]]; then
                for _dir in "${dirs[@]}"; do echo $_dir; done
            else
                get_parent_dirs $(dirname "$1")
            fi
        }
        local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
        cd "$DIR"
    }

# autojump
source /usr/share/autojump/autojump.bash
## For bash users, autojump keeps track of directories by modifying $PROMPT_COMMAND
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
## Integration fzf with autojump
j() {
    local preview_cmd="ls {2..}"
    if command -v exa &> /dev/null; then
        preview_cmd="exa -l {2}"
    fi

    if [[ $# -eq 0 ]]; then
        cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
    else
        cd $(autojump $@)
    fi
}

# enable case insensitive completion
bind 'set completion-ignore-case on'

# git completion
source /usr/share/bash-completion/completions/git

# catapult environment variables CATAPULTROOT , TRACINGPATH and PATH
export CATAPULTROOT=/home/zongmincui/workspace/github/catapult/
export TRACINGPATH=$CATAPULTROOT/tracing/bin/
export PATH=$TRACINGPATH:$PATH

# xclip
## ctrl-] then will copy whatever is on the current bash prompt to the clipboard.
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
bind '"\C-]":"\C-e\C-u pbcopy <<"EOF"\n\C-y\nEOF\n"'

# Ubuntu Manual: run vim as man pager and view c++ manpage with 'man' command
export MANPAGER="vim -M +MANPAGER -"
# cman() {
#     # fix cppman adds manpage path to mandb not working
#	/usr/bin/env man $* 2>/dev/null || cppman $*
# }
