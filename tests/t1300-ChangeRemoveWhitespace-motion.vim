" Test changing text and removing following whitespace over a motion.

edit input.txt
2call feedkeys("2wc\<BS>f)NEW\<Esc>:call vimtest#SaveOut()|call vimtest#Quit()\<CR>")
