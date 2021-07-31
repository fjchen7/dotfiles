
[[ -z $(which disable-fzf-tab) ]] && disable-fzf-tab

# +---------+
# | Options |
# +---------+

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to end if word had one match

# +---------+
# | zstyles |
# +---------+

# Set applied completers and the applied order
zstyle ':completion:*' completer _extensions _complete _approximate
# Enbale menu
zstyle ':completion:*' menu select
# Use cache for completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Colors for files and directories
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Descriptions -- color is not compatible with fzf-tab
zstyle ':completion:*:descriptions' format '[%d]'  # show group name
# zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
# zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' verbose yes

# Group matches
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''  # group results by category
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# Sort file by modification time (newest first), and use the target timestamp for symlinks (the option follow)
zstyle ':completion:*' file-sort change reverse follow
# Expand // to /
zstyle ':completion:*' squeeze-slashes true

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    mailman mailnull mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# prevent duplicate (a bug of _git completion) when completing git alias
# workaround
zstyle ':completion:*:*:git:*' tag-order 'common-commands' 'alias-commands' 'all-commands'
# zstyle ':completion:*:*:git:*' tag-order 'common-commands' 'all-commands' 'alias-commands'
zstyle ':completion:*:*:git:*' complete-options false

# +-------------+
# | completions |
# +-------------+

# _gnu_generic can create completions for gnu commands that list option help (when --help is used) in a standardized way.
compdef _gnu_generic fzf
compdef _gnu_generic curl

fpath=($DOTFILES_HOME/fzf/complete/ $fpath)
compinit -u  # -u to avoid security check
