" Test deleting text and condensing following whitespace over an inclusive selection that only covers whitespace.

edit input.txt
set selection=exclusive
call vimtest#StartTap()
call vimtap#Plan(8)

let @" = ''
execute '4normal 2Elvw,d '
call Assert('"', 4, '', 'my	foo(here) plain-separated', 'delete of a single space does not change the buffer')

let @" = ''
execute '5normal 2Elvw,d '
call Assert('"', 5, '', 'my      foo(here) space-separated', 'delete of a spaces')

let @" = ''
execute '6normal 2Elvw,d '
call Assert('"', 6, '', 'my	foo(here) tab-separated', 'delete of a single tab')

let @" = ''
execute '8normal 2Elvw,d '
call Assert('"', 8, '', 'my	foo(here) mixed-separated', 'delete of mixed whitespace')

call vimtest#Quit()
