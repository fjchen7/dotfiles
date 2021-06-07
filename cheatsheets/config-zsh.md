> zsh does not read `readline`, which means that it is not compatible with .inputrc. (https://superuser.com/a/278807)
> zsh has its own alternative solution: Zsh Line Editor (ZLE)
>
> [ZLE introduction]
`{{https://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/}}`
> [Reference]
`{{https://superuser.com/questions/269464/understanding-control-characters-in-inputrc}}`
`{{http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html}}`
`{{https://www.csse.uwa.edu.au/programming/linux/zsh-doc/zsh_19.html}}`

- ZLE
`zle -la                   {{List all available ZLE widgets}}`

- bindkey
> there are 8 keymaps: emacs, viins, vicmd, viopp, visual, isearch, command, .safe
`bindkey -l                {{list existing keymap}}`
`bindkey -a                {{List all bound keys (^[v stands for <alt-v>, ^z for <ctrl-z>)}}`
`bindkey '\eb'             {{see <alt-b> maps to which zle widget.}}`

- Show codes sent by keyboard (only Linux)
`showkey -a                {{show the escape sequence that the pressed keys send.}}`
> [Reference]
`{{https://en.wikipedia.org/wiki/List_of_Unicode_characters}}`
