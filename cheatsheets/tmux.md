
# Prefix key (<C-a>) operations
- Basic
`{{Help}}                   ?`
`{{Command prompt mode}}    :`
`{{Detach session}}         d`

- Session
`{{Switch sessions}}        ( {{to previous}}`
`{{ }}                      ) {{to next}}`
`{{List all sessions}}      s`
`{{Rename}}                 {{tmux}} rename-session {{<new-name>}}`

- Window
`{{New window}}             c`
`{{Select window}}          p {{or}} C-p {{to previous window}}`
`{{ }}                      n {{or}} C-n {{or}} C-x {{to next window}}`
`{{ }}                      {{tmux}} select-windows {{-t <windows-number>/<windows-name>}}`
`{{List all windows}}       w {{(}}C-n {{/}} C-p {{to select up / down)}}`
`{{ }}                      {{<number> (select windows by number)}}`
`{{Switch with window #0}}  {{tmux}} swap-window {{-t 0}}`
`{{Rename}}                 ,`
`{{ }}                      {{tmux}} rename-window {{<new-name>}}`

- Pane
`{{Select Pane}}            C-a {{(left),}} C-s {{(down),}} C-d {{(right)}}`
`{{Vertical split}}         v {{or}} %`
`{{Horizontal split}}       h {{or}} "`
`{{Kill}}                   x`
`{{ }}                      {{tmux}} select-pane -U/D/L/R`
`{{Show pane number}}       q`
`{{Maximize}}               z`
`{{Convert to Window}}      !`
