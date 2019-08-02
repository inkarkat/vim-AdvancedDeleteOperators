" Test deleting text and condensing following whitespace over a motion that only covers whitespace.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(8)

let @" = ''
4normal 2Eld w
call Assert('"', 4, '', 'my	foo(here) plain-separated', 'delete of a single space does not change the buffer')

let @" = ''
5normal 2Eld w
call Assert('"', 5, '', 'my      foo(here) space-separated', 'delete of a spaces')

let @" = ''
6normal 2Eld w
call Assert('"', 6, '', 'my	foo(here) tab-separated', 'delete of a single tab')

let @" = ''
8normal 2Eld w
call Assert('"', 8, '', 'my	foo(here) mixed-separated', 'delete of mixed whitespace')

call vimtest#Quit()
