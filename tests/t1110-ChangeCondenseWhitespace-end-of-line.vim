" Test changing text and condensing following whitespace over a motion that reaches the end of the line.

edit input.txt
9call feedkeys("2Wc $NEW\<Esc>:call vimtest#SaveOut()|call vimtest#Quit()\<CR>")
