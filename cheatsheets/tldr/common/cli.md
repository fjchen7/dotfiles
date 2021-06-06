> CLI basic operations
`{{ ^ is}} Ctrl`
`{{^[ is}} Alt {{/}} Option`

- Move Cursor
`{{ }}      ^a    {{Move to beginning of line}}`
`{{ }}      ^e    {{Move to ending of line}}`
`{{ }}      ^b    {{Move char ←}}`
`{{ }}      ^f    {{Move char →}}`
`{{ }}     ^[b    {{Move word ←}}`
`{{ }}     ^[f    {{Move word →}}`

- Kill / Delete
`{{ }}      ^h    {{Kill char in front of cursor}}`
`{{ }}      ^d    {{Kill char on cursor}}`
`{{ }}      ^w    {{Kill (Forward) chars from cursor to begging of word}}`
`{{ }}     ^[d    {{Kill (Backward) chars from cursor to ending of next word}}`
`{{ }}      ^u    {{Kill (Backward) chars from cursor to beginning of line}}`
`{{ }}      ^k    {{Kill whole line}}`

- Accept Line
`^[J {{or}} ^[j    {{Accept suggestion (supported by zsh plugin Autosuggest)}}`
`  ^j {{or}} ^m    {{Accept line}} (equal to Enter}}`
`{{ }}       ^o    {{Accept line and show next command in history}}`

- FZF
`{{ }}       ^m    {{Select line}}`
`  ^p {{or}} ^k    {{Up line in history}}`
`  ^n {{or}} ^j    {{Down line in history}}`

- MISC
`{{ }}       ^z    {{Switch between shell and vim}}`
`{{ }}     ^x^e    {{Open editor}}`
`{{ }}     ^x^u    {{Undo}}`
