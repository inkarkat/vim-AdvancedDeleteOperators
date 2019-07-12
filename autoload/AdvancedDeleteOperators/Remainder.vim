" AdvancedDeleteOperators/Remainder.vim: Operators that remove the remainder.
"
" DEPENDENCIES:
"
" Copyright: (C) 2015-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! AdvancedDeleteOperators#Remainder#DeleteCurrentAndFollowingEmptyLines()
    let l:currentLnum = line('.')
    let l:cnt = 1
    while l:currentLnum + l:cnt < line('$') && getline(l:currentLnum + l:cnt) =~# '^\s*$'
	let l:cnt += 1
    endwhile

    return '"_' . l:cnt . 'dd'
endfunction
function! AdvancedDeleteOperators#Remainder#DeleteCurrentAndFollowingEmptyLinesOperatorExpression()
    set opfunc=AdvancedDeleteOperators#Remainder#DeleteCurrentAndFollowingEmptyLinesOperator
    let l:keys = 'g@'

    if ! &l:modifiable || &l:readonly
	" Probe for "Cannot make changes" error and readonly warning via a no-op
	" dummy modification.
	" In the case of a nomodifiable buffer, Vim will abort the normal mode
	" command chain, discard the g@, and thus not invoke the operatorfunc.
	let l:keys = ":call setline('.', getline('.'))\<CR>" . l:keys
    endif

    return l:keys
endfunction
function! AdvancedDeleteOperators#Remainder#DeleteCurrentAndFollowingEmptyLinesOperator( type )
    try
	" Note: Need to use an "inclusive" selection to make `] include the last
	" moved-over character.
	let l:save_selection = &selection
	set selection=inclusive

	execute 'silent normal! g`[' . (a:type ==# 'line' ? 'V' : 'v') . 'g`]"' . v:register . 'y'

	execute 'normal!' AdvancedDeleteOperators#Remainder#DeleteCurrentAndFollowingEmptyLines()
    finally
	let &selection = l:save_selection
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
