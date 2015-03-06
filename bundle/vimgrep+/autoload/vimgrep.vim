function! vimgrep#search(pattern, ...)
	let path = g:Vimgrep_root

	if a:0
		let path = a:1
	endif

	let @/ = '\c\v' . a:pattern
	let cmd = 'grep! -nriI "' . a:pattern . '" ' . path
	echomsg cmd
	silent! execute cmd
	copen
	redraw!
endfunction
