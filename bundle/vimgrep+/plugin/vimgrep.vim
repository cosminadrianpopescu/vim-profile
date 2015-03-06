if !exists('g:Vimgrep_folder')
	let g:Vimgrep_root = '.'
endif

command! -nargs=1 VimgrepSearch call vimgrep#search(<f-args>, getcwd())
command! -nargs=1 VimgrepSearchFromHere call vimgrep#search(<f-args>, fnamemodify(bufname('%'), ':p:h'))
command! -nargs=1 VimgrepSearchRoot call vimgrep#search(<f-args>)
command! -nargs=1 -complete=dir VimgrepSetRoot let g:Vimgrep_root = <f-args>
