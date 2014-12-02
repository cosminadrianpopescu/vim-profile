if exists('g:loaded_sync') || v:version < 700
  finish
endif
let g:loaded_sync = 1

let g:Sync_default_command = 'rsync'
let g:Sync_default_args = '-azvp'
let g:Sync = []

" commands
command! -nargs=+ -complete=dir SyncStart call sync#add(<f-args>, 'rsync', '-azvp')
command! -nargs=1 -complete=dir SyncStop call sync#remove(<f-args>)

augroup sync_execute
augroup sync_sessions
autocmd sync_execute BufWritePost * call sync#execute()
autocmd sync_sessions SessionLoadPost * call sync#restore_session()
