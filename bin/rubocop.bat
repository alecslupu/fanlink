@echo off
wsl ~/.rbenv/shims/rubocop $^(echo '%*' ^| sed -e 's^|\\^|/^|g' -e 's^|\^([A-Za-z]\^)\:/\^(.*\^)^|/\L\1\E/\2^|g'^)
