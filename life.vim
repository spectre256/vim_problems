:0t0 | $t$ | %norm 0yl$pyh0P
:let Live={->submatch(0)->count("█")-Cell()}
:let Cell={->submatch(1)!=" "}
:,$-2g/.\ze../norm jjll:s/\v\%V.\ze..\n.(.).\n.../\=" █"[Live()|Cell()==3]
:$d | %norm $hD
