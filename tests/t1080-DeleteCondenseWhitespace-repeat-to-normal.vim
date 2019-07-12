" Test repeat of deleting text and condensing following whitespace to normal mode.
set rtp?
edit input.txt
call vimtest#StartTap()
call vimtap#Plan(4)

let @" = ''
execute '4normal wvf),d '
call Assert('"', 4, 'foo(here)', 'my	 plain-separated', 'delete selection')

let @" = ''
5normal w.
call Assert('"', 5, 'foo(here)', 'my       space-separated', 'repeat with tab and plain-separated')

call vimtest#Quit()
