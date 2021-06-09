# tmux

Prefix key `<C-s>`

## Basic

- run command out of tmux        `:`
- Detach session                 `d`

## Session
- New session                    `C-c`
- Switch sessions                `(` previous, `)` next
- List all sessions              `s`
- Rename                         `$`

## Window

- New window                     `c`
- Navigate window
    - `C-p`/`C-n` previous / next window
    - `C-s` last active window
- List all windows               `w`
    - `C-p`/`C-n` to up / down
    - `<number>` select windows by number
- Rename                         `,`

## Pane

- Navigate pane                  `C-h` `C-j` `C-k` `C-l` (left down up right)
- Split                          `|` vertical, `_` horizontal
- Resize pane                    `H` `J` `K` `L`
- Swap pane                      `{` previous, `}` next
- Maximize                       `z`
- Convert to window              `!`
- Kill                           `x`
- Show pane number               `q`
