" Test repeat of deleting text and condensing following whitespace to selection.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(4)

let @" = ''
2normal 2wd f)
call Assert('"', 2, 'foo(bar, baz, hehe, hihi, hoho)', 'Function is for a reason.', 'delete with f motion')

let @" = ''
5normal wvf).
call Assert('"', 5, 'foo(here)', 'my space-separated', 'repeat with register')

call vimtest#Quit()
