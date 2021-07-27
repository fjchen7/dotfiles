# completiton via fzf-tab
# most configurations are based on https://github.com/Aloxaf/fzf-tab
# ref:
#     - https://thevaluable.dev/zsh-completion-guide-examples/
#     - https://thevaluable.dev/zsh-install-configure-mouseless/
#
# zsh completion
# zstyle define <key>/<value> under specified <context> (just like namespace), where <value> can be retrived and used for specific purpose by zsh completion.
# ref: https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Overview-1
#      https://zsh.sourceforge.io/Guide/zshguide06.html (section 6.5)
# usage: zstyle '<context>' <key> <value...>
#       <context> for builtin completion: ":completion:<function>:<completer>:<command>:<argument>:<tag>"
#                 for fzf-tab: ":fzf-tab::<completer>:<command>:<argument>:<tag>"
#           <key> after locating context, completion can find <value...> according to <key>
#      <value...> is what completion gets. It can be any number of string.
# ref: https://unix.stackexchange.com/a/546920 usage example

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# preview directory's content with "tree" when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree -C -L 2 -h $realpath'
zstyle ':fzf-tab:complete:git-checkout:argument-rest' fzf-preview 'git show --stat --color --pretty=format:"%Cred%h%Creset%n%B%>(40)%Cgreen(%cr)%C(bold blue) <%an>%Creset%n" $word'
zstyle ':fzf-tab:complete:git-checkout:argument-rest' fzf-flags --preview-window down,70%,wrap

zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-s:toggle'

# command with PID as input
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
