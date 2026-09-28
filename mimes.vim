:r!curl https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types/Common_types
/figure class="table-container"
datggVGP
:%v/<code>/d
:%s#\(.*code>\), \(<code.*\)\n\(.*code>\), \(<code.*\)#\1</td>\r\3</td>\r<td>\2\r<td>\4
:%s#\(.*code>\), \(<code.*\)\n\(.*\)#\1</td>\r\3\r<td>\2\r\3
:%norm vitovitd0PlD
:%s/\v\.(.*)\n(.*)/'\1':'\2',
:%j!
I{A}:x mimes.txt
