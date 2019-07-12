" Test repeat of deleting text and condensing following whitespace in selection.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(8)

let @" = ''
execute '2normal 2wvf),d '
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is  for a reason.', 'delete with f motion')

let @" = ''
4normal wvf).
call Assert('"', 4, 'foo(here)', 'my	 plain-separated', 'repeat with tab and plain-separated')

let @a = ''
5normal wvf)"a.
call Assert('a', 5, 'foo(here)', 'my       space-separated', 'repeat with register')

let @" = ''
11normal wvf)2.
call Assert('"', 11, 'foo(here)', 'our	 bar(there) plain-separated', 'repeat with count is ignored')

call vimtest#Quit()
