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
set mouse=
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
let g:airline_powerline_fonts = 1
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
let g:EasyMotion_skipfoldedline = 0
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']
let g:ctrlp_regexp = 1
let g:sw_delete_tmp = 0
""let g:sw_asynchronious = 1

let g:sw_exe = 'java -jar /home/lixa/programs/sources/sql-workbench-116/sqlworkbench.jar'
let g:sw_config_dir = '/home/lixa/.sqlworkbench/'
let g:sw_asynchronious = 1

let @o = ':SWDbExplorer '
let @c = ':SWDbExplorerClose'
let @s = ':SWSqlOpen '
let @r = ':SWSqlBufferRestore'
let @d = ':SWDbExplorerRestore'

if $OS =~ '\c\vwindows'
	let g:ctrlp_user_command='/mnt/e/bin/ctrlp-find %s'
	let g:sw_plugin_path = 'e:/.vim/bundle/vim-sql-workbench/'
	let g:sw_exe = 'c:/Pgm/workbench/sqlwbconsole.exe'
	let g:sw_tmp = 'e:/tmp'
	let g:sw_config_dir = 'z:/.sqlworkbench/'
	let g:sw_vim_exe = 'DISPLAY=localhost:0 /opt/vim/bin/vim'
endif

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
autocmd FileType mason set filetype=xml
autocmd BufEnter *.jspf set filetype=xml
autocmd InsertEnter * setlocal foldmethod=manual
autocmd BufWritePost * setl fdm=syntax

autocmd FileType java nnoremap <leader>g :JavaSearchContext<cr>
autocmd FileType php nnoremap <leader>g :PhpSearchContext<cr>

" ================================================================================
" Mappings
nmap <Leader>f :echo @%<cr>
""nnoremap <Leader>p byw:PhpSearch -p <C-R>"<cr>
imap kk <C-R>"
imap kj <Esc>
imap <C-l> -<Esc>vy39po
nmap <Leader>d :pwd<cr>
nmap <Leader>t :NERDTreeToggle<cr>
nmap <Leader>J :JavaSearch -p 
""nmap <Leader>x :WintabsClose<cr>:WintabsNext<cr>
""map <Leader> <Plug>(easymotion-prefix)
nmap <Leader>w <C-W><C-w>z60<cr>
nmap <Leader>: q:i
cmap <C-k> <up>
cmap <C-j> <down>
nmap <Leader>x ggVGx
nmap <Leader>r :e<cr>
nmap <Leader>h :WintabsPrevious<cr>
nmap <Leader>k :call wintabs#previous()<cr>
nmap <Leader>j :call wintabs#previous()<cr>
nmap <Leader>l :WintabsNext<cr>
imap jj <del>
nmap <Leader>b ^
vmap <Leader>b ^
nmap <Leader>e $
vmap <Leader>e $
vmap <leader>r :!sqlformat -r -kupper -<cr>
nmap <Leader>G ggVGy<C-o><C-o>
nmap <Leader>n :WintabsGo 
nmap <Leader>N :tabn 
nmap <Leader>: :call InsertJavaClassVariable()<cr>
nmap M m$
nnoremap / /\v\c
cnoremap %s %s/\v
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
nmap <leader>By :SessionSave<cr>:qa<cr>
nmap <Leader>s :w<cr>
nmap <Leader>q :WintabsClose<cr>:silent! edit<cr>
nmap <Leader>Q :q!<cr>:tabp<cr>
""nmap <C-]> <C-w><C-]><C-w>T
nmap <C-\>> <C-w>}
vmap <leader>c <esc>:call feedkeys("\e`<i/*\e`>a*/\e")<cr>
nmap <leader>tw :%s/\v\s+$//ge \| :%s/\t/\=TabSpaces($TABSTOP)/ge \| :w<cr>
imap <Esc>oC <Esc>li
nmap <Leader><F3> :let @/ = "\\<" . expand("<cword>") . "\\>"<cr>
nnoremap <Leader>p :echo b:profile<cr>
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

function! Prepare_run_all()
	tabnew
	call s:prepare_run_all('run-all.sql')
endfunction

function! s:prepare_run_all(file)
	let b = bufnr('%')
	execute "e " . a:file
	normal gg
	silent! execute '%s/\v;//g'
	silent! execute '%s/\vprompt(.{-});[ \s\t]*$/wbecho \1/g'
	silent! execute '%s/\vprompt(.*)$/wbecho \1;/g'
	normal gg

	let pattern = '\v^\@([^;]+)(;)?[ \s\t]*$'
	let r = search(pattern)
	while r != 0
		normal x
		normal y$
		let _file  = @"
		normal ddk
		let e = 'WbInclude -file=' . _file . ' -continueOnError=true -searchFor="(prompt|show errors).*" =useRegex=true -replaceWith="" -ignoreCase=true -printStatements=true -displayResult=true;'
		put =e
		write
		let cmd = "edit " . _file
		execute cmd
		call Prepare_run_all_file()
		write
		execute "buffer " . b
		let r = search(pattern)
	endwhile
endfunction

function! s:prepare_run(pattern, n)
	silent! execute '%s/\v^[ \s\t]*prompt.*$//g'
	let pattern1 = a:pattern
	let pattern2 = '\v^[ \s\t]*\/[ \s\t]*$'
	let @/ = ''
	let n = a:n
	let r = search(pattern1)
	while r != 0
		normal V
		let i = search(pattern2)
		if (i == 0)
			break
		endif
		normal y 
		normal 0V
		let i = search(pattern2)
		normal xk
		let e = 'WbInclude -file="' . bufname('%') . '-' . n . '" -continueOnError=true -searchFor="(prompt|show errors).*" -useRegex=true -replaceWith="" -ignoreCase=true -printStatements=true -displayResult=true -delimiter=/;'
		put =''
		put =e
		put =''
		let lines = split(@", '\n')
		call writefile(lines, bufname('%') . '-' . n)
		let n = n + 1
		let r = search(pattern1)
	endwhile
endfunction

function! Prepare_run_all_file()
	normal gg
	call s:prepare_run('\v\c^[\s\t ]*create[\s\t ]+(or[\s\t ]+replace[\s\t ]+)?(function|library|package|procedure|trigger|type)', 1)
	normal gg
	call s:prepare_run('\v\c^[ \s\t]*begin[ \s\t]*$', 1000)
endfunction

function! InsertJavaClassVariable()
	let name = input("Name: ")
	let desc = input("Description: ")
	let type = input("Type: ")

	let c = toupper(name[0])
	let cname = c . name[1:]

	put= '/**'
	put= ' * ' . desc
	put= ' */'
	put= 'private ' . type . ' ' . name . ';'
	put= ''
	put= '/**'
	put= ' * Created by popesad'
	put= ' *'
	put= ' * <p>Gets the ' . name . ' variable</p>'
	put= ' *'
	put= ' * @return	' . type
	put= ' */'
	put= 'public ' . type . ' get' . cname . '(){'
	put= '	return this.' . name . ';'
	put= '}'
	put= ''
	put= '/**'
	put= ' * Created by popesad'
	put= ' *'
	put= ' * <p>Sets the ' . name . ' variable</p>'
	put= ' *'
	put= ' * @param	newValue ' . type . ' The new value'
	put= ' *'
	put= ' * @return	void'
	put= ' */'
	put= 'public void set' . cname . '(' . type . ' newValue){'
	put= '	this.' . name . ' = newValue;'
	put= '}'
	normal 27k=27j27ji
endfunction

" ================================================================================
" Colors
""set guifont=Liberation_Mono
if ($VIM_COLORS != "")
  colorscheme $VIM_COLORS
else
  colorscheme atom-dark-256
  ""colorscheme monokai
endif

so ~/.vim/colors.vim

call sw#dbexplorer#add_tab('*', 'DB Links', 'L', 'select db_link, username, created  from user_db_links;', [{'title': 'Show the host', 'shortcut': 'H', 'command': "select host from user_db_links where db_link = '%object%'"}])
call sw#dbexplorer#add_tab('*', 'Row Counts', 'W', 'WbRowCount;', [])
call sw#dbexplorer#add_tab('*', 'User Jobs', 'J', 'select job_name, job_creator, start_date, repeat_interval from user_scheduler_jobs', [{'title': 'Job source', 'shortcut': 'S', 'command': "select job_action from user_scheduler_jobs where job_name = '%object%'", 'hide_header': 1, 'filetype': 'sql'}])
call sw#dbexplorer#add_tab('*', 'Packages', 'K', "select OBJECT_NAME, OBJECT_TYPE, STATUS from user_objects where object_type in ('PACKAGE');", [{'title': 'SQL Source', 'shortcut': 'S', 'command': "select text from user_source where name = '%object%' and type='PACKAGE' order by line", 'hide_header': 1, 'filetype': 'sql'}])
call sw#dbexplorer#add_tab('*', 'Packages Bodies', 'B', "select OBJECT_NAME, OBJECT_TYPE, STATUS from user_objects where object_type in ('PACKAGE BODY');", [{'title': 'SQL Source', 'shortcut': 'S', 'command': "select text from user_source where name = '%object%' and type = 'PACKAGE BODY' order by line", 'hide_header': 1, 'filetype': 'sql'}])
