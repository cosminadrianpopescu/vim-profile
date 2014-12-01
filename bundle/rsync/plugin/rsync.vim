augroup cp
augroup rsync
augroup rsync_files

let g:sync_source = []
let g:sync_dest = []

let g:cp_sync_source = []
let g:cp_sync_dest = []

let g:rsync_params = ''

function! StartRsyncDir(source, dest)
    call add(g:sync_source, a:source)
    call add(g:sync_dest, a:dest)
    autocmd! rsync
    autocmd rsync BufWritePost * call DoRsyncDir()
endfunction

function! StartCpDir(source, dest)
    call add(g:cp_sync_source, a:source)
    call add(g:cp_sync_dest, a:dest)
    autocmd! cp
    autocmd cp BufWritePost * call DoCpDir()
endfunction

function! DoRsyncDir()
    let j = 0
    for i in g:sync_source
        if (matchstr(@%, '^' . substitute(i, '\/', "\\\/", 'g')) != '')
            let command = '!rsync -avzp ' . g:rsync_params . ' ' . i . ' ' . g:sync_dest[j]
			execute command
        endif
        let j = j + 1
    endfor
endfunction

function! DoCpDir()
    let j = 0
    for i in g:cp_sync_source
        if (matchstr(@%, '^' . substitute(i, '\/', "\\\/", 'g')) != '')
            let command = '!cp -r ' . i . '* ' . g:cp_sync_dest[j]
            execute command
        endif
        let j = j + 1
    endfor
endfunction

function! FtpSync(base_folder, ftp, base_ftp_folder)
  let first = @%[0]
  let folder = substitute(@%, '^\(.*\)\/[^\/]\+$', '\1', 'g')
  if (folder == @%)
    let folder = ""
  endif
	if (first != '~' && first != '/')
    let cmd = '!/opt/lftp/bin/lftp.exe -c "open ' . a:ftp . ' && cd ' . a:base_ftp_folder . '/' . folder . ' && mirror -R -f ' . @% . '"'
    execute cmd
  endif
endfunction

