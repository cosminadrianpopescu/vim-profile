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

function! sw#server#connect_buffer(profile, file, port, command)
    if !has_key(s:active_servers, a:profile)
        throw "There is no sql workbench server with the id " . a:profile
    endif
    call sw#sqlwindow#open_buffer(a:profile, a:file, a:command)
    call sw#session#set_buffer_variable('port', a:port)
    let b:port = a:port
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
    python << SCRIPT
import vim
buffer_id = vim.eval('b:unique_id')
instance_id = vim.eval('g:sw_instance_id')
cmd = vim.eval('a:cmd') + "\n"
port = int(vim.eval('b:port'))
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('127.0.0.1', port))
s.sendall("!#buffer_id = " + buffer_id + "\n")
s.sendall("!#instance_id = " + instance_id + "\n")
s.sendall(cmd)
s.close()
SCRIPT
endfunction

function! sw#server#stop(id)
    call s:pipe_execute("exit", a:id)
endfunction

function! sw#server#execute_sql(sql)
    let sql = a:sql
    if !(substitute(sql, "^\\v\\c\\n", ' ', 'g') =~ ';[ \s\t\r]*$')
        let sql = sql . ";"
    endif
    call s:pipe_execute(sql, b:profile)
endfunction
