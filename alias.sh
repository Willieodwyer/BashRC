# # # Alias # # #

# Set HOME, CORE, CLION

function change_dir {
  if [ -z $1 ]
  then
    pushd $HOME > /dev/null
  else
    pushd $1 > /dev/null
  fi
}

alias cd='change_dir'
alias pop='popd'
alias p='popd > /dev/null'
alias dirs='dirs | tr " " "\n"'

alias yum='sudo apt-get'
alias gits='git status'
alias make='\make -j `nproc`'
alias ninja='\ninja -j `nproc`'

alias clion='${HOME}/Stuff/clion-${CLION}/bin/clion.sh >/dev/null 2>&1 &'
alias rootlion='sudo ${HOME}/Stuff/clion-${CLION}/bin/clion.sh &'
alias copen='${HOME}/Stuff/clion-2020.1.1/bin/clion.sh'
alias studio='/home/will/Downloads/android-studio/bin/studio.sh &'

alias redir='cd `pwd`'
alias clean="git clean -fdx -e .idea -e core.dump -e *.deb -e credentials.json -e config.json* -e key_store.json -e heaptrack* -e '.vscode' ."
alias clip='xclip -selection clipboard'
alias fiend='gitfiend'
alias docker='sudo docker'
alias startvncserver='vncserver :1 -geometry 1920x1080'
alias stopvncserver='vncserver -kill :1'
alias decoder='cd $CORE/SDKs/EdgeVisDecoderSDK'
alias civetweb='$HOME/Downloads/civetweb/civetweb'
alias mount_devnas='sudo mount -t cifs //devnas.evsnet.local/Glasgow /devnas -o  username=william.odwyer'
alias cleanup_branches='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

alias drop="git stash && git stash drop >> ~/.dropped_stashes"

alias branch_cleanup='git remote prune origin | awk "/origin/ {print $4}" | cut -d "/" -f 2 | xargs git branch -d'

