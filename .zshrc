export LANG=ja_JP.UTF-8

if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh

zplug load

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

PROMPT="%{${fg[red]}%}%n@%m%{${fg[blue]}%} %T%{${reset_color}%} %4~
$ "
#vcs_infoロード
autoload -Uz vcs_info
#PROMPT変数内で変数参照する
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

#vcs表示
##プロンプト表示前にvcs_info呼び出し
precmd() { vcs_info }
RPROMPT='${vcs_info_msg_0_}'
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
#エイリアス
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

alias mkdir='mkdir -p'

alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias cl="clear"
alias mv="mv -i"
alias cp="cp -i"
alias vi="vim"
alias ptex2pdf="ptex2pdf -l"
alias tweetvim="vim -c TweetVimHomeTimeline"
alias sudo='sudo '

#グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

export CLICOLORS=true
export TERM=xterm-256color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
alias ls='ls -G'

#環境変数
export GREP_OPTIONS='--color=auto'
export HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export VISUAL="/usr/local/bin/vim"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export ENHANCD_DISABLE_HOME=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
