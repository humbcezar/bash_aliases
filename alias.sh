# Show git branch name
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt

alias eb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias gc='git checkout'
alias gp='git pull'
alias gps='git push'
alias gs='git status'
alias code='cd ~/code'
alias vup='cd ~/Homestead && vagrant up --provision'
alias vssh='cd ~/Homestead && vagrant ssh'
alias vrel='cd ~/Homestead && vagrant reload --provision'
alias hsconfig='cd ~/Homestead && vim Homestead.yaml'
alias hosts='sudo vim /etc/hosts'
alias hs='cd ~/Homestead'
alias gcb='git checkout -b'
alias gd='git diff'
alias gmt='git merge master --no-commit --no-ff'
alias ct='ctags -R --exclude=node_modules --PHP-kinds=cfi --regex-php="/^[ \t]*trait[ \t]+([a-z0_9_]+)/\1/t,traits/i"'

function run() {
    number=$1
    shift
    for n in $(seq $number); do
      $@
    done
}

punit() {
     e=${1}
     cat .env | sed -i "s/DB_USERNAME=.*$/DB\_USERNAME\=homestead/" .env
     cat .env | sed -i "s/DB_HOST=.*$/DB_HOST\=127\.0\.0\.1/" .env
     cat .env | sed -i "s/DB_PASSWORD=.*$/DB\_PASSWORD\=secret/" .env
     head -n 20 .env
     command=$(echo ${e} | sed 's/\/home\/humberto\/code\/.*\/tests\//vendor\/phpunit\/phpunit\/phpunit\ tests\//')
     ${command}
}
loc() {
     database=$1
     cat .env | sed -i "s/^DB_DATABASE=.*$/DB\_DATABASE=$database/" .env
     cat .env | sed -i "s/DB_USERNAME=.*$/DB\_USERNAME\=homestead/" .env
     cat .env | sed -i "s/DB_HOST=.*$/DB_HOST\=127\.0\.0\.1/" .env
     cat .env | sed -i "s/DB_PASSWORD=.*$/DB\_PASSWORD\=secret/" .env
     head -n 20 .env
}
p() {
     cat .env | sed -i "s/DB_USERNAME=.*$/DB\_USERNAME\=homestead/" .env
     cat .env | sed -i "s/DB_HOST=.*$/DB_HOST\=127\.0\.0\.1/" .env
     cat .env | sed -i "s/DB_PASSWORD=.*$/DB\_PASSWORD\=secret/" .env
     head -n 20 .env
     phpunit "$@"
}
ctrans(){
     path=$(echo ${1} | sed 's/(app.*\)/resources\/lang\/pt\/\1/')
     mkdir -p "$(dirname "$path")"
     touch $path
     printf "<?php \n\treturn [\n\n\t];" > ${path}
}
