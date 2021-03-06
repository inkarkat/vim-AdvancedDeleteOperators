" AdvancedDeleteOperators/Whitespace.vim: Operators that work on trailing whitespace.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019-2020 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
let s:save_cpo = &cpo
set cpo&vim

function! s:GetName( operator, keepCnt ) abort
    return {'c': 'Change', 'd': 'Delete'}[a:operator] .
    \   (a:keepCnt == 0 ? 'Remove' : 'Condense')
endfunction
function! s:Operator( operator, keepCnt, type, ... ) abort
    let l:repeatMapping = "\<Plug>(" . s:GetName(a:operator, a:keepCnt) . 'WhitespaceVisual)'
    silent! call repeat#setreg(l:repeatMapping, v:register)
    let l:save_count = v:count
    let l:save_view = winsaveview()

    if a:type ==# 'visual'
	" Consistently use inclusive change marks.
	call ingo#change#Set(getpos("'<"), ingo#selection#GetInclusiveEndPos())
    endif

    let l:trailingWhitespacePattern = '\s*\%'']\s\+\|\s\+\%'']$\|\%''].\zs\s\+'
    let l:startPos = getpos("'[")[1:2]
    let l:endLnum = line("']")
    let l:endLineLen = len(getline(l:endLnum))

    " Locate the area of trailing whitespace; as the motion / selection may
    " include or exclude it, search from the start of the line, using the ']
    " mark as an anchor.
    call setpos('.', [0, l:endLnum, 1, 0])
    let l:whitespaceEndPos = searchpos(l:trailingWhitespacePattern, 'cenW', l:endLnum)
    if l:whitespaceEndPos == [0, 0]
	call winrestview(l:save_view)
	execute "normal! \<C-\>\<C-n>\<Esc>" | " Beep.
	return
    endif
    let l:isWhitespaceAtEndOfLine = (search('\%(' . l:trailingWhitespacePattern . '\)$', 'cnW') != 0)
    let l:whitespaceStartPos = searchpos(l:trailingWhitespacePattern, 'cW', l:endLnum)
    let l:whitespace = ingo#text#Get(l:whitespaceStartPos, l:whitespaceEndPos)

    " If we'd remove the trailing whitespace first, we'd run into problems at
    " the end of the line, as we can't position the cursor behind the motion /
    " selection without :set virtualedit=onemore. Instead, delete the text first
    " and then adapt the whitespace area for the removed text. We do a delta of
    " the line's length for the calculation; this way, we don't need to capture
    " the deleted text nor do we need to account for multi-line text.
    "
    if l:startPos != l:whitespaceStartPos
	" Note: Need to use an "exclusive" selection to exclude the current position
	" (the first following whitespace).
	let l:save_selection = &selection
	set selection=exclusive
	try
	    execute 'normal! vg`["' . v:register . 'd'
	finally
	    let &selection = l:save_selection
	endtry
    endif
    let l:endLineDeleteOffset = l:endLineLen - len(getline(l:endLnum))

    " Condense / delete the trailing whitespace.
    call ingo#text#Replace(
    \   [l:endLnum, l:whitespaceStartPos[1] - l:endLineDeleteOffset],
    \   len(l:whitespace),
    \   (a:keepCnt == 0 || l:isWhitespaceAtEndOfLine ? '' : ' ')
    \)

    if a:operator ==# 'c'
	call ingo#cursor#StartInsert()
    endif

    if a:0 && a:1
	silent! call repeat#set(l:repeatMapping, l:save_count)
    endif
    silent! call visualrepeat#set(l:repeatMapping, l:save_count)
endfunction
function! AdvancedDeleteOperators#Whitespace#DeleteCondenseOperator( type, ...) abort
    call call('s:Operator', ['d', 1, a:type] + a:000)
endfunction
function! AdvancedDeleteOperators#Whitespace#ChangeCondenseOperator( type, ...) abort
    call call('s:Operator', ['c', 1, a:type] + a:000)
endfunction
function! AdvancedDeleteOperators#Whitespace#DeleteRemoveOperator( type, ...) abort
    call call('s:Operator', ['d', 0, a:type] + a:000)
endfunction
function! AdvancedDeleteOperators#Whitespace#ChangeRemoveOperator( type, ...) abort
    call call('s:Operator', ['c', 0, a:type] + a:000)
endfunction

function! AdvancedDeleteOperators#Whitespace#OperatorExpression( operator, keepCnt ) abort
    return ingo#mapmaker#OpfuncExpression('AdvancedDeleteOperators#Whitespace#' . s:GetName(a:operator, a:keepCnt) . 'Operator')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
