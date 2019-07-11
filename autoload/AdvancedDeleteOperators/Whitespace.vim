" AdvancedDeleteOperators/Whitespace.vim: Operators that work on trailing whitespace.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
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
    let l:repeatMapping = "\<Plug>(" . s:GetName(a:operator, a:keepCnt) . 'Whitespace)'
    silent! call repeat#setreg(l:repeatMapping, v:register)
    let l:save_count = v:count
    let l:save_view = winsaveview()

    if a:type ==# 'visual'
	" Consistently use inclusive change marks.
	call ingo#change#Set(getpos("'<"), ingo#selection#GetInclusiveEndPos())
    endif
echomsg '****' string(getpos("']"))
    let l:endLnum = line("']")
    call setpos('.', [0, l:endLnum, 1, 0])
    if search('\s*\%'']\s\|\%''].\zs\s', 'cW', l:endLnum) == 0
	call winrestview(l:save_view)
	execute "normal! \<C-\>\<C-n>\<Esc>" | " Beep.
	return
    endif
echomsg '****' string(getpos("."))

    " Note: Need to use an "exclusive" selection to exclude the current position
    " (the first following whitespace).
    let l:save_selection = &selection
    set selection=exclusive
    try
	execute 'normal! vg`["' . v:register . 'd'
    finally
	let &selection = l:save_selection
    endtry

    " Condense / delete the trailing whitespace
    execute 'normal!' (a:keepCnt == 0 ? '"_diw' : "\"_ciw \<Esc>")

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

function! AdvancedDeleteOperators#Whitespace#OperatorExpression( operator, keepCnt ) abort
    let &opfunc = 'AdvancedDeleteOperators#Whitespace#' . s:GetName(a:operator, a:keepCnt) . 'Operator'

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

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
