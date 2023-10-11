# Vim
## modes
- normal esc
- insert i
- replace r
- visual v
- visual line shift-v
- visual block ctrl-v
- command-line :
## buffers vs windows vs tabs
- `:sp` creates a new window with the same file
  - they are the same buffer, so changes are applied to both
- a buffer can be open in 0 or more windows at the same time
- `:q` actually only quites the current window
- `:qa` quits all open windows
## Movement commands
- `L`, `M`, `H` - lowest, middle, highest visible line
- jump to stuff
    - `fc` - first c after the cursor
    - `Fc` - first c before the cursor
    - `tc` - right before the first c after the cursor
    - `Tc` - right after the first c before the cursor
## Editing commands
- `u` - undo
- `de` - delete until end of the word
- `ce` - same as `de` but leaves you in insert mode
- `cc` - make the current line empty and leave you in insert mode
- `ra` - replace the current character with an a
## Copying and pasting
- they take vim motions
- `yw` -> put current word + whitespace into buffer
## Visual mode
- `v` then any navigation motion
- `shift+v` visual line mode
- `^v` visual block mode
## Other stuff
- `~` changes case
- `c` change operator
  - `ce` change until end of word, etc
  - `cc` like `dd -> O`
- `^g` line number etc
- `%s/old/new/g` replace in whole file
- `%s/old/new/gc` replace in whole file with prompts
- `:!ls` execute external shell command
## Modifiers
- `a` around
- `i` inside
- `ci[` change inside square brackets
- also works for `{('"` etc
- `%` jump back and forth between matching parens
## Search
- `/foo<enter>` go to first instance of foo
- `n` next match
## Copy
- `<move>.`
- repeats the previous editing command
## Stuff to look up
- How to delete everything inside the currently selected paren?
- How to switch between windows?
- Do vimtutor
- Do a bit of vim golf?
- Do some stuff in `:help`?

afasDfa
sadfssdf
safadfas dfasfa fdddasdfas dfsadasdf
asdfasd fsadf asqffdddoos adasdfa asdf
asdsd sadasd asadaddddddddddddsdfoo aoasdf
foo [sdfsdfa asfdas asfds](bcd.com)asdf