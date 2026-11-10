:let Std=[15750,31500]
:let Brackets=[[0,11925,48475,103350,197300,250525,626350],[0,23850,96950,206700,394600,501050,751600]]
:let Rates=[0.10,0.02,0.10,0.02,0.08,0.03,0.02]
:let Clamp={n->n>0?n:0}
:let Tax={n->range(7)->map({_,i->g:Rates[i]*g:Clamp(n-g:Brackets[g:married][i])})->reduce({acc,x->acc+x},0.0)->round()}
:" table of: cond var prompt spec error fn
:let Sum={str->str->split()->reduce({acc,x->acc+x->substitute(",","","g")->matchstr("\\$\\?\\zs.*")->str2float()},0.0)}
:let Show={n->n->round()->printf("%.0f")}
i1 married "Are you married or single? (m[arried]|s[ingle]) " '\v^(m%[arried]|s%[ingle])$' 'Invalid marital status' {s->s[0]=='m'}
1 name "What is your full name? (first [m] last) " '\v^\w+(\s+\w\.?)?\s+(\w+)$' 'Please provide your full name, with no spaces except between first, middle initial, and last' {s->{ss->len(ss)==2?ss:[ss[0:1]->join()->matchstr('[^.]*'),ss[2]]}(s->split())}
1 ssn "What is your SSN? (xxx-xx-xxxx) " '\v^\d{3}-\d\d-\d{4}$' 'Invalid SSN' {s->s->substitute('[^0-9]', '', 'g')}
1 street "Home address (number and street): " '\v^\S.*$' 'Please provide a street address' trim
1 apt "Apt. no. (leave blank if none): " '\v^\S*$' 'Apartment number cannot contain spaces' trim
1 city "City, town, or post office: " '\v^\S.*$' 'Please provide a city' trim
1 state "State (XX): " '^\a\a$' 'State must be a two-letter abbreviation' toupper
1 zip "ZIP code (xxxxx or xxxxx-xxxx): " '\v^\d{5}(-\d{4})?$' 'Invalid ZIP code' trim
1 occupation "What is your occupation? " '\v^\S.*$' 'Please provide an occupation' trim
1 earnings "Enter the earnings shown on your W2(s): " '\v^\s*(\$?\d[0-9,]*(\.\d{1,2})?\s*)+$' 'Earnings must be a space-separated list of numbers' Sum
1 extra "Enter any additional earnings:  " '\v^\s*(\$?\d[0-9,]*(\.\d{1,2})?\s*)*$' 'Earnings must be a space-separated list of numbers' Sum
1 withheld "Enter the federal income tax withheld on your W2(s): " '\v^\s*(\$?\d[0-9,]*(\.\d{1,2})?\s*)+$' 'Withholding must be a space-separated list of numbers' Sum

:%g/your/t. | s/\v^(\S+) /married\&\&\1 spouse_/ | s/your\zs/ spouse's/
Gi:::
:let line_1a=earnings+get(g:,'spouse_earnings',0)
:let line_1h=extra
:let line_1z=line_1a+line_1h
:let line_9=line_1z
:let line_11a=line_9
:let line_11b=line_11a
:let line_12e=Std[married]
:let line_14=line_12e
:let line_15=Clamp(line_11b-line_14)
:let line_16=Tax(line_15,married)
:let line_18=line_16
:let line_22=line_18
:let line_24=line_22
:let line_25a=withheld+get(g:,'spouse_withheld',0)
:let line_25d=line_25a
:let line_33=line_25d
:let line_34=Clamp(line_33-line_24)
:let line_35a=line_34
:let line_37=Clamp(line_24-line_33)
i%FDF-1.2
1 0 obj
<< /FDF << /Fields [
<< /T (page1.f1_14[0]) /V (=name[0]) >>
<< /T (page1.f1_15[0]) /V (=name[1]) >>
<< /T (page1.f1_16[0]) /V (=ssn) >>
<< /T (page1.f1_17[0]) /V (=get(g:,'spouse_name',['',''])[0]) >>
<< /T (page1.f1_18[0]) /V (=get(g:,'spouse_name',['',''])[1]) >>
<< /T (page1.f1_19[0]) /V (=get(g:,'spouse_ssn','')) >>
<< /T (page1.Address_ReadOrder[0].f1_20[0]) /V (=street) >>
<< /T (page1.Address_ReadOrder[0].f1_21[0]) /V (=apt) >>
<< /T (page1.Address_ReadOrder[0].f1_22[0]) /V (=city) >>
<< /T (page1.Address_ReadOrder[0].f1_23[0]) /V (=state) >>
<< /T (page1.Address_ReadOrder[0].f1_24[0]) /V (=zip) >>
<< /T (page1.Checkbox_ReadOrder[0].c1_8[=married]) /V /=married+1 >>
<< /T (page1.f1_47[0]) /V (=Show(line_1a)) >>
<< /T (page1.f1_55[0]) /V (=line_1h==0?'':Show(line_1h)) >>
<< /T (page1.f1_57[0]) /V (=Show(line_1z)) >>
<< /T (page1.f1_73[0]) /V (=Show(line_9)) >>
<< /T (page1.f1_75[0]) /V (=Show(line_11a)) >>
<< /T (page2.f2_01[0]) /V (=Show(line_11b)) >>
<< /T (page2.f2_02[0]) /V (=Show(line_12e)) >>
<< /T (page2.f2_05[0]) /V (=Show(line_14)) >>
<< /T (page2.f2_06[0]) /V (=Show(line_15)) >>
<< /T (page2.f2_08[0]) /V (=Show(line_16)) >>
<< /T (page2.f2_10[0]) /V (=Show(line_18)) >>
<< /T (page2.f2_14[0]) /V (=Show(line_22)) >>
<< /T (page2.f2_16[0]) /V (=Show(line_24)) >>
<< /T (page2.f2_17[0]) /V (=Show(line_25a)) >>
<< /T (page2.f2_20[0]) /V (=Show(line_25d)) >>
<< /T (page2.f2_29[0]) /V (=Show(line_33)) >>
<< /T (page2.f2_30[0]) /V (=Show(line_34)) >>
<< /T (page2.f2_31[0]) /V (=Show(line_35a)) >>
<< /T (page2.f2_35[0]) /V (=Show(line_37)) >>
<< /T (page2.f2_40[0]) /V (=occupation) >>
<< /T (page2.f2_42[0]) /V (=get(g:,'spouse_occupation','')) >>
<< /T (page2.c2_17[0]) /V /2 >>
] >> >>
endobj
trailer
<< /Root 1 0 R >>
%%EOFk
:%s/page\(\d\+\)/topmostSubform[0].Page\1[0]
:!curl -fsSLO https://www.irs.gov/pub/irs-pdf/f1040.pdf 
:w !pdftk f1040.pdf fill_form - output f1040.filled.pdf
:!xdg-open f1040.filled.pdf
:q!
?:::
dd"tdG
:%s/\v(\S+) (\w+) ("[^"]*") ('[^']+') ('[^']*') (.*)/if \1 | let \2=input(\3) | while \2 !\~ \4 | echo "\\n" | echom \5 | let \2=input(\3) | endwhile | let \2=\6(\2) | endif
:%norm A |
ggVGJI:A norm @tdd@"
