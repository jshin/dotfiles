
export LANG=ja_JP.UTF-8

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -u

autoload -Uz colors
colors

#setting history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

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

PROMPT="%{${fg[red]}%}%n@%m%{${fg[blue]}%} [%T]%{${reset_color}%} [%4~]
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
alias la='ls -la'
alias ll='ls -l'

alias mkdir='mkdir -p'

alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias mics="ssh -D 1080 g1344919@cc2000.kyoto-su.ac.jp"
alias cl="clear"
alias py="python"
alias py3="python3"
alias vi="vim"
alias ptex2pdf="ptex2pdf -l"
alias sshcc="ssh g1344919@cc2000.kyoto-su.ac.jp"
alias tweetvim="vim -c TweetVimUserStream"
alias sudo='sudo '

#グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

#ls色付け
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLORS=true
export TERM=xterm-256color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
alias ls='ls -G'

#環境変数
export PATH="/usr/local/Cellar/openssl/1.0.2a-1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Library/Tex/texbin:/Users/takuro/Documents/EGGX/:/Users/takuro/Documents/EGGX/:/Applications/eclipse/android-sdk-macosx/platform-tools:/Applications/eclipse/android-sdk-macosx/tools:$PATH"

export GREP_OPTIONS='--color=auto'
export HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/sbin:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export VISUAL="/usr/local/bin/vim"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
