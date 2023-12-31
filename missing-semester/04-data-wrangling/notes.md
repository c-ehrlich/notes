# Data wrangling
- grep is your friend
  - `ssh 'tsp journalctl | grep ssh'`
  - `ssh 'tsp journalctl | grep ssh | grep "Disconnected from"'`
  - by making it one big ssh statement we're not sending the entire log over the network
- and less is useful too
  - `ssh 'tsp journalctl | grep ssh | grep "Disconnected from" | less'`
- if latency is a problem, make a file locally on your computer once, then work on that
  - `ssh tsp 'journalctl | grep ssh | grep "Disconnected from"' > ssh.log`
  - `cat ssh.log | less` pager that lets you scroll with basically vim bindings
- `sed` ... stream editor ... lets you make changes to the content of a stream ... basically a programming language over a stream
  - usually people just run replacement expressions
  - `cat ssh.log | sed 's/.*Disconnected from//'` use a regex to remove the starting bit
    - "sed expression" ... `s` means search ... it's a regex
      - `*` 0 or more
      - `+` 1 or more
      - `[abc]` a, b, or c
      - `/g` match all instances
      - `(ab)*` 0 or more of the string `ab`
  - you generally want to run sed with `-E` to get a modern regex syntax
  - it runs matches one by one, not all at once
  - `echo 'abc' | sed -E 's/(ab|bc)+/foo/g'` => `fooc`
  - `echo 'abc' | sed -E 's/(ab|bc)*/foo/g'` => `foocfoo` (because `/g` matches on 0x)
  - `cat ssh.log | sed -e 's/^.*?Disconnected from (invalid |authenticating )?user (.*) [0-9.]+ port [0-9]+( \[preauth\]?$/\2/' | head -n5`
    - anchor regexes where possible!
    - capture groups are `()`, can refer to them in the replacement! we are replacing the whole thing with the second capture group
    - use a regex debugger like `regex101.com`! 
    - `?` non greedy match
- `wc` to count lines
  - `foo | wc -l`
- `sort` to sort lines
  - can do numeric etc
  - ascending by default
- `uniq` goes through a sorted list of lines and only print unique ones
  - `uniq -c` counts duplicates
- `tail` lets you get the last n things
- `paste` merge lines of files
  - `paste -sd,` join all lines into a single line, delimited by `,`
## awk
- `awk` a whole language ... column based stream processing ... similar to sed but more focused on columnar data
  - `awk '{print $2}'` print 2nd column
  - `awk '$1 == 1 && $2 ~ /^c.*e$/ {print $2}'` only appear once, start with c, end with e
  - `awk 'BEGIN { rows = 0 } $1 == 1 && $2 ~ /^c.*e$/ {rows += 1} END { print rows }'`
    - begin matches only 0th line
    - end matches only after last line
    - on 0th line, set `rows` to 0
    - everytime the pattern is matched, increment `rows`
    - after last line, print `rows`
## bc
- `bc` a command line calculator that reads from stdin
  - `echo "1 + 2" | bc -l`
  - lets sum up the number of usernames that have been used more than once
  - `cat ssh.log | sed -e 's/^.*?Disconnected from (invalid |authenticating )?user (.*) [0-9.]+ port [0-9]+( \[preauth\]?$/\2/' | sort | uniq -c | awk '$1 != 1 { print $1 } | paste -sd+ | bc -l`
## lets do some other shit
- delete all the 2019 nightly builds of rust
  - `rustup toolchain list | grep nightly | grep -v 'nightly-x86' | grep 2019 | sed 's/-x86.*//' | xargs echo rustup toolchain uninstall`
    - xargs runs the last thing with stdout as the args
- have ffmpeg read from the webcam and take the first frame and send it to the server and back and open locally in image viewer
  - `ffmpeg -loglevel panic -i /dev/video0 -frames l -f image - | convert - -colorspace gray - | gzip | ssh tsp 'gzip -d | tee copy.png' | feh -`
    - last `-` in ffmpeg command means print output to stdout instead of a file
    - first `-` in convert means grab stdin, ending `-` means pipe to stdout