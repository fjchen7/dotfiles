You can be more efficient if you know these commands.
# Brace expansion
- `mv foo{,.pdf} some-dir`    move foo and foo.pdf to some-dir
- `mkdir -p x-{1,2}/y-{3,4}`    create 4 folders
- `ls ./**/*.sh`    ls all *.sh under current directory

# completion with `;<TAB>`
- `vim ;<TAB>`             Select files under current directory
- `vim ~/hi;<TAB>`         Select files under ~ that match *hi*
- Other frequently used commands: `kill`, `ssh`/`telnet`, `export`/`unset`/`unalias`

[Reference](https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#dedicated-completion-key)

# quick cd
- `j <dir>`
- `^[c`

# fzf
## Paste the selected file/directory onto Shell
- `^t` (e.g. `ls <^t>`)

## enter into the selected directory
- `^[c`

# Subshell to avoid environment pollution
- `(cd /some/other/dir; other-command&)`
