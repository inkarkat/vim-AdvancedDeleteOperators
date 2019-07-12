" Test changing text and condensing following whitespace over a motion.

edit input.txt
2call feedkeys("2wc f)NEW\<Esc>:call vimtest#SaveOut()|call vimtest#Quit()\<CR>")
