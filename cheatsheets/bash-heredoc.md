# heredoc
[Reference](https://wangdoc.com/bash/quotation.html)

## `echo "abc" | command` in heredoc way
```bash
command <<EOF
abc
EOF
```

## set variable by heredoc
```bash
new_var=$(cat <<EOF
${food} is very delivious!
EOF
)
```

See [More](https://stackoverflow.com/a/1655389)
## ignore tab and space
```bash
cat<<-EOF
  "two spaces"
    "one tab"
EOF
```
