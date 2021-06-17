# System details

## system details
- `uname -a` kernel (name, release, version), system, nodename...
- `screenfetch` display system information

## distrubution
- `cat /etc/issue`
- `lsb_release -a`

## host name
- `hostname`

## user
- `whoami` logged user in current session
- `who` logged users in all session

## shell
- `echo $SHELL` current shell
- `less /etc/shells` list all shells avaliable

# Live information
## system status
- cat `/proc/cpuinfo`
- more in `/proc/`
    - `meminfo`, `/cmdline`...
    - `xxx/cwd`, `xxx/exe`, `xxx/fd` (where xxx is pid)

## running time
- `uptime` or `w`

# Others
## ip
- `curl ipinfo.io`

## date
- `date` local time
- `date -u` convert to UTC time zone
