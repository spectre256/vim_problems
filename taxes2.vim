:" read pdf
:" parse std deductions
:" parse tax bracket
:" parse tax table
:" define tax fn
:" table of: cond var prompt spec error fn
i1 married "Are you married or single? (m[arried]|s[ingle]) " '\v^(m%[arried]|s%[ingle])$' "Invalid marital status" {s->s[0]=='m'}
1 name "What is your name? (first m? last) "

:%g/your/t. | s/\v^(\S+) /married\&\&\1 spouse_/ | s/your\zs/ spouse's/
i:::
%FDF-1.2
1 0 obj
<< /FDF << /Fields [
<< /T (page1.f1_14[0]) /V (=name[0]) >>
<< /T (page1.f1_16[0]) /V (=ssn) >>
<< /T (page1.Checkbox_ReadOrder[0].c1_8[0]) /V /=married >>
] >> >>
endobj
trailer
<< /Root 1 0 R >>
%%EOF

:%s/page1/topmostSubform[0].Page1[0]
:w! pdftk ...
:!xdg-open ...
?:::dd"tdG
:%s/\v(\S+) (\w+) ("[^"]*") ('[^']+') ("[^"]*") (\{[^}]+\})/if \1 | let \2=input(\3)->matchstr(\4) | while \2 == "" | echom \5 | let \2=input(\3)->matchstr(\4) | endwhile | let \2=\6(\2) | endif
:%norm A |
ggVGJI:A | norm @tdd@"
