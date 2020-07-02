" AdvancedDeleteOperators/OneWhitespace.vim: Operators that replace with one whitespace.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019-2020 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! s:Operator( type, replacement ) abort
    let l:register = (v:register ==# '"' ? '' : '"' . v:register)
    " Note: Need to use an "inclusive" selection to make `] include the
    " last moved-over character.
    let l:save_selection = &selection
    set selection=inclusive
    try
	execute 'silent normal! g`[' . (a:type ==# 'line' ? 'V' : 'v') . 'g`]' . l:register . 'c' . a:replacement . "\<C-\>\<C-n>"
    finally
	let &selection = l:save_selection
    endtry
endfunction
function! AdvancedDeleteOperators#OneWhitespace#SpaceOperator( type ) abort
    call s:Operator(a:type, ' ')
endfunction
function! AdvancedDeleteOperators#OneWhitespace#TabOperator( type ) abort
    call s:Operator(a:type, "\t")
endfunction
function! AdvancedDeleteOperators#OneWhitespace#OperatorExpression( replacement ) abort
    return ingo#mapmaker#OpfuncExpression('AdvancedDeleteOperators#OneWhitespace#' . a:replacement . 'Operator')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
