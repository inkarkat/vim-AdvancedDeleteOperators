" Test repeat of replacing moved-over text with one space.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(4)

4normal Wcr f)
call Assert('"', 4, 'foo(here)', 'my	  plain-separated', 'replace to space with f motion')

11normal 2W.
call Assert('"', 11, 'bar(there)', 'our	foo(here)   plain-separated', 'repeat of replace to space with f motion')

call vimtest#Quit()
