ADVANCED DELETE OPERATORS
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Editing text mainly means changing or deleting stuff, in the latter case often
to paste it somewhere else. Often, some whitespace is "in the way": For
example, you want to change some text, and there's a convenient motion to the
end of it. But the whitespace after that has to be removed as well. It's then
either visual mode to really select what you need, or a separate removal after
the edit which breaks repeatability with the . command. Or you want to
delete a text column (including trailing whitespace), but then want to reuse
only the text without the spaces.
This plugin provides additional |c|hange and |d|elete operators that work on
moved-over text or a selection (just like the original built-in operators),
but also remove trailing whitespace (or condense it to a single space).

### SOURCE
(Original Vim tip, Stack Overflow answer, ...)

### SEE ALSO
(Plugins offering complementary functionality, or plugins using this library.)

### RELATED WORKS
(Alternatives from other authors, other approaches, references not used here.)

USAGE
------------------------------------------------------------------------------

    ["x]c<Space>{motion}    Delete text that {motion} moves over [into
                            register x], reduce any whitespace after it to a
                            single space, and start insert.
    {Visual}["x]c<Space>}   Delete selected text [into register x], reduce any
                            whitespace after it to a single space, and start
                            insert.
    ["x]d<Space>{motion}    Delete text that {motion} moves over [into register x]
                            and reduce any whitespace after it to a single space.
    {Visual}["x]d<Space>    Delete selected text [into register x] and reduce any
                            whitespace after it to a single space.

    ["x]c<BS>{motion}       Delete text that {motion} moves over [into
                            register x], remove any whitespace after it, and start
                            insert.
    {Visual}["x]c<BS>       Delete selected text [into register x], remove any
                            whitespace after it, and start insert.
    ["x]d<BS>{motion}       Delete text that {motion} moves over [into register x]
                            and remove any whitespace after it.
    {Visual}["x]d<BS>       Delete selected text [into register x] and remove any
                            whitespace after it.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-AdvancedDeleteOperators
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim AdvancedDeleteOperators*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.039 or
  higher.

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:
configvar

If you want to use different mappings, map your keys to the following mapping
targets _before_ sourcing the script (e.g. in your vimrc):

    nmap d<Space> <Plug>(DeleteCondenseWhitespaceOperator)
    xmap ,d<Space> <Plug>(DeleteCondenseWhitespaceVisual)
    nmap c<Space> <Plug>(ChangeCondenseWhitespaceOperator)
    xmap ,c<Space> <Plug>(ChangeCondenseWhitespaceVisual)
    nmap d<BS> <Plug>(DeleteRemoveWhitespaceOperator)
    xmap ,d<BS> <Plug>(DeleteRemoveWhitespaceVisual)
    nmap c<BS> <Plug>(ChangeRemoveWhitespaceOperator)
    xmap ,c<BS> <Plug>(ChangeRemoveWhitespaceVisual)

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-AdvancedDeleteOperators/issues or email
(address below).

HISTORY
------------------------------------------------------------------------------

##### GOAL
First published version.

##### 0.01    11-Jul-2019
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2019 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
