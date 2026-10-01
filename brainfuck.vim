:let @o='' | se nohls
:%s/[^><+\-.,[\]]//g | %j!
:%s/>/w/g
:%s/</ge/g
:let @w='ciw=(256+")%256'
:%s/+/@w/g
:%s/-/@w/g
:%s/\./:let @o.=nr2char()/g
:%s/,/ciw=char2nr(input("Enter char: ")[0])/g
qqqqq
:%s/\[\([^[\]]*\(\n[^[\]]*\)*\)]/\=":wh expand('<cword>')!=0 | exe 'norm ".substitute(substitute(submatch(1), "'", "''", "g"), "[[:cntrl:]]", "\<C-v>\&", "g")."' | endwh\r"/g
@qq@q
:%s/\n/0/
gg"adG1000i0 0@aggVG"op
