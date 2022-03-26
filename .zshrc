export LANG=ja_JP.UTF-8
export VISUAL="/usr/local/bin/nvim"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export HOMEBREW_NO_ANALYTICS=1
export FZF_DEFAULT_OPTS='--height 40% --reverse'

. $HOME/.asdf/asdf.sh

source <(afx init)

autoload -Uz compinit
compinit -u

autoload -Uz colors
colors

#setting history
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

bindkey -e

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

zstyle ':completion*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

#sudo の後ろでコマンドを補完する
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

####################################
#オプション
setopt print_eight_bit
#ビープ音を消す
setopt no_beep
#フローコントロールを無効に
setopt no_flow_control
# '#'以降をコメントとして扱う
setopt interactive_comments
#ディレクトリ名だけでcdする
setopt auto_cd
#cdしたら自動的にpusdする
setopt auto_pushd
#重複したディレクトリを追加しない
setopt pushd_ignore_dups
#同時に起動したzshの間でヒストリを共有
setopt share_history
#同じコマンドをヒストリに残さない
#setopt hist_ignore_all_dups
#スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
#ヒストリに保存するとき余計なスペースを削除する
setopt hist_reduce_blanks
#高機能なワイルドカード展開をする
setopt extended_glob

######################################
#aliases
alias cp='cp -i'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias rm='rm -i'
alias sudo='sudo '

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lg='lazygit'
alias tweetvim='vim -c TweetVimHomeTimeline'

#グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

export CLICOLORS=true
export TERM=xterm-256color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
alias ls='ls -G'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.`hostname -s` ] && source ~/.zshrc.`hostname -s`

eval "$(starship init zsh)"
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
