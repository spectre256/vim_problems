:r!sed -u '/^[[:space:]]*$/q' /proc/$PPID/fd/0
:let len=0
:%g/^Content-Length: \zs\d\+/norm ygn:let len="
:exe 'r!head -c ' . len . ' /proc/$PPID/fd/0'
:%s#^GET \zs/\ze #/index.html
:%s#^GET \zs\S*\.\.\S*\ze #/404.html
:%s#\v^GET \zs/(\S*)\ze #\1
:%g/^GET \zs\S\+/try | exe 'norm ngf' | cat | e 404.html | endt
:let status=expand("%:t")=="404.html"?"404 Not Found":"200 OK"
:let mime='text/'.expand("%:e:s/\\v<(html>)@!\\a+/plain/")
gg"fyG
ggcGHTTP/1.1 =status
Content-Type: =mime
Connection: close

"fp:wq!/dev/stdout
