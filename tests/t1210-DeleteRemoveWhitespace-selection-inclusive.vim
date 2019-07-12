" Test deleting text and removing following whitespace in the inclusive selection.

edit input.txt
set selection=inclusive
call vimtest#StartTap()
call vimtap#Plan(16)

let @" = ''
execute "2normal 2wvf),d\<BS>"
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is for a reason.', 'delete with f motion')

let @" = ''
execute "3normal wvf),d\<BS>"
call Assert('"', 3, '', 'my	foo(here)not-separated', 'no delete because no whitespace')

let @a = ''
execute "4normal wvf)\"a,d\<BS>"
call Assert('a', 4, 'foo(here)', 'my	plain-separated', 'delete with tab and plain-separated into register')

let @" = ''
execute "5normal wvf),d\<BS>"
call Assert('"', 5, 'foo(here)', 'my      space-separated', 'delete with space and space-separated')

let @" = ''
execute "6normal wvE,d\<BS>"
call Assert('"', 6, 'foo(here)', 'my	tab-separated', 'delete with tab and tab-separated')

let @" = ''
execute "7normal wvW,d\<BS>"
call Assert('"', 7, '', 'my	foo(here)	    softtabstop-separated', 'no delete because inclusive also adds the next letter')

let @" = ''
execute "8normal wv$,d\<BS>"
call Assert('"', 8, '', 'my	foo(here)    		    mixed-separated', 'no delete because no trailing whitespace')

let @" = ''
execute "9normal wv$,d\<BS>"
call Assert('"', 9, 'foo(here)	trailing white', 'my      ', 'delete to trailing whitespace does not insert a trailing space')

call vimtest#Quit()
