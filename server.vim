:se bin noeol
:let @q=':sil! w!/dev/stdout:qa!'
:let @e="ggcGHTTP/1.1 408 Request Timeout\<C-v>\r\rConnection: close\<C-v>\r\r\<C-v>\r\r@q"
:exe "0r!timeout 0.5 sed -u '/^[[:space:]]*$/q' /proc/$PPID/fd/0" | if v:shell_error | exe 'norm @e' | en
:let len=0 | %g/\c^content-length:\s*\zs\d\+/norm ygn:let len=str2nr(")
:exe 'r!timeout 0.5 head -c '.len.' /proc/$PPID/fd/0' | if v:shell_error | exe 'norm @e' | en
:let @h='' | 1s/^HEAD/GET/ | let @h='dG'
:1v/^GET /exe "norm ggcGHTTP/1.1 405 Method Not Allowed\<C-v>\r\rAllow: GET, HEAD\<C-v>\r\rConnection: close\<C-v>\r\r\<C-v>\r\r@q"
:1s#\v^GET \zs(https?://localhost:8080)?/?
:1s#^GET \zs/\f*#404.html
:1s#^GET \zs\f*\.\.\f*#404.html
:1s#^GET \zs\f*[~$]\f*#404.html
:1s#^GET \zs\ze\f\@!#index.html
:1s#^GET \zs#static/
:1s#^GET \zs\f*#\=isdirectory(submatch(0))?'static/404.html':submatch(0)
:1g/^GET \zs\f*/try | exe 'norm gngf' | cat | e static/404.html | endt
:let status=expand("%:t")=="404.html"?"404 Not Found":"200 OK"
:let mimes={'html':'text/html','css':'text/css','js':'text/javascript','json':'application/json'}
:let mime=expand("%:e:s/.*/\\L\\0/:s#.*#\\=get(mimes,submatch(0),'text/plain')#")
ggIHTTP/1.1 =status
Content-Type: =mime
Connection: close

@h@q
