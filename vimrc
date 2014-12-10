" ================================================================================
" Basic options
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
execute pathogen#infect()

" ================================================================================
" Powerline setup
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" ================================================================================
" Options settings
set undofile
set undodir=~/.vim/undos
set nobackup
"set runtimepath+=~/.vim/bundle/eclim
set laststatus=2
set tabstop=4
set shiftwidth=4
set sessionoptions+=globals
if ($TABSTOP != '')
    execute ":set tabstop=" . $TABSTOP
    execute ":set shiftwidth=" . $TABSTOP
endif
""set viewoptions=folds,cursor
set expandtab
set smarttab
set scrolloff=10
if ($JAVA == 'java')
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
endif
set showtabline=2
set relativenumber
set dir=/tmp
set wildmode=longest,list
set clipboard=unnamed,unnamedplus
set guioptions-=m
set guioptions+=c
set guioptions-=T
set guioptions-=e
set guioptions-=a
set viminfo+=n$HOME/.vim/viminfo
set foldmethod=syntax

" ================================================================================
" Global variable settings
let g:EclimHighlightTrace = 'Normal'
let g:EclimLogLevel = 'info'
""let g:EclimCompletionMethod='omnifunc'
let g:netrw_ftp_cmd="ftp -p"
let g:gundo_preview_bottom=1
let g:wintabs_ui_active_left='['
let g:wintabs_ui_active_right=']'
let g:netrw_liststyle = 1
let g:netrw_use_errorwindow=0
let g:Omnisharp_start_server = 0
let g:EclimJavaSearchSingleResult = 'edit'
let g:EclimPhpSearchSingleResult = 'edit'
let g:EclimCSearchSingleResult = 'edit'
""let g:airline#extensions#eclim#enabled=1
""let g:airline_powerline_fonts = 1
let g:ctrlp_user_command='find %s'
let g:ctrlp_lazy_update=1
let mapleader=" "
let php_folding=1
let javaScript_fold=1
let xml_syntax_folding=1

let g:sessionman_save_on_exit = 0
let g:togglecursor_default = 'block'
let g:togglecursor_insert = 'blinking_line'
let g:togglecursor_leave = 'blinking_line'
let g:sync_default_args = '--recursive'
let g:wintabs_wipeout_buffer_onclose = 1

""if $CHANGE_CURSOR == "1"
""  let &t_SI .= "\<Esc>[5 q"
""  let &t_EI .= "\<Esc>[1 q"
""endif

" ================================================================================
" Autocommands
autocmd VimLeave * silent !echo -ne "\033]112\007"
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
autocmd BufRead,BufNewFile *.twig setlocal filetype=htmldjango
autocmd BufRead,BufNewFile *.js autocmd! eclim_javascript
autocmd BufRead,BufNewFile *.jsp autocmd! eclim_html_validate
autocmd BufRead,BufNewFile *.module,*.php,*.inc autocmd! eclim_php
autocmd BufRead,BufNewFile * autocmd! eclim_refresh_files
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent noautocmd loadview
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType module set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType js set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType jsp set filetype=xml
autocmd InsertEnter * setlocal foldmethod=manual
autocmd BufWritePost * setl fdm=syntax

" ================================================================================
" Mappings
nmap <Leader>f :echo @%<cr>
nnoremap <Leader>p byw:PhpSearch -p <C-R>"<cr>
imap kk <C-R>"
imap <C-l> -<Esc>vy39po
nmap <Leader>d :pwd<cr>
nmap <Leader>t :NERDTreeToggle<cr>
nmap <Leader>J :JavaSearch -p 
nmap <Leader>x :WintabsClose<cr>:WintabsNext<cr>
nmap <Leader>w <C-W><C-w>z60<cr>
nmap <Leader>h :WintabsPrevious<cr>
nmap <Leader>k :call wintabs#previous()<cr>
nmap <Leader>j :call wintabs#previous()<cr>
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
"Mappings of cursors
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
"End mapping of cursors
inoremap <tab> <C-R>=TriggerSnippet()<CR>
nmap <Leader>s :w<cr>
nmap <Leader>q :WintabsClose<cr>:silent! edit<cr>
nmap <Leader>Q :q!<cr>:tabp<cr>
""nmap <C-]> <C-w><C-]><C-w>T
nmap <C-\>> <C-w>}
vmap <leader>c <esc>:call feedkeys("\e`<i/*\e`>a*/\e")<cr>
nmap <leader>tw :%s/\v\s+$//ge \| :%s/\t/\=TabSpaces($TABSTOP)/ge \| :w<cr>
imap <Esc>oC <Esc>li
nmap <Leader><F3> :let @/ = "\\<" . expand("<cword>") . "\\>"<cr>
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ================================================================================
" Custom functions
function! TabSpaces(n)
  let result = ""
  for i in range(a:n)
    let result = result . " "
   endfor
  return result
endfunction

function! Cp(source, dest)
    let dest_folder = substitute(a:dest, '\v[\/]?[^\/]+$', '', 'g')
    execute "!mkdir -p " . dest_folder
    execute '!cp "' . a:source . '" "' . a:dest . '"'
endfunction

" ================================================================================
" Colors
""set guifont=Liberation_Mono
if ($VIM_COLORS != "")
  colorscheme $VIM_COLORS
else
  colorscheme Monokai-Refined
  ""colorscheme monokai
endif

so ~/.vim/colors.vim
