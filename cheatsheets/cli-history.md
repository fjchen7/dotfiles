`^t` to show history
## latest command
latest command
- `!!`
- `sudo !!`     execute latest command with root
- `fc -c vim`   edit lastest command in vim

find command
- `!str`        latest command that starts with *str*
- `!?str`       latest command that contains *str*

## command by history id
- `!n`          command with id #n
- `!-n`         #n command from the bottom

## argument
all arguments
- `!*`

last argument
- `!$`          last argument
- `^[.`         cycle through last argument of previous commands

specified argument
- `!^`          1st argument
- `!:2`         2nd argument
- `!:2-4`       2nd to 4th arguments

## replacement
- `^str1^str2`  replace *str1* with *str2* in latest command that contains *str1*, and execute
- `!134:s/p/re` replace p with re in #134 command, and execute
