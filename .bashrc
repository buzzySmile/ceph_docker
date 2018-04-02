# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# QT
export QT_SELECT=qt5.7

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# другие разрешающие настройки:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # только для bash>=2.04
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob

# Запрещающие настройки:
shopt -u mailwarn
unset MAILCHECK         # Я не желаю, чтобы командная оболочка сообщала мне о прибытии почты

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HOSTFILE=$HOME/.hosts    # Поместить список удаленных хостов в файл ~/.hosts

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#some aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Предотвращает случайное удаление файлов.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias print='/usr/bin/lp -o nobanner -d $LPDEST'   # Предполагается, что LPDEST определен
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # Печать через enscript
alias background='xv -root -quit -max -rmode 5'    # Положить картинку в качестве фона
alias du='du -kh'
alias df='df -kTh'

# some more ls aliases
alias ls='ls -hF --color'       # выделить различные типы файлов цветом
alias lx='ls -lXB'              # сортировка по расширению
alias ll='ls -alF'  
alias la='ls -Al'               # показать скрытые файлы
alias l='ls -CF'
alias tree='tree -Csu'          # альтернатива 'ls'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -x /usr/bin/mint-fortune ]; then
     /usr/bin/mint-fortune
fi

#-----------------------
# Custom add to path
#   Android Studio bin
if [ -d "$HOME/android-studio/bin/" ] ; then
  PATH="$HOME/android-studio/bin/:$PATH"
fi

# startup msg
# Для начала определить некоторые цвета:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color (нет цвета)

echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN}"
date
echo -e "${NC}"
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune     # сделает наш день более интересным.... :-)
fi

#-----------------------------------
# Функции для работы с файлами и строками:
#-----------------------------------

# Поиск файла по шаблону:
function ff() { find . -type f -iname '*'$*'*' -ls ; }
# Поиск файла по шаблону в $1 и запуск команды в $2 с ним:
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
# поиск строки по файлам:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: поиск строки в файлах.
Порядок использования: fstr [-i] \"шаблон\" [\"шаблон_имени_файла\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function cuttail() # удалить последние n строк в файле, по-умолчанию 10
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # перевести имя файла в нижний регистр
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: имя файла $file не было изменено."
        fi
    done
}

function swap()         # меняет 2 файла местами
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


#-----------------------------------
# Функции для работы с процессами/системой:
#-----------------------------------

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# Эта функция является грубым аналогом 'killall' в linux
# но не эквивалентна (насколько я знаю) 'killall' в Solaris
function killps()   # "Прибить" процесс по его имени
{
    local pid pname sig="-TERM"   # сигнал, рассылаемый по-умолчанию
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Порядок использования: killps [-SIGNAL] шаблон_имени_процесса"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Послать сигнал $sig процессу $pid <$pname>?"
            then kill $sig $pid
        fi
    done
}

function my_ip() # IP адрес
{
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
}

function ii()   # Дополнительные сведения о системе
{
    echo -e "\nВы находитесь на ${RED}$HOST"
    echo -e "\nДополнительная информация:$NC " ; uname -a
    echo -e "\n${RED}В системе работают пользователи:$NC " ; w -h
    echo -e "\n${RED}Дата:$NC " ; date
    echo -e "\n${RED}Время, прошедшее с момента последней перезагрузки :$NC " ; uptime
    echo -e "\n${RED}Память :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}IP адрес:$NC" ; echo ${MY_IP:-"Соединение не установлено"}
    echo -e "\n${RED}Адрес провайдера (ISP):$NC" ; echo ${MY_ISP:-"Соединение не установлено"}
    echo
}