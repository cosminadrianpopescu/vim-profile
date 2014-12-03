"Just a test
set nocompatible

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set undofile
set undodir=~/.vim/undos

let g:EclimHighlightTrace = 'Normal'
let g:EclimLogLevel = 'info'

source $VIMRUNTIME/vimrc_example.vim
""source $VIMRUNTIME/mswin.vim
set nobackup
execute pathogen#infect()
""behave mswin

let g:netrw_ftp_cmd="ftp -p"

let g:gundo_preview_bottom=1

let g:wintabs_ui_active_left='['
let g:wintabs_ui_active_right=']'

set runtimepath+=~/.vim/bundle/eclim

if $CHANGE_CURSOR == "1"
  let &t_SI .= "\<Esc>[5 q"
  let &t_EI .= "\<Esc>[1 q"
endif
let g:netrw_liststyle = 1
let g:netrw_use_errorwindow=0
autocmd VimLeave * silent !echo -ne "\033]112\007"
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
autocmd BufRead,BufNewFile *.twig setlocal filetype=htmldjango

autocmd BufRead,BufNewFile *.js autocmd! eclim_javascript
autocmd BufRead,BufNewFile *.jsp autocmd! eclim_html_validate
autocmd BufRead,BufNewFile *.module,*.php,*.inc autocmd! eclim_php
autocmd BufRead,BufNewFile * autocmd! eclim_refresh_files

" use \003]12;gray\007 for gnome-terminal

"nnoremap / /\v
"vnoremap / /\v

let g:Omnisharp_start_server = 0
""let g:EclimJavaSearchSingleResult = 'tabnew'
""let g:airline#extensions#eclim#enabled=1
""let g:airline_powerline_fonts = 1
set laststatus=2

set tabstop=4
set shiftwidth=4

set sessionoptions+=globals

" "let g:airline#extensions#tabline#enabled = 1

""let airline_theme = 'dark'

let g:ctrlp_user_command='find %s'
let g:ctrlp_lazy_update=1

if ($TABSTOP != '')
    execute ":set tabstop=" . $TABSTOP
    execute ":set shiftwidth=" . $TABSTOP
endif

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

set expandtab
set smarttab
set scrolloff=10

if ($JAVA == 'java')
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
endif

let mapleader=" "
set showtabline=2

set makeprg=/opt/php/bin/php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G
nmap <Leader>f :echo @%<cr>

nnoremap <Leader>p byw:PhpSearch -p <C-R>"<cr>
imap kk <C-R>"
imap <C-l> -<Esc>vy39po
nmap <Leader>d :pwd<cr>
nmap <Leader>t :NERDTreeToggle<cr>
nmap <Leader>J :JavaSearch -p 
""nmap <Leader>X <C-W><C-W>:q<cr>
nmap <Leader>x :WintabsClose<cr>:WintabsNext<cr>
nmap <Leader>w <C-W><C-w>z60<cr>
nmap <Leader>h :WintabsPrevious<cr>
nmap <Leader>j :buffer #<cr>
nmap <Leader>k :buffer #<cr>
nmap <Leader>l :WintabsNext<cr>
imap jj <del>
nmap <Leader>b ^
vmap <Leader>b ^
nmap <Leader>e $
vmap <Leader>e $
nmap <Leader>n :WintabsGo 
nmap <Leader>N :tabn 
nnoremap / /\v
cnoremap %s %s/\v

nmap <Leader>g :JavaSearchContext<cr>
nmap <Leader>i :JavaSearchContext -x implementors<cr>

inoremap <C-@> <C-x><C-u><C-p>_

""set guifont=Liberation_Mono
""colorscheme Monokai-Refined

if ($VIM_COLORS != "")
  colorscheme $VIM_COLORS
else
  colorscheme Monokai-Refined
  ""colorscheme monokai
endif

set relativenumber

""if (has("gui_running"))
""    set lines=999
""    set columns=999
""else
""    if (exists("+lines"))
""        set lines=50
""    endif
""    if (exists("+columns"))
""        set columns=50
""    endif
""endif

set dir=/tmp

set wildmode=longest,list

imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
imap <down> <nop>
vmap <left> <nop>
vmap <right> <nop>
vmap <up> <nop>
vmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>
nmap <up> <nop>
nmap <down> <nop>

"au GUIEnter * simalt ~x

"inoremap { {}<Left>
"inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
"
inoremap <tab> <C-R>=TriggerSnippet()<CR>
set clipboard=unnamed,unnamedplus
set guioptions-=m
set guioptions+=c
set guioptions-=T
set guioptions-=e
set guioptions-=a
set viminfo+=n$HOME/.vim/viminfo

nmap <Leader>s :w<cr>
nmap <Leader>q :WintabsClose<cr>
nmap <Leader>Q :q!<cr>:tabp<cr>
nmap <C-]> <C-w><C-]><C-w>T
nmap <C-\>> <C-w>}
vmap <leader>c <esc>:call feedkeys("\e`<i/*\e`>a*/\e")<cr>
nmap <leader>tw :%s/\v\s+$//ge \| :%s/\t/\=TabSpaces($TABSTOP)/ge \| :w<cr>

imap <Esc>oC <Esc>li

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType module set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType js set omnifunc=javascriptcomplete#CompleteJS
""autocmd FileType html setlocal foldmethod=indent
""autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType htm set omnifunc=htmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#CompleteCpp
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
""autocmd BufWritePre * :%s/\v\s+$//e | :%s/\t/\=TabSpaces($TABSTOP)/e

autocmd InsertEnter * setlocal foldmethod=manual
""autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
autocmd BufWritePost * setl fdm=syntax
""autocmd BufWritePost *.jsp call JavaRsync()
""autocmd BufWritePost *.xml call JavaRsync()
""autocmd BufWritePost *.js call JavaRsync()

""noremap <C-Tab> <C-W>w
""inoremap <C-Tab> <C-O><C-W>w
""cnoremap <C-Tab> <C-C><C-W>w
""onoremap <C-Tab> <C-C><C-W>w

"" Folding
set foldmethod=syntax
let php_folding=1
let javaScript_fold=1
let xml_syntax_folding=1

nmap <Leader><F3> :let @/ = "\\<" . expand("<cword>") . "\\>"<cr>

""noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

""vmap <S-Insert> "-d"*P
""nmap <S-Insert> "*P

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

function! TabSpaces(n)
  let result = ""
  for i in range(a:n)
    let result = result . " "
   endfor
  return result
endfunction

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE guifg=Black  guibg=Green     gui=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE guifg=Black  guibg=Green     gui=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE guifg=White  guibg=DarkBlue  gui=NONE
