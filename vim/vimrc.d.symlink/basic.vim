"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reference:
"       https://github.com/amix/vimrc
"       https://github.com/wklken/k-vim
"       https://github.com/liuchengxu/space-vim
"       https://spacevim.org/
"
" Help:
"   搜索对应 Section：/=> key
"   映射的符号见：:h notation
"   查看映射是否被占用：:map <leader>p
"   查看所有的命令：:command
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set shellcmdflag=-ci

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Init
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader key
let mapleader = ","
let g:mapleader = ","
" 方向键
nnoremap j gj
nnoremap k gk

" 设置命令行模式的别名
" https://stackoverflow.com/a/7515418/10134408
fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Feature
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 检查是否开启：:filetype；
" :h vimrc-filetype
filetype plugin indent on " 插件、缩进和文件类型

set nocompatible " 关闭 vi 兼容模式
set mouse-=a " 不启用鼠标
set history=500 " history 存储容量
"set shell=zsh\ -i " 在 iTerm2 的 vi 下用 :NERDTreeToggle 时起冲突

" 语言和编码
let $LANG='en'
set encoding=utf-8
set langmenu=en
set helplang=cn

" turn off bell
set belloff=all
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" 启动的时候不显示援助乌干达儿童的提示
set shortmess=atI

" 取消备份
set nobackup
" 不生成交换文件
" http://blog.csdn.net/pwiling/article/details/51830781
set noswapfile
set nowb

" 执行宏时不重绘界面（提高性能）
set lazyredraw

" For regular expressions turn magic on
set magic

" zsh的自动补全风格
set wildmode=full

" wildmenu：命令模式里按 Tab 后显示的候选项菜单
set wildmenu
" wildmenu 里忽略显示的文件
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 语法高亮
syntax enable

" Highlight line and column
set cursorline
set cursorcolumn
" Minimal lines above and below the cursor
set scrolloff=4
" 禁止光标闪烁
"set gcr=a:block-blinkon0

" 显示行号
set number
"" 显示相对行号: 行号变成相对，可以用 nj/nk 进行跳转
"set relativenumber number
"au FocusLost * :set norelativenumber number
"au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
"autocmd InsertEnter * :set norelativenumber number
"autocmd InsertLeave * :set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
"nnoremap <C-n> :call NumberToggle()<cr>

set showmatch " 高亮匹配的括号
set matchtime=2 " 匹配括号时的响应时间（1/10s 为单位）

" 只让高亮行出现在当前窗口，且在插入模式中关闭这个效果
" https://github.com/mhinz/vim-galore#smarter-cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" gui 界面
if has("gui_running")
    set guioptions-=l " 无左滚动条
    set guioptions-=r " 无右滚动条
    set guioptions-=L " 垂直分割窗口无左滚动条
    set guioptions-=R " 垂直分割窗口无右滚动条

    set guioptions-=T " 无工具栏
    set guioptions-=e " 无默认标签文本
    "set guitablabel=%M\ %t " 显示自定义标签文本
endif

" status line
set laststatus=2 "显示下方的状态栏
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme='solarized256'
" 状态栏格式化
" http://www.xefan.com/archives/83820.html
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ \ %p%%

" 右下角
set ruler " 显示当前光标坐标
set showcmd " 显示普通模式下输入的命令
set showmode " 显示当前vim 模式

" theme
colorscheme molokai
set background=dark
set t_Co=256 " 色彩范围

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 测试字体效果：:set guifont=* 和 :put=&guifont测试字体效果
set guifont=Monaco:h14

" 在 tmux 里色彩更一致
if exists('$TMUX')
    set term=screen-256color
endif

" 根据模式改变光标类型
" https://github.com/mhinz/vim-galore#change-cursor-style-dependent-on-mode
if empty($TMUX)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indent & wrap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab indent
set tabstop=4  " <tab> witdh equals to 4 spaces
set expandtab  " replace <tab> with space
set shiftwidth=4 " < and > give 4-spaces indent
set softtabstop=4  " <delete> remove 4 space at ont time
set smarttab

" indent
set autoindent " 新行自动缩进
set smartindent " auto indent 的增强版
"set cindent " C-style indent

set wrap " 窗口宽度小于行长度时，自动换行
set linebreak " 换行时不会切断英文单词
set textwidth=500 " 超过字符后自动换行

" line width limit
let &colorcolumn="120"  " show column when one line exceeds 120 char
"let &colorcolumn="80,".join(range(120,999),",")

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map 0 ^
nnoremap U <C-r>

" 上下滚动
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" 将 meta 设成 Alt 键，只在 GUIVim 下有效。
if has("gui_macvim")
    set macmeta
endif
" Alt-j/k 上下移动当前行
" 若想使用 ⌘ - j/k ，则设置成<D-j/k>
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
"vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" 上下移动行，可配合数字
" https://github.com/mhinz/vim-galore#quickly-move-current-line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" 快速添加空行，可配合数字
" https://github.com/mhinz/vim-galore#quickly-add-empty-lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Paste
nnoremap Y y$
"set clipboard=unnamed " 使用系统剪切板
noremap <leader>y "+y
noremap <leader>Y "+y$
noremap <leader>d "+d
noremap <leader>D "+D
noremap <leader>p "+p
noremap <leader>P "+P
inoremap ^"p <Esc>p
inoremap ^"P <Esc>:pu!<cr>
inoremap ^p <Esc>"+p
inoremap ^P <Esc>:pu! +<cr>

"noremap <C-[> <C-t>" 回退

" 打开/关闭 paste mode
" paste mode 下，vim 去掉粘贴代码的缩进
map <leader>mp :setlocal paste!<cr>

" select block
nnoremap <leader>v v`}
nnoremap <leader>V V`}

" 调整缩进时防止失去选区
" https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
xnoremap <  <gv
xnoremap >  >gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <space> /
set hlsearch " 高亮搜索结果
set incsearch " 即时高亮第一个搜索结果
set ignorecase " 搜索忽略大小写
set smartcase " 关键词全小写字母时，忽略大小写；存在大写字母时，不忽略大小写；

" 取消搜索高亮
map <silent> <leader><cr> :noh<cr>

" 保持搜索结果在屏幕中间
"nnoremap <silent> n nzzzv
"nnoremap <silent> N Nzzzv

" 可视模式下，*/# 搜索可视内容（默认是搜索光标所在单词）
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" n / N 始终为向前 / 后搜索，不会因为 / 或 ? 的搜索方式而改变。
" https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭当前缓冲区。如果当前缓存区在多个 tab/window 里，则会一起关闭
"map <leader>bc :Bclose<cr>:tabclose<cr>gT
"call SetupCommandAlias("bclose", ":Bclose<cr>:tabclose<cr>gT")
command! Bclose :Bclose | tabclose | tabnext
call SetupCommandAlias("bc", "Bclose")

" 关闭所有标签里的所有缓冲区
"map <leader>bca :bufdo bd<cr>
"command! BcloseA :bufdo bd
call SetupCommandAlias("bca", "bufdo bd<cr>")

" 切换缓冲区
nnoremap <tab> <C-S-^>
nnoremap - :bprevious<cr>
nnoremap = :bnext<cr>
nnoremap <left> :bprevious<cr>
nnoremap <right> :bnext<cr>
"nnoremap ]b :bnext<cr>
"nnoremap [b :bprevious<cr>
"nnoremap <leader>l :bnext<cr>
"nnoremap <leader>h :bprevious<cr>
"nnoremap <leader><tab> :bnext<cr>
"nnoremap <leader><S-tab> :bprevious<cr>

" 切换到缓冲区的行为
set switchbuf=useopen,usetab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 切换窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 新建窗口打开 buffer 里的轮换文件
map <leader>^ <C-W><C-^>

" 只留当前窗口
"map <leader>on :only<cr>

set splitright " 垂直分屏在右边
set splitbelow " 水平分屏在下面

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call SetupCommandAlias("tn", "tabnew")
call SetupCommandAlias("te", "tabedit")
call SetupCommandAlias("tc", "tabclose")
call SetupCommandAlias("to", "tabonly")
call SetupCommandAlias("tm", "tabmove")


" 切换 tab
if has("gui_running")
    " 在终端vim里不起作用
    map <C-tab> :tabnext<cr>
    map <C-S-tab> :tabprev<cr>
endif
map ]t :tabnext<cr>
map [t :tabnext<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
nmap <Leader>t :execute "tabnext ".g:last_active_tab<CR>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" normal模式下<⌘-number>切换到指定tab。
noremap <D-1> 1gt
noremap <D-2> 2gt
noremap <D-3> 3gt
noremap <D-4> 4gt
noremap <D-5> 5gt
noremap <D-6> 6gt
noremap <D-7> 7gt
noremap <D-8> 8gt
noremap <D-9> 9gt
noremap <D-0> :tablast<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save and exit
nmap <leader>s :w<cr>
imap ^s <Esc>:w<cr>
" 使用 sudo 对文件进行保存（当没有权限时候很有用）
command! W w !sudo tee % > /dev/null

" Auto read file if modified
set autoread
" 文件未保存时，也不会禁止切换到其他文件
set hidden

" Delete trailling blank lines when saving.
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" 打开文件后，定位到上次编辑处
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 防止切换 buffer 时，光标在屏幕的绝对位置改变
" https://stackoverflow.com/a/18244751/10134408
if v:version >= 700
    au BufLeave * if !&diff | let b:winview = winsaveview() | endif
    au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | unlet! b:winview | endif
endif

" 修改*.vim和.vimrc配置文件后自动加载
autocmd! bufwritepost *.vim,.vimrc source ~/.vimrc | redraw | execute "echom '.vimrc is sourced!'"
call SetupCommandAlias("vrc", "e ~/.vim_runtime/vimrcs/basic.vim")

" 外部程序打开文件
nnoremap <silent> \ :!open <C-R>%<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix：上/下一个错误
"nnoremap <C-M> :cp<cr>
"nnoremap <C-N> :cn<cr>
" 关闭 quickfix
"nnoremap <Leader>a :cclose<CR>

" 方便选择命令行历史和补全
" https://github.com/mhinz/vim-galore#saner-command-line-history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"set autochdir " 自动将 CWD 切换为当前缓冲区所在目录

" 重绘当前屏幕
" https://github.com/mhinz/vim-galore#saner-ctrl-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 删除行尾空格
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
" -bar 表示命令后面可以跟 |
command! -bar Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
