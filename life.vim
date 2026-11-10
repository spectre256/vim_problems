:$t0 | 2t$ | %norm 0yl$pyh0P
:let Live={->(submatch(0).submatch(1).submatch(2).submatch(4))->count("█")-g:Cell()}
:let Cell={->submatch(3)!=" "}
:let @q='jjll:s/\v%V.\ze(..).*\n.{-}%V(.(.).).*\n.{-}%V(...)/\=[" ","█"][or(Live(),Cell())==3]
`<l@q'
:1,$-2norm 0@q
:$-1,$d | %norm $hD
