1. done it
2. list of commands:
    - number of words that match: `cat /usr/share/dict/words | grep -i 'a.*a.*a.*s$' | wc`
    - top 3 most common 2 letter endings: `cat /usr/share/dict/words | grep -i 'a.*a.*a.*s$' | sed -E 's/.*(.{2})$/\1/' | sort | uniq -c | sort -nr | head -n 3` ... us, is, ss
    - how many combinations are there? `cat /usr/share/dict/words | grep -i 'a.*a.*a.*s$' | sed -E 's/.*(.{2})$/\1/' | sort | uniq -c | sort -nr | wc` ... 12
    - which combinations do not occur?
      - `printf "%s\n" {a..z}{a..z} > endings.txt`
      - `cat /usr/share/dict/words | grep -i 'a.*a.*a.*s$' | sed -E 's/.*(.{2})$/\1/' | sort | uniq | comm -13i - endings.txt`
3. use `sed -I extension` or `sed -i extension`