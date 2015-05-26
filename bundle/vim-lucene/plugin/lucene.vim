if !exists('g:Lucene_port')
    let g:Lucene_port = 5000
endif

let g:lucene_cygwin = 0
if has("win32unix")
    let g:lucene_cygwin = 1
endif

command! -nargs=1 LuceneSearch call lucene#search(<f-args>, 'wild')
command! -nargs=1 LuceneSearchFromHere call lucene#search(<f-args>, 'wild', fnamemodify(bufname('%'), ':p:h'))
command! -nargs=1 -complete=dir LuceneSearchFromFolder call lucene#search(input("Please input the search string: "), 'wild', <f-args>)

command! -nargs=1 LuceneSearchRegex call lucene#search(<f-args>, 'regex')
command! -nargs=1 LuceneSearchFromHereRegex call lucene#search(<f-args>, 'regex', fnamemodify(bufname('%'), ':p:h'))
command! -nargs=1 -complete=dir LuceneSearchFromFolderRegex call lucene#search(input("Please input the search string: "), 'regex', <f-args>)
