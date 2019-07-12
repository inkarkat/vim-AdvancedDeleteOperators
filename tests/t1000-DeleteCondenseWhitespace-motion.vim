" Test deleting text and condensing following whitespace over a motion.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(16)

let @" = ''
2normal 2wd f)
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is for a reason.', 'delete with f motion')

let @" = ''
3normal wd f)
call Assert('"', 3, '', 'my	foo(here)not-separated', 'no delete because no whitespace')

let @a = ''
4normal w"ad f)
call Assert('a', 4, 'foo(here)', 'my plain-separated', 'delete with tab and plain-separated into register')

let @" = ''
5normal wd f)
call Assert('"', 5, 'foo(here)', 'my space-separated', 'delete with space and space-separated')

let @" = ''
6normal wd E
call Assert('"', 6, 'foo(here)', 'my tab-separated', 'delete with tab and tab-separated')

let @" = ''
7normal wd W
call Assert('"', 7, 'foo(here)', 'my softtabstop-separated', 'delete with tab and softtabstop-separated')

let @" = ''
8normal wd $
call Assert('"', 8, '', 'my	foo(here)    		    mixed-separated', 'no delete because no trailing whitespace')

let @" = ''
9normal wd $
call Assert('"', 9, 'foo(here)	trailing white', 'my ', 'delete to trailing whitespace')

call vimtest#Quit()
