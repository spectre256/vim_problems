#!/usr/bin/env sh
ncat -lkC 8080 -m 50 -c 'nvim --headless -u NONE -i NONE -s server.vim 2>/dev/null' --output server.log
