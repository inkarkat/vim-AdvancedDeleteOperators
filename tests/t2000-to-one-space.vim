" Test replacing moved-over text with one space.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(6)

let @" = ''
1normal Wcr i[
call Assert('"', 1, 'default text', '[ ]', 'replace to space with text object')

let @" = ''
let @a = ''
4normal W"acr W
call Assert('a', 4, 'foo(here) ', 'my	 plain-separated', 'replace to space into register')

10normal cr G
call vimtap#Is(line('$'), 10, 'replace until end of buffer')
call vimtap#Is(getline(10), ' ', 'replace multiple lines with space')

call vimtest#Quit()
