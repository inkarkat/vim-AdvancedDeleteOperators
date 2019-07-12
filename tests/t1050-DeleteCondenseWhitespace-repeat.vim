" Test repeat of deleting text and condensing following whitespace over a motion.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(7)

let @" = ''
2normal 2wd f)
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is  for a reason.', 'delete with f motion')

let @" = ''
let @a = ''
4normal w"a.
call Assert('"', 4, 'foo(here)', 'my	 plain-separated', 'repeat with tab and plain-separated')
call vimtap#Is(@a, '', 'passed register is ignored, as this is handled by Vim, not repeat.vim')

let @b = ''
11normal w2.
call Assert('"', 11, 'foo(here) bar(there)', 'our	 plain-separated', 'repeat with count')

call vimtest#Quit()
