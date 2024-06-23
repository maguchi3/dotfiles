# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# paths
export VOLTA_HOME="$HOME/.volta"
export XDG_CONFIG_HOME=$HOME/dotfiles

export PATH=$HOME/bin:$PATH
export PATH=$HOME/commands:$PATH

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:$HOME/.foundry/bin"
export PATH="$PATH:$HOME/playground/nand2tetris/tools"
export PATH="$PATH:/opt/homebrew/opt/postgresql@13/bin"


# display settings
export LANG=ja_JP.UTF-8

# homebrew
# export HOMEBREW_NO_AUTO_UPDATE=1

# asdf
. "$HOME/.asdf/asdf.sh"

# completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  FPATH="$(brew --prefix)/completions/zsh:${FPATH}"
  fpath=(${ASDF_DIR}/completions $fpath)

  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # expanded completion
  zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
  autoload bashcompinit && bashcompinit
  autoload -Uz compinit && compinit -i
fi
complete -C aws_completer aws
eval "$(npm completion)"

# keys
bindkey -e # emacs-like key binding
alias ll='ls -l'
alias la='ls -a'
alias be='bundle exec'
alias ll='ls -t'
alias la='ls -la'
alias vi='vim'
alias ai='cursor'
alias d='docker'
alias d-c='docker-compose'
alias copilot="gh copilot"
alias ghs="gh copilot suggest"
alias gce="gh copilot explain"
alias gcl='git clone'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gs='git status'
alias gst='git status'
alias gcm='git checkout master'
alias gad='git add'
alias gcom='git commit'
alias gpl='git pull'
alias gps='git push'
alias gpsh='git push origin head'
alias gpom='git pull origin master'
alias gmm='git merge master'
alias gws="gwselect"
alias sl='serverless'
alias fb='firebase'
alias am='amplify'
alias amp='amplify'
alias nv='nvim'
alias g='cd $(ghq root)/$(ghq list | peco)'
alias hb='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias ojt='oj test -c "go run main.go" -d tests/sample'
alias ojt:rand='oj test -c "go run main.go" -d tests/random'
alias ci='code-insiders'
alias pn='pnpm'
alias reload='exec $SHELL -l'
alias tf='terraform'

# options
setopt auto_cd
setopt no_beep
setopt nolistbeep

# tools

## aws
export AWS_DEFAULT_PROFILE="maguro"
export AWS_DEFAULT_REGION="ap-northeast-1"

## direnv
export EDITOR=code
eval "$(direnv hook zsh)"

## zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# pnpm completion
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/pnpm-shell-completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/Users/ryamaguchi/.ghcup/env" ] && source "/Users/ryamaguchi/.ghcup/env" # ghcup-env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryamaguchi/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ryamaguchi/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryamaguchi/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ryamaguchi/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# bun completions
[ -s "/Users/ryamaguchi/.bun/_bun" ] && source "/Users/ryamaguchi/.bun/_bun"
