> zsh won't read _readline_, so it's incompatible with .inputrc. (ref: https://superuser.com/a/278807, https://superuser.com/a/269471).

zsh has its own alternative solution: Zsh Line Editor (ZLE)

- [ZLE introduction](https://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/)
- [ZLE documentation](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html)
    - [Standard Widgets](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets)

# Bindkey

> There are 8 keymaps.
> : The applied keymap is 'viins' when $EDITOR contains 'vi', otherwise 'emacs'.
> : When editor starts up the applied keymap is 'main', which is actually a linking of 'emacs' or 'viins' (`bindkey -lL main` show this).

## list

list existing keymap
- `bindkey -l`

list bound keys in the given keymap
- `bindkey -M <keymap>` (`^[v` is _alt-v_, `^z` is _ctrl-z_)

show the widge that _alt-b_ maps to (can check if this key is bound)
- `bindkey '\eb'`

## bind key

bind _ctrl-t_ to execute 'uptime'
- `bindkey -s '^T' 'uptime\n'`

find escape sequence
- [Re: key code table](https://www.zsh.org/mla/users/2014/msg00266.html): escape sequence list
- `showkey -a` Show the escape sequence that the pressed keys send (only Linux)

# Widgets

list all user-defined zle widgets
- `zle -l`
