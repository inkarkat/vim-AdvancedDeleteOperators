" AdvancedDeleteOperators/Around.vim: Operators that also delete around the current line.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! AdvancedDeleteOperators#Around#DeleteAndGoAbove( count )
    let l:isAtEndOfBuffer = (line('.') == line('$'))

    if line('.') == 1 || line('.') < a:count
	execute "normal! \<C-\>\<C-n>\<Esc>" | " Beep.
    else
	try
	    execute (a:count > 1 ? '.-' . (a:count - 1) . ',.' : '.') . 'delete' v:register
	catch /^Vim\%((\a\+)\)\=:/
	    call ingo#err#SetVimException()
	    return 0
	endtry
    endif

    if ! l:isAtEndOfBuffer
	normal! k
    endif

    silent! call repeat#set("\<Plug>(DeleteAndGoAbove)", a:count)
    return 1
endfunction

function! AdvancedDeleteOperators#Around#DeleteLinesAndEmptyAround()
    let l:isDeletionAtEndOfBuffer = (line("'[") > line('.')) " When deleting at the end of the buffer, the cursor moves up after the deletion.
    let l:save_cursor = ingo#compat#getcurpos()
    let l:save_lazyredraw = &lazyredraw
    let l:save_foldenable = &l:foldenable
    let l:didDelete = 0
    setlocal nofoldenable
    try
	if ! l:isDeletionAtEndOfBuffer && line('.') > 1
	    call cursor(line('.') - 1, 0)
	endif
	while getline('.') =~# '^\s*$'
	    silent delete _
	    let l:didDelete = 1
	endwhile
    finally
	let &l:foldenable = l:save_foldenable
	let &lazyredraw = l:save_lazyredraw
	if ! l:didDelete
	    call setpos('.', l:save_cursor)
	endif
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
