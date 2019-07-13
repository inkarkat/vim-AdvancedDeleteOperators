" Test replacing moved-over text with one tab.

edit input.txt
call vimtest#StartTap()
call vimtap#Plan(6)

let @" = ''
execute "1normal Wcr\ti["
call Assert('"', 1, 'default text', "[\t]", 'replace to tab with text object')

let @" = ''
let @a = ''
execute "4normal W\"acr\tW"
call Assert('a', 4, 'foo(here) ', 'my		plain-separated', 'replace to tab into register')

execute "10normal cr\tG"
call vimtap#Is(line('$'), 10, 'replace until end of buffer')
call vimtap#Is(getline(10), "\t", 'replace multiple lines with tab')

call vimtest#Quit()
