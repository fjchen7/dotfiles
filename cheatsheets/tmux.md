Prefix key `<C-s>`

## basic
- run command out of tmux        `:`
- detach session                 `d`
- kill                           `x`

## session
- new session                    `C-c`
- switch sessions                `(` previous, `)` next
- list all sessions              `s`
- rename                         `$`

## window
- new window                     `c`
- navigate window
    - `C-p`/`C-n` previous / next window
    - `C-s` last active window
- list all windows               `w`
    - `C-p`/`C-n` to up / down
    - `<number>` select windows by number
- rename                         `,`

## pane
- navigate pane                  `C-h` `C-j` `C-k` `C-l` (left down up right)
- split                          `|` vertical, `_` horizontal
- resize pane                    `H` `J` `K` `L`
- swap pane                      `{` previous, `}` next
- maximize                       `z`
- convert to window              `!`
- show pane number               `q`
