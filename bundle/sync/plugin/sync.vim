
function! sync#filename(f)
    let result = a:f
    if (matchstr(a:f, '\v^(\/|\~)', 'g') == '')
        let result = getcwd() . '/' . a:f
    endif

    return result
endfunction

function! sync#path(p)
    let result = sync#filename(a:p)
    return fnamemodify(result, ':p:h')
endfunction

function! sync#add(source, dest, command, params)
    let source = sync#path(a:source)

    call add(g:Sync, {'source': source, 'dest': a:dest, 'command': a:command, 'params': a:params, 'active': 1})
    call sync#save_session()
endfunction

function! sync#remove(source)
    let source = sync#path(a:source)
    for i in g:Sync
        if i.source == source
            let i.active = 0
        endif
    endfor
endfunction

function! sync#execute()
    let path = fnamemodify(@%, ':p:h')
    let filename = fnamemodify(@%, ':p')
    for i in g:Sync
        if i.active
            if (matchstr(path, '^' . substitute(i.source, '\/', "\\\/", 'g')) != '')
                let dest = substitute(filename, i.source, '', 'g')
                let command = '!' . i.command . ' ' . i.params . ' "' . filename . '" "' . i.dest . dest .'"' 
                execute command
            endif
        endif
    endfor
endfunction

function! sync#restore_session()
	if (exists('g:Str_Sync'))
		execute 'let g:Sync = ' . g:Str_Sync
	endif
endfunction

function! sync#save_session()
	if (exists('g:Sync'))
		let g:Str_Sync = string(g:Sync)
	else
		let g:Str_Sync = ""
	endif
endfunction
