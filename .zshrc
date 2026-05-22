fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

plugins=(docker docker-compose fzf golang history-substring-search zoxide zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

eval "$(starship init zsh)"

# Automatically create or attach to a tmux session based on the current folder
t() {
    # Get the name of the current directory (slashes removed)
    local session_name=$(basename "$PWD" | tr '.' '_')
    
    # -A: Attach if exists, create if not
    # -s: Name the session after the folder
    # -c: Force new windows to open in this exact path
    tmux new -A -s "$session_name" -c "$PWD"
}

# Fuzzy find and attach to any running tmux session
tt() {
    local session
    # 1. List all sessions (just their names)
    # 2. Pass to fzf with a clean header
    # 3. Attach to the selected target
    session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf --reverse --header 'Select Tmux Session to Attach:')
    
    # If a session was chosen, attach to it
    if [[ -n "$session" ]]; then
        tmux attach -t "$session"
    else
        echo "No session selected."
    fi
}

alias ls='lsd -a'
alias l='ls'
alias yd='yt-dlp --sponsorblock-remove sponsor -f "bestvideo[height<=1440]+bestaudio/best[height<=1440]" --embed-chapters'
alias ydc='yt-dlp -f "bv*+ba/b" --cookies-from-browser firefox:~/.zen'
alias markalldown='find . -maxdepth 1 -type f -exec bash -c '\''markitdown "$1" -o "${1%.*}.md"'\'' _ {} \;'
alias n='nvim'
alias pdf='zathura --fork'
alias y='yazi'


export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export PATH="$PATH:$HOME/scripts"

export GPG_TTY=$(tty)

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
