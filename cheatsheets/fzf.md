- Paste the selected files and directories onto Shell
`^t`
`{{* e.g.}} ls <^t>`

- Paste the selected command from history onto Shell
`^r`

- cd into the selected directory
`^[c`

- Accept line
`^m`

- Trigger fzf by ;<TAB> in Shell (customized configuration)
> https://bit.ly/3pp7k9P
`{{vim}} ;<TAB>             {{Select files under current directory}}`
`{{vim ~/hi}};<TAB>         {{Select files under ~ that match `hi`}}`
`{{ssh/telnet}} ;<TAB>`
`{{kill -9}} <TAB>`
`{{unset/export/unalias}} **<TAB>`
