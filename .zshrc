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

alias ls='lsd -a'
alias l='ls'
alias update='sh ~/scripts/update.sh'
alias yd='yt-dlp --sponsorblock-remove sponsor -f "bestvideo[height<=1440]+bestaudio/best[height<=1440]" --embed-chapters'
alias ydc='yt-dlp -f "bv*+ba/b" --cookies-from-browser firefox:~/.zen'
alias markalldown='find . -maxdepth 1 -type f -exec bash -c '\''markitdown "$1" -o "${1%.*}.md"'\'' _ {} \;'
alias pdf='zathura --fork'


export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export PATH="$PATH:$HOME/scripts"

export GPG_TTY=$(tty)
