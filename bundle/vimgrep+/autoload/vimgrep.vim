function! vimgrep#search(pattern)
	let path = g:Vimgrep_root . '/**'

	let cmd = 'vimgrep ' . a:pattern . ' ' . path
	silent! execute cmd
	copen
endfunction
