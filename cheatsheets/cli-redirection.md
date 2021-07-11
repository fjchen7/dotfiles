# `2>&1` redirects stderr and stdout
redirect stdout(1) and stderr(2) to file
- `command >file 2>&1`
- `command &> file` (not all shells support)

redirect stderr to stdout(2>&1), and then redirect original stdout to file
- `command 2>&1 >file`

# `<` replaces stdin with file
read from file_y by lines and write into file_x
- `while read a b; do echo $b $a >> file_x; done < file_y`

# `<(...)` treats commands as file
- `grep hi <(ls)`: grep output from `ls`
- `diff /etc/hosts <(ssh somehost cat /etc/hosts)`: diff local /etc/hosts with a remote one
