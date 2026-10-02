:" !curl -O https://www.irs.gov/pub/irs-pdf/f1040.pdf
:" r! pdftk f1040.pdf generate_fdf output -
:let page1='topmostSubform[0].Page1[0].'
:let Sum={str->str->split()->reduce({acc,x->acc+x->matchstr("\\$\\?\\zs.*")->str2float()},0.0)->printf("$%.2f")}
i
'Are you married or single? (s[ingle]\\|m[arried]) ' '\v.*%[married]|%[single]' '\=page1."Checkbox_ReadOrder[0].c1_8[".(submatch(0)[0]=="m")."] /On"' 'Invalid marital status'
'What is your full name? (first [m] last) ' '\v(\w+(\s+\w)?)\s+(\w+)' '\=page1."f1_14[0] (".submatch(1).")\r".page1."f1_15[0] (".submatch(3).")"' 'Please provide your full name, with no spaces execept between first, middle initial, and last'
'What is your SSN? (xxx-xx-xxxx) ' '\v(\d{3}-\d\d-\d{4})' '\=page1."f1_16[0] (".submatch(0).")"' 'Invalid SSN'
'Enter the earnings shown on your W2(s): ' '\v\s*(\$?\d+(\.\d{1,2})?\s*)+' '\=page1."f1_47[0] (".Sum(submatch(0)).")"' 'Earnings must be a space-separated list of numbers'
'Enter any additional earnings:  ' '\v\s*(\$?\d+(\.\d{1,2})?\s*)*' '\=page1."f1_47[0] (".Sum(submatch(0)).")"' 'Earnings must be a space-separated list of numbers'

:3,4g/your/t. | s/your\zs/ spouse''s/g | s/f1_\zs\d\d/\=submatch(0)+3/g
:%s/\v('([^']|'')*') '([^']*)' '([^']*)' '(([^']|'')*)'/:exe "pu=input(\1)" | try | s#\3#\4# | exe 'sil norm @c' | cat | echom '\5' | endt/
:let @c=':try | exe ''/c1_8\[0] \/On'' | exe ''%g/spouse/d'' | cat | fina | let @c="" | exe "norm 2G@c" | endt'
2Gddk@"