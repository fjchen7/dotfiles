> CLI basic operations
> In shell, Ctrl is ^, and Alt is ^[

- Move Cursor
`{{ }}      ^a     {{Move to beginning of line}}`
`{{ }}      ^e     {{Move to ending of line}}`
`{{ }}      ^b     {{Move char ←}}`
`{{ }}      ^f     {{Move char →}}`
`{{ }}     ^[b     {{Move word ←}}`
`{{ }}     ^[f     {{Move word →}}`

- Kill / Delete
`{{ }}      ^h     {{Kill char in front of cursor}}`
`{{ }}      ^d     {{Kill char on cursor}}`
`{{ }}      ^w     {{Kill (Forward) chars from cursor to start of word}}`
`{{ }}     ^[d     {{Kill (Backward) chars from cursor to end of word}}`
`{{ }}      ^u     {{Kill (Forward) chars from cursor to start of line}}`
`{{ }}      ^k     {{Kill (Backward) chars from cursor to end of line}}`

- Accept Line
`^[J {{or}} ^[j    {{Accept suggestion (supported by zsh plugin Autosuggest)}}`
`  ^j {{or}} ^m    {{Accept line (equal to}} Enter{{)}}`
`{{ }}       ^o    {{Accept line and show next command in history}}`

- FZF
`{{ }}       ^m    {{Accept line}}`
`  ^p {{or}} ^k    {{Up line in history}}`
`  ^n {{or}} ^j    {{Down line in history}}`

- MISC
`{{ }}       ^z    {{Switch between shell and vim}}`
`{{ }}     ^x^e    {{Open editor}}`
`{{ }}     ^x^u    {{Undo}}`

- Reading
`{{https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md}}`
