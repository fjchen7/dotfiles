# find/fd

## logical expressions in find
- `-a`/`-and`: operator AND
- `-o`/`-or`: operator OR
- `!`/`-not`：operator NOT

Examples
- `find /media/d/ -type f ! \( -name "*deb" -o -name "*vmdk" \)`: not find files with name `*deb` or `*vmdk`
- `find /etc ! -path "/etc/cron*" ! -path "/etc/opt"`: find files in `/etc` but not in `/etc/cron*` and `/etc/opt`

## find files by date/time
- `find <path> -mtime +5`  last modified before 5 days ago

## find files less than given depth
- `fd <path> <file> -d 2`

## find and only print filename (without extension)
- `fd ".*.md" <path> --type f --exec basename {} .md`
