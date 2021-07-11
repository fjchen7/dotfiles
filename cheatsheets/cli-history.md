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
- `!-n`         #n most recent command

## parameter
first / last parameter
- `!^`          1st parameter
- `!$`          last parameter
- `^[.`         cycle through last parameter of previous commands

specified parameter
- `!:2`         2nd parameter
- `!:2-4`       2nd to 4th parameters
- `!:2-` / `!:2-$`  2nd to last argumnents

all parameters
- `!*`

## replacement
- `^str1^str2`  replace *str1* with *str2* in latest command that contains *str1*, and execute
- `!134:s/p/re` replace p with re in #134 command, and execute
