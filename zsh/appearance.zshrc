# Zsh theme Location: ${ZSH}/themes
# Recommended themes：random robbyrussell pure spaceship

# https://github.com/denysdovhan/spaceship-prompt
# ZSH_THEME="spaceship"

# https://github.com/caiogondim/bullet-train.zsh
# ZSH_THEME="bullet-train"
# Prompt settings
# export BULLETTRAIN_CONTEXT_DEFAULT_USER=your_name # not show user name when current user is `your_name`
# export BULLETTRAIN_DIR_EXTENDED=0  # show short directory path

# https://gist.github.com/kevin-smets/8568070
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit p10k.zsh.
source ${DOTFILES_ROOT}/zsh/p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# avoid line end with % when using `printf`
# https://unix.stackexchange.com/a/167600
export PROMPT_EOL_MARK=''

# timer format
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/timer
export TIMER_FORMAT='[%d]'

# turn off bell/beep
unsetopt BEEP
