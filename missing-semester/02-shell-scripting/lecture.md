# shell scripting
- variables
  - `foo=bar`, `echo $foo`
  - `foo=(date)`
- strings
  - `echo "Value is $foo"` => bar
  - `echo 'Value is $foo'` => $foo
- functions
  - see `mcd.sh`
  - `$1`-`$9` are the arguments
  - `$#` number of arguments
  - `$@` all arguments
- other neat stuff
  - `$?` error code of previous command
    - 0 means good, 1 means false, 127 is a terminal error, etc
  - `$$` process id
  - `$_` last arg of previous command
    - `mkdir test`, `cd $_`
  - `!!` previous command
  - `false || echo "Oops fail"`
  - `true && echo "Success"`
  - `false ; echo "This prints either way"`
  - `cat <(ls) <(ls ..)` ... prints current dir and parent dir files
  - `ls *.sh` gets a list of all the .sh files
  - `ls project?` matches `project2` but not `project22`
  - `touch project{1,2}/foo{,1,2,10}.py`
    - tab to expand
    - ranges: `touch test{1..10}.py`
- comparisons
  - there's so much stuff
  - check `man test`
  - see if files exist, different comparisons for strings vs numbers, etc
  - diff directories `touch {foo,bar}/{a..c}.py foo/x.py bar/y.py`, `diff <(ls foo) <(ls bar)`
- you can also write scripts in python and other languages, see `script.py`
  - i cant get the PATH mapping working on mac idk
- `shellcheck`... detect common issues
- there is a difference between stuff you run and stuff you add to your shell
  - eg relative paths, side effects, variables
- `man` also works for installed stuff like `man shellcheck`
  - also ripgrep etc
- `tldr` has short manpages for common commands
  - `tldr convert`, `tldr ffmpeg`, tar, etc
- `find`
  - find all directories called `src` in the current dir: `find . -name src -type d`
  - find all python files in test folders `find . -path '**/test/*.py' -type f`
  - find all files that have been modified in the past day `find . -mtime -1`
  - delete all `.tmp` files `find . -name "*.tmp" -delete`
- `fd`: shorter find that uses regexes, has color, etc
- `locate` ... much faster, but need to generate the db
- `grep`
    - `grep foobar mcd.sh` ... finds instances in that file
  - `grep -R foobar .` ... searches a directory recursively
- `rg` (ripgrep)
  - `rg "import" -t ts ~` ... find all ts/tsx files with an import statement in my user folder lol
  - `rg -u --files-without-match "^#\!" -t sh` ... find all shell files that don't start with a shebang
- `ack`, `ag`, etc... many "better grep" type tools
- `history` ... see all the commands you typed
- `history 1 | grep "rg"`
- backward search: Ctrl+R, `rg`, Ctrl+R, Ctrl+R
- `fzf`: fuzzy finder, interactive grep
  - `cat example.sh | fzf`
- `-R` works in almost everything relating to directories, eg `ls -R`
- `tree`
- `broot` similar but you can type and navigate
- `nnn` kinda like finder column view
- `xargs` lets you execute a command with STDIN as the argument
  - `ls | xargs rm` will delete files in current dir