function! s:pipe_execute(cmd)
    execute "silent !echo 'Running " . a:cmd . "'. Please wait..."
    let port = g:Lucene_port

    python << SCRIPT
import vim
import socket
import re
cmd = vim.eval('a:cmd') + "\n"
port = int(vim.eval('port'))
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('127.0.0.1', port))
s.sendall(cmd + ".\n")
result = ''
while 1:
    data = s.recv(4096)
    if not data:
        break
    #end if
    result += data
#end while
s.close()
lines = result.split("\n")
vim.command("let result = ''")
lines = result.split("\n")
for line in lines:
    vim.command("let result = result . '%s\n'" % line.replace("'", "''"))
#end for
SCRIPT
    return substitute(result, '\r', '', 'g')
endfunction

function! lucene#search(pattern, type, ...)
	let path = ''

	if a:0
		let path = a:1
	endif

	let @/ = '\c\V' . a:pattern
    if (a:type == 'regex')
        let @/ = '\c\v' . substitute(a:pattern, '\c\v^\.\*(.*)\.\*$', '\1', 'g')
    endif
    let pattern = a:pattern
    if (a:type == 'wild')
        let pattern = '*' . pattern . '*'
    endif
    if (path == "")
        let cmd = ".query-" . a:type . " " . pattern
    else
        let cmd = ".query-" . a:type . " -folder=" . path . " -query=" . pattern
    endif

    let result = s:pipe_execute(cmd)
    if result == ""
        let result = "No files found"
    endif
    let files = split(result, "\n")
    let grep = ''
    for file in files
        let grep = grep . file . ' '
    endfor
    let grep = 'grep! -niI "' . a:pattern . '" ' . grep
    silent! execute grep
    copen
	redraw!
endfunction

function! lucene#test()
    let result = s:pipe_execute(".index-all")
    echomsg result
    redraw!
endfunction
