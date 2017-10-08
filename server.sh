#!/bin/sh

port=8080

test "$1" = "-q" || xdg-open "http://localhost:$port" >/dev/null 2>/dev/null &
echo Starting testserver on port $port
echo Press Ctrl-C to terminate
lighttpd -f testserver/lighttpd.conf -D
