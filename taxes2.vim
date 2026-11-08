:" read pdf
:" parse std deductions
:" parse tax bracket
:" parse tax table
:" define tax fn
:" table of: cond var prompt spec error fn
:let Sum={str->str->split()->reduce({acc,x->acc+x->substitute(",","","g")->matchstr("\\$\\?\\zs.*")->str2float()},0.0)->printf("$%.2f")}
i1 married "Are you married or single? (m[arried]|s[ingle]) " '\v^(m%[arried]|s%[ingle])$' 'Invalid marital status' {s->s[0]=='m'}
1 name "What is your full name? (first [m] last) " '\v^\w+(\s+\w\.?)?\s+(\w+)$' 'Please provide your full name, with no spaces except between first, middle initial, and last' {s->{ss->len(ss)==2?ss:[ss[0:1]->join()->matchstr('[^.]*'),ss[2]]}(s->split())}
1 ssn "What is your SSN? (xxx-xx-xxxx) " '\v^\d{3}-\d\d-\d{4}$' 'Invalid SSN' {s->s->substitute('[^0-9]', '', 'g')}
1 earnings "Enter the earnings shown on your W2(s): " '\v\s*(\$?\d+(\.\d{1,2})?\s*)+' 'Earnings must be a space-separated list of numbers' Sum
1 extra "Enter any additional earnings:  " '\v\s*(\$?\d+(\.\d{1,2})?\s*)*' 'Earnings must be a space-separated list of numbers' Sum

:%g/your/t. | s/\v^(\S+) /married\&\&\1 spouse_/ | s/your\zs/ spouse's/
Gi:::
i%FDF-1.2
1 0 obj
<< /FDF << /Fields [
<< /T (page1.f1_14[0]) /V (=name[0]) >>
<< /T (page1.f1_15[0]) /V (=name[1]) >>
<< /T (page1.f1_16[0]) /V (=ssn) >>
<< /T (page1.f1_17[0]) /V (=get(g:,'spouse_name',['',''])[0]) >>
<< /T (page1.f1_18[0]) /V (=get(g:,'spouse_name',['',''])[1]) >>
<< /T (page1.f1_19[0]) /V (=get(g:,'spouse_ssn','')) >>
<< /T (page1.Checkbox_ReadOrder[0].c1_8[=married]) /V /=married+1 >>
] >> >>
endobj
trailer
<< /Root 1 0 R >>
%%EOFk
:%s/page1/topmostSubform[0].Page1[0]
:!curl -fsSLO https://www.irs.gov/pub/irs-pdf/f1040.pdf 
:w !pdftk f1040.pdf fill_form - output f1040.filled.pdf
:!xdg-open f1040.filled.pdf
:q!
?:::
dd"tdG
:%s/\v(\S+) (\w+) ("[^"]*") ('[^']+') ('[^']*') (.*)/if \1 | let \2=input(\3)->matchstr(\4) | while \2 == "" | echo "\\n" | echom \5 | let \2=input(\3)->matchstr(\4) | endwhile | let \2=\6(\2) | endif
:%norm A |
ggVGJI:A norm @tdd@"