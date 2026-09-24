qqqqqyyp
:1s/-\?\d\+/\=submatch(0)-1/g
:2/\v(-\d*)@<!\d+$
:2s/\v(-?\d+)\s*/\=' x'[submatch(1)>0]/g
k@qq@q
:%s/\v(x *)@<= ( *x)@=//gn
:%s/\_.*/\=v:statusmsg+0
