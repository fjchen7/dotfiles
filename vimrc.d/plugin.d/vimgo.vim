
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go
" 帮助：:h go-settings
" vim-go 的默认映射见：https://github.com/fatih/vim-go/blob/master/ftplugin/go.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_fmt_command = "goimports"  " 存储时自动格式化和导入包
let g:go_list_type = "quickfix"  "vim有两类错误：location-list和quickfix。只有quickfix可以用:cn和:cp跳转。

"autocmd FileType go nmap <space>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <space>gr  <Plug>(go-run)
autocmd FileType go nmap <space>gt  <Plug>(go-test)
autocmd FileType go nmap <space>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <space>gi <Plug>(go-info)

":A 在 Current Buffer 调用 :GoAlternate
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
":AV 在 vertical split 调用 :GoAlternate
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
":AS 在 split 调用 :GoAlternate
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
"AT 在 New Tab 调用 :GoAlternate
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoTestCompile for `_test.go` file and :GoBuild for `.go`
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
