# zsh does not read `readline`, which means that it is not compatible with .inputrc. (https://superuser.com/a/278807)
# zsh has its own alternative solution: Zsh Line Editor (ZLE)
#
# [zle introduction]
#     https://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/
# [reference]
#     https://superuser.com/questions/269464/understanding-control-characters-in-inputrc
#     http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
#     https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_19.html
#
# [Quick Guide]
#     - `showkey -a`: show the escape sequence that the pressed keys send.
#     - ^[v stands for <alt-v>, ^z for <ctrl-z>
# [list keymap]
#     there are eight keymaps: emacs, viins, vicmd, viopp, visual, isearch, command, .safe
#     - `bindkey -M <keymap>`: list all the bindings in a given key map.
#     - `bindkey '\eb'`: see <alt-b> maps to which zle widget.
#     - `zle -la`: list all available zle widges.


# <ctrl-z> switch Vim and ZSH
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z  # Here ^z can be replace by \32 found by `showkey -a`

# use `emacs' keymap
bindkey -e
