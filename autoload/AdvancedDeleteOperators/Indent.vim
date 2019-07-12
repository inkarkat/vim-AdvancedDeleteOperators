" AdvancedDeleteOperators/Indent.vim: Operators that delete and remove indent.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2016-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! AdvancedDeleteOperators#Indent#DeleteLinesAndDropCommonIndent( register )
    try
	call ingo#indent#RangeSeveralTimes("'[", "']", '<', ingo#indent#GetIndentLevel(ingo#range#NetStart()))
	execute printf("'[,']delete %s", a:register)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction
function! s:StripLeadingAndTrailingWhitespace( text )
    return substitute(a:text, '\%(^\|\n\)\zs\s\+\|\s\+\ze\(\n\|$\)', '', 'g')
endfunction
function! AdvancedDeleteOperators#Indent#DeleteLinesAndAllIndent( register )
    call setreg(a:register, s:StripLeadingAndTrailingWhitespace(getreg(a:register)), getregtype(a:register)[0]) " Only set the type's letter, not the width in block mode; it may have been truncated by the trimming, so let Vim recalculate it.
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
