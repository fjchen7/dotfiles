set runtimepath+=~/.vim_runtime

source ~/.vimrc.d/basic.vim
" source ~/.vimrc.d/extended.vim
source ~/.vimrc.d/plugin.vim

try
    source ~/.vimrc.d/extra.vim
catch
endtry
