"============================================================================"
"
"  Vim SQL Workbench/J Implementation
"
"  Copyright (c) Cosmin Popescu
"
"  Author:      Cosmin Popescu <cosminadrianpopescu at gmail dot com>
"  Version:     1.00 (2015-01-08)
"  Requires:    Vim 7
"  License:     GPL
"
"  Description:
"
"  Provides SQL database access to any DBMS supported by SQL Workbench/J. The
"  only dependency is SQL Workbench/J. Also includes powefull intellisense
"  autocomplete based on the current selected database
"
"============================================================================"

let s:current_file = expand('<sfile>:p:h')
let s:active_servers = {}

function! s:get_pipe_name(id)
    return g:sw_tmp . '/sw-pipe-' . a:id
endfunction

function! sw#server#run(profile)
    if !exists('g:loaded_dispatch')
        throw 'You cannot start a server without vim dispatch plugin. Please install it first. If you don''t want or you don''t have the possibility to install it, you can always start the server manually. '
    endif
    let cmd = 'Start! ' . s:current_file . '/../../resources/sqlwbconsole' . ' -t ' . g:sw_tmp . ' -p ' . a:profile . ' -s ' . v:servername . ' -c ' . g:sw_exe . ' -v ' . g:sw_vim_exe

    execute cmd
    redraw!
endfunction

function! sw#server#connect_buffer(profile, file, command)
    if !has_key(s:active_servers, a:profile)
        throw "There is no sql workbench server with the id " . a:profile
    endif
    call sw#sqlwindow#open_buffer('!#' . a:profile, a:file, a:command)
endfunction

function! sw#server#ping(id)
    call s:pipe_execute('/*!#ping*/', a:id)
endfunction

function! sw#server#new(id)
    let s:active_servers[a:id] = '1'
    echomsg "Added new server: " . a:id
    call sw#interrupt()
    redraw!
    return ''
endfunction

function! sw#server#remove(id)
    call remove(s:active_servers, a:id)
    echomsg "Removed server: " . a:id
    call sw#interrupt()
    redraw!
    return ''
endfunction

function! s:pipe_execute(cmd, id)
    execute "python fd = open('" . s:get_pipe_name(a:id) . "', 'w')"
    exec 'python fd.write("%s\n" % "' . escape(a:cmd, '"') . '")'
    python fd.close()
endfunction

function! sw#server#stop(id)
    call s:pipe_execute("exit", a:id)
endfunction

function! sw#server#execute_sql(sql)
    let id = substitute(b:profile, '\v\c^!#', '', 'g')
    let lines = split(a:sql, "\n")

    let first = 0
    let commands = []
    for line in lines
        if !(line =~ '\v\c^[ \s\t]*$')
            if !first
                let line = '/*' . g:sw_instance_id . '#' . b:unique_id . '*/' . line
                let first = 1
            endif

            call add(commands, line)
        endif
    endfor

    if !(commands[len(commands) - 1] =~ ';[ \s\t]*$')
        let commands[len(commands) - 1] .= ';'
    endif
    for command in commands
        call s:pipe_execute(command, id)
    endfor
endfunction
