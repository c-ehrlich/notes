## 1
`pgrep sleep`
`pkill -af sleep`
## 2
`sleep 1000`
`^z` - suspend
`bg` - continue in bg
`pgrep sleep | wait && ls`