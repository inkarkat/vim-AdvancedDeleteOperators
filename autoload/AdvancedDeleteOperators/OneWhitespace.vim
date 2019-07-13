" AdvancedDeleteOperators/OneWhitespace.vim: Operators that replace with one whitespace.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! AdvancedDeleteOperators#OneWhitespace#SpaceOperator( type ) abort
    let l:register = (v:register ==# '"' ? '' : '"' . v:register)
    " Note: Need to use an "inclusive" selection to make `] include the
    " last moved-over character.
    let l:save_selection = &selection
    set selection=inclusive
    try
	execute 'silent normal! g`[' . (a:type ==# 'line' ? 'V' : 'v') . 'g`]' . l:register . "c \<C-\>\<C-n>"
    finally
	let &selection = l:save_selection
    endtry
endfunction
function! AdvancedDeleteOperators#OneWhitespace#OperatorExpression( replacement ) abort
    let &opfunc = 'AdvancedDeleteOperators#OneWhitespace#' . a:replacement . 'Operator'

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

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
