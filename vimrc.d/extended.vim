"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 此文件为扩展配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Temporary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>vrc :tabedit ~/.vim_runtime/vimrcs/basic.vim<cr>
nnoremap <leader>vp :tabedit ~/.vim_runtime/vimrcs/plugins_config.vim<cr>
nnoremap <leader>so :source ~/.vimrc<cr>:noh<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 命令栏里的 $d 自动变成 ~/Desktop/
cnoremap $h ~/
cnoremap $d ~/Desktop/

" 当前文件的路径
" http://vim.wikia.com/wiki/Get_the_name_of_the_current_file
cnoremap $. <C-r>=expand('%:p:h')<cr>/
cnoremap t.<tab> tabedit <c-r>=expand("%:p:h")<cr>/
cnoremap e.<tab> e <c-r>=expand("%:p:h")<cr>/

" 删除光标处与最后一个`/`之间内容
" :h ctrl-\
cnoremap $q <C-\>e DeleteTillSlash()<cr>

" 命令行模式增强，ctrl-j/k 向下/向上
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" 删除全部
"cnoremap <C-K>		<C-U>

" 历史命令
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 可视区域两边加上括号（弃用原因：减慢了 v$ 的速度）
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" 插入模式自动补全括号
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插入模式下输入 `xdate` 会自动转换成时间
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc
