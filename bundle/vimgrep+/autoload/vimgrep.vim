function! vimgrep#search(pattern, ...)
	let path = g:Vimgrep_root

	if a:0
		let path = a:1
	endif

	let @/ = '\c\v' . substitute(a:pattern, '\v\c\/', '\\\/', 'g')
	let cmd = 'grep! --exclude-dir=.idea --exclude-dir=target --exclude-dir=metadata --exclude=*.class -nriI "' . a:pattern . '" ' . path
	echomsg cmd
	silent! execute cmd
	copen
	redraw!
endfunction
