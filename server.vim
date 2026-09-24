:r!sed -u '/^[[:space:]]*$/q' /proc/$PPID/fd/0
:let len=0
:%g/^Content-Length: \zs\d\+/norm! ygn:let len="
:exe 'r!head -c ' . len . ' /proc/$PPID/fd/0'
ggcGHTTP/1.1 200 OK
Content-Type: text/html
Connection: close

<html>
<h1>Hello</h1>
<p>You sent:<br>"</p>
</html>
:wq!/dev/stdout
