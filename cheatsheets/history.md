> In shell, Ctrl is ^, and Alt is ^[

- References
`{{https://devhints.io/bash#histor}}`
`{{https://wangdoc.com/bash/readline.html}}`

- History
`{{ }}       ^p    {{Show previous command}}`
`{{ }}       ^n    {{Show next command}}`
`{{ }}       fc    {{Edit last command in editor}}`
`{{ }}       !!    {{Last command}}`
`{{ }}       !n    {{#n command}}`
`{{ }}      !-n    {{#n command from the bottom}}`
`{{ }}      !str   {{Last command starting with}} str`
`{{ }}     !?str   {{Last command that contains}} str`
`{{ }}^str1^str2   {{Last command that contains}} str1{{, but replace}} str1 {{with}} str2`

- Argument Replacement
`{{ }}       ^[.   {{Cycle through last argument of previous commands}}`
`{{ }}        !$   {{Last argument}}`
`{{ }}        !^   {{1st argument}}`
`{{ }}       !:2   {{2nd argument}}`
`{{ }}     !:2-4   {{2nd to 4th arguments}}`
`{{ }}     !:1-$   {{All arguments}}`
