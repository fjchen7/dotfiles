
# tmux

Prefix key `<C-a>` operations

## Basic
- Help                     `?`
- Command prompt mode      `:`
- Detach session           `d`

## Session
- Switch sessions          `(`/`)` to previous / next
- List all sessions        `s`
- Rename                   `$`

## Window
- New window               `c`
- Select window
    - `p`/`C-p` to previous window
    - `n`/`C-n`/`C-x` to next window
- List all windows         `w`
    - `C-n`/`C-p` to select up / down
    - `<number>` (select windows by number)
- Switch with window #0    `tmux swap-window -t 0`
- Rename                   `,`

## Pane
- Select pane              `C-a`(left), `C-s`(down), `C-d`(right)
- Swap pane                `{`(previous), `}`(next)
- Split                    `v`/`%`(vertical), `h`/`"`(horizontal)
- Kill                     `x`
- Maximize                 `z`
    - `*z` will shows in left bottom when maxmizing
- Convert to Window        `!`
- Show pane number         `q`
