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
- `^j` or `^m` accept line (equal to `Enter`)
- `^e` accept suggestion (supported by zsh-autosuggests)
- `^[f` accept one word (supported by zsh-autosuggests)

FZF
- `^m` accept line
- `^p`/`^k` select line up, `^n`/`^j` select line down

MISC
- `^z` switch between shell and vim
- `^x^e` open editor
- `^x^u` undo

## Reading
https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md
