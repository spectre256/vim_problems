:let @e='ggcGHTTP/1.1 408 Request TimeoutConnection: close:wq!/dev/stdout'
:exe "0r!timeout 0.5 sed -u \'/^[[:space:]]*$/q\' /proc/$PPID/fd/0" | if v:shell_error | exe 'norm @e' | en
:let len=0 | %g/^Content-Length: \zs\d\+/norm ygn:let len="
:exe 'r!timeout 0.5 head -c ' . len . ' /proc/$PPID/fd/0' | if v:shell_error | exe 'norm @e' | en
:1v/^GET /norm ggcGHTTP/1.1 405 Method Not AllowedAllow: GETConnection: close:wq!/dev/stdout
:1s#\v^GET \zs(https?://localhost:8080)?/?
:1s#^GET \zs/\S*#404.html
:1s#^GET \zs\S*\.\.\S*#404.html
:1s#^GET \zs\S*[~$]\S*#404.html
:1s#^GET \zs\ze #index.html
:1s#^GET \zs#static/
:1g/^GET \zs\S\+/try | exe 'norm ngf' | cat | e static/404.html | endt
:let status=expand("%:t")=="404.html"?"404 Not Found":"200 OK"
:let mime='text/'.expand("%:e:s/\\v^((html$)@!\\a+|)$/plain/")
gg"fyG
ggcGHTTP/1.1 =status
Content-Type: =mime; charset=utf-8
Connection: close
"fp:wq!/dev/stdout
