# Command Line
## Job Control
- until now we have executed a command and gotten some output. but maybe we want to run several things, stop execution, etc
- ^c sends SIGINT (SIGnal INTerrupt)
  - `man signal`
  - ex.: `SIGSTOP` -> `SIGCONT` stop and resume
  - `sigint.py` an example of how to override signals
    - quit it with SIGQUIT (^\)
  - also if you want to save intermediate state
- ^z SIGSTOP (we can resume)
- `sleep 2000 &` ... runs it in the background, doesn't take over prompt
- `sleep 1000`, `^z`, `sleep 2000 &`, `jobs` => sleep 1000 is suspended, sleep 2000 is running
- `bg %1` restarts the first one
  - `fg %1` would recover it to the foreground, attach to stdout
- `kill` doesn't just kill jobs, lets you send any kind of unix signal
  - `kill -STOP %1`
- !!! `nohup sleep 1000` ... don't quit on hangup, ie ssh session
## Terminal Multiplexers
- `screen` is the old classic, `tmux` is what we should use nowadays
- three core concepts
  - sessions
  - sessions have windows
    - kind of like "tabs" in other applications
  - windows have panes
- `tmux -u` to get p10k to show correctly (utf-8)
- many people remap `^b` to `^a` for tmux because its more ergonomic
- sessions
  - `^b-d` ... detach from session, relaunch tmux with `tmux attach` to get it back
  - `tmux new -t foobar` makes a new session with that name
  - `tmux ls` list sessions
  - `tmux a -t foobar` re-attach to that session
- windows
  - `^b-c` create new window
  - `^b-p`, `^b-n` for previous/next windows
  - windows are listed in bottom bar, use `^b-<number>` to jump to that window
  - `^b-,` rename window
- panes
  - split: vert `^b-"`, horiz `^b-%`
  - kill current pane: `^b-x`
  - cycle: `^b-o`
  - arrow keys to navigate panes
  - `^b-[` start scrollback, space starts selection, enter copies selection
  - `^b-space` cycle through pane arrangements
  - `^b-z` to make the current pane fullscreen, `^b-z` again to return to all panes view
## Dotfiles
- make your shell and applications your own, more convenient, etc
- aliases
  - `alias ll="ls -lah"`
  - `alias gs="git status"`
  - alias a command to itself but with a default flag `alias mv="mv -i"`
  - `alias ll` tells you what `ll` will do
  - if you close the terminal, all the aliases will go away
  - so we want some way of bootstrapping our environment
- dotfiles start with a dot and are config files
- `vim ~/.zshrc` => place aliases in there (~/.bashrc on linux)
- try other peoples dotfiles! search for `dotfiles` on github, sort by stars or whatever, helps you see what there is
- can use symlinks to keep dotfiles in a git repo, but not have that repo be your entire home folder... `dotfiles` folder, symlink `~/.zshrc` to `~/dotfiles/.zshrc`
  - `ln -s path/to/file symlink`
  - there's tools that allow you to do this
- make dotfles portable between environments by checking for where you are:
  - if [[ "$(uname)" == "Linux" ]]; then {do_something}; fi
  - if [[ "$SHELL" == "zsh" ]]; then {do_something}; fi
  - if [[ "$(hostname)" == "myServer" ]]; then {do_something}; fi
- some dotfiles support imports, for example gitconfig:
```
[include]
    path = ~/.gitconfig_local
```
  - so you can have a `~/.gitconfig_local` on each machine
- or you can `if [ -f ~/.aliases ]; then | source ~/.aliases | fi` to import the same aliases in `zshrc` and `bashrc`
- 🚨 port forwarding
  - local vs remote 
    - local (more common): `ssh -L 123:host1:456 host2` connects your 123 to host1's 456 through host2
      - `ssh -L 9999:localhost:8888 foobar@remote_service` lets us use remote_service's 8888 on our 9999
    - remote: `ssh -R 123:host1:456 host2` connects host2's 123 to host1's 456 through you
    - https://unix.stackexchange.com/questions/115897/whats-ssh-port-forwarding-and-whats-the-difference-between-ssh-local-and-remot
- `history 1 | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10` ... top10 most used commands - consider writing aliases for these - on bash remove the `1`
- 🚨 manage dotfiles with chezmoi: https://www.chezmoi.io/quick-start/#start-using-chezmoi-on-your-current-machine
# You can also make it machine-specific
if [[ "$(hostname)" == "myServer" ]]; then {do_something}; fi
## Remote Machines (ssh)
- `ssh` means `secure shell`
- you can pipe a command on a remote machine into your local terminal
- `ssh usr@foo.bar ls -la | grep primes` => sent to your own stdout, not the remote one
- entering pwd is annoying, so use ssh keys ... public key on server, private key on your machine
- `ssh-keygen -o -a 100 -t ed25519`
- then add it to a list of authed keys
  - `cat ~/.ssh/id_ed25519.pub | ssh usr@foo.bar tee .ssh/authorized_keys`
    - `tee` is a unix command that takes stdin and writes to BOTH a file and stdout
- there is also `ssh-copy-id` which is built for this
- copy files to a server:
  - `scp` for individual files ... `scp notes.md usr@foo.bar:notes.md`
  - `rsync` for copying a lot of files ... `rsync -avP . usr@foo.bar:folder` 
    - has flags for preserving permissions, checking if has already been copied, resume interrupted uploads, 
  - `~/.ssh/config` can let you create hosts so you dont have to type `usr@foo.bar` all the time, and forward ports. `scp`, `rsync` etc also know about the ssh config
- good trick for using tmux on both local and server: reassign tmux prefix to `^a` on local, then its still `^b` on server
  - also change your local tmux, eg make the bottom bar a different color, so you get visual feedback on where you are / if you're in a nested session
- if you want to maintain a session over multiple IPs (roaming), you can use mosh https://mosh.org/
  - it also removes network lag when typing
## Other
- alacritty is a more performant terminal