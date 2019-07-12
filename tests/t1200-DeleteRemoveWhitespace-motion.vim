" Test deleting text and removing following whitespace over a motion.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(16)

let @" = ''
execute "2normal 2wd\<BS>f)"
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is for a reason.', 'delete with f motion')

let @" = ''
execute "3normal wd\<BS>f)"
call Assert('"', 3, '', 'my	foo(here)not-separated', 'no delete because no whitespace')

let @a = ''
execute "4normal w\"ad\<BS>f)"
call Assert('a', 4, 'foo(here)', 'my	plain-separated', 'delete with tab and plain-separated into register')

let @" = ''
execute "5normal wd\<BS>f)"
call Assert('"', 5, 'foo(here)', 'my      space-separated', 'delete with space and space-separated')

let @" = ''
execute "6normal wd\<BS>E"
call Assert('"', 6, 'foo(here)', 'my	tab-separated', 'delete with tab and tab-separated')

let @" = ''
execute "7normal wd\<BS>W"
call Assert('"', 7, 'foo(here)', 'my	softtabstop-separated', 'delete with tab and softtabstop-separated')

let @" = ''
execute "8normal wd\<BS>$"
call Assert('"', 8, '', 'my	foo(here)    		    mixed-separated', 'no delete because no trailing whitespace')

let @" = ''
execute "9normal wd\<BS>$"
call Assert('"', 9, 'foo(here)	trailing white', 'my      ', 'delete to trailing whitespace does not insert a trailing space')

call vimtest#Quit()
