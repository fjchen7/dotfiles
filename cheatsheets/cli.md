# CLI basic guide

> Ctrl is `^`, Alt is `^[`

Move Cursor

- `^a` move to start of line, `^e` move to end of line
- `^b` move to char ←, `^f` move to char →
- `^[b` move to word ←, `^[f` move to word →

Kill
- `^h` kill char ←, `^d` kill char →
- `^w` kill to word ←, `^[d` kill to word →
- `^u` kill whole line, `^k` kill to line →

Accept Line
- `^[J` or `^[j` accept suggestion (supported by zsh plugin Autosuggest)
- `^j` or `^m` accept line (equal to `Enter`)
- `^o` accept line and show next command in history

FZF
- `^m` accept line
- `^p` or `^k` select line up
- `^n` or `^j` select line down

MISC
- `^z` switch between shell and vim
- `^x^e` open editor
- `^x^u` undo

## Reading
https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md
