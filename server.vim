:let @q=':sil! w!/dev/stdout:qa!'
:let @e='ggcGHTTP/1.1 408 Request TimeoutConnection: close@q'
:exe "0r!timeout 0.5 sed -u \'/^[[:space:]]*$/q\' /proc/$PPID/fd/0" | if v:shell_error | exe 'norm @e' | en
:let len=0 | %g/\c^content-length:\s*\zs\d\+/norm ygn:let len=str2nr(")
:exe 'r!timeout 0.5 head -c '.len.' /proc/$PPID/fd/0' | if v:shell_error | exe 'norm @e' | en
:1v/^GET /norm ggcGHTTP/1.1 405 Method Not AllowedAllow: GETConnection: close@q
:1s#\v^GET \zs(https?://localhost:8080)?/?
:1s#^GET \zs/\f*#404.html
:1s#^GET \zs\f*\.\.\f*#404.html
:1s#^GET \zs\f*[~$]\f*#404.html
:1s#^GET \zs\ze\f\@!#index.html
:1s#^GET \zs#static/
:1s#^GET \zs\f*#\=isdirectory(submatch(0))?'404.html':submatch(0)
:1g/^GET \zs\f*/try | exe 'norm ngf' | cat | e static/404.html | endt
:let status=expand("%:t")=="404.html"?"404 Not Found":"200 OK"
:let mimes={'html':'text/html','css':'text/css','json':'application/json'}
:let mime=expand("%:e:s/.*/\\L\\0/:s#.*#\\=get(mimes,submatch(0),'text/plain')#")
gg"fyG
ggcGHTTP/1.1 =status
Content-Type: =mime; charset=utf-8
Connection: close
"fp@q
