# fzf

Paste the selected files and directories onto Shell
- `^t` (e.g. `ls <^t>`)

Paste the selected command from history onto Shell
- `^r`

cd into the selected directory
- `^[c`

Accept line
- `^m`

Trigger fzf by `;<TAB>` (customized configuration)
- `vim ;<TAB>`             Select files under current directory
- `vim ~/hi;<TAB>`         Select files under ~ that match *hi*
- Other frequently used commands: `kill`, `ssh`/`telnet`, `export`/`unset`/`unalias`
- [Reference](https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#dedicated-completion-key)
