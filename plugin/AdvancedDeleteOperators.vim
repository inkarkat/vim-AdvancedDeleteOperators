" AdvancedDeleteOperators.vim: More operators to delete and change text.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedDeleteOperators') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedDeleteOperators = 1
let s:save_cpo = &cpo
set cpo&vim

" This mapping repeats naturally, because it just sets global things, and Vim is
" able to repeat the g@ on its own.
nnoremap <expr> <Plug>(DeleteCondenseWhitespaceOperator) AdvancedDeleteOperators#Whitespace#OperatorExpression('d', 1)
nnoremap <expr> <Plug>(ChangeCondenseWhitespaceOperator) AdvancedDeleteOperators#Whitespace#OperatorExpression('c', 1)

" Repeat not defined in visual mode, but enabled through visualrepeat.vim.
vnoremap <silent> <Plug>(DeleteCondenseWhitespaceVisual)
\ :<C-u>call setline('.', getline('.'))<Bar>
\call AdvancedDeleteOperators#Whitespace#DeleteCondenseOperator('visual', 1)<CR>
vnoremap <silent> <Plug>(ChangeCondenseWhitespaceVisual)
\ :<C-u>call setline('.', getline('.'))<Bar>
\call AdvancedDeleteOperators#Whitespace#ChangeCondenseOperator('visual', 1)<CR>

" A normal-mode repeat of the visual mapping is triggered by repeat.vim. It
" establishes a new selection at the cursor position, of the same mode and size
" as the last selection.
"   If [count] is given, that number of lines is used / the original size is
"   multiplied accordingly. This has the side effect that a repeat with [count]
"   will persist the expanded size, which is different from what the normal-mode
"   repeat does (it keeps the scope of the original command).
nnoremap <silent> <Plug>(DeleteCondenseWhitespaceVisual)
\ :<C-u>call setline('.', getline('.'))<Bar>
\execute 'normal!' AdvancedDeleteOperators#VisualMode()<Bar>
\call AdvancedDeleteOperators#Whitespace#DeleteCondenseOperator('visual', 1)<CR>
nnoremap <silent> <Plug>(ChangeCondenseWhitespaceVisual)
\ :<C-u>call setline('.', getline('.'))<Bar>
\execute 'normal!' AdvancedDeleteOperators#VisualMode()<Bar>
\call AdvancedDeleteOperators#Whitespace#ChangeCondenseOperator('visual', 1)<CR>


if ! hasmapto('<Plug>(DeleteCondenseWhitespaceOperator)', 'n')
    nmap d<Space> <Plug>(DeleteCondenseWhitespaceOperator)
endif
if ! hasmapto('<Plug>(DeleteCondenseWhitespaceVisual)', 'x')
    xmap ,d<Space> <Plug>(DeleteCondenseWhitespaceVisual)
endif
if ! hasmapto('<Plug>(ChangeCondenseWhitespaceOperator)', 'n')
    nmap c<Space> <Plug>(ChangeCondenseWhitespaceOperator)
endif
if ! hasmapto('<Plug>(ChangeCondenseWhitespaceVisual)', 'x')
    xmap ,c<Space> <Plug>(ChangeCondenseWhitespaceVisual)
endif



let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
