:!curl -O https://www.irs.gov/pub/irs-pdf/f1040.pdf
:r! pdftk f1040.pdf generate_fdf output -
:let page1='topmostSubform[0].Page1[0].'
o
"Are you married or single? (s[ingle]|m[arried]) " '\v%[married]|%[single]' '\=page1."Checkbox_ReadOrder[0].c1_8[".submatch(0)=="m"."] /On"' 'Invalid marital status'
"What is your full name? (first m? last) " '\v(\w+(\s+\w)?)\s+(\w+)' '\=page1."f1_14[0] (".submatch(1).")\r".page1."f1_15[0] (".submatch(3).")"' 'Invalid name'
"What is your SSN? (xxx-xx-xxxx) " '\v(\d{3}-\d\d-\d{4})' '\=page1."f1_16[0] (".submatch(0).")"' 'Invalid SSN'
"Enter the earnings shown on your W2's (space separated numbers) " '\v%s*(\d+(\.\d{1,2})?\s*)+' '\=page1."f1_47[0] (".submatch(0)->split()->reduce({x,y->x+y}).")"'

:%s#\v"([^"]*)" '([^']*)' '([^']*)' '([^']*)'#=input(\1):try | s/\2/\3/ | cat | echom "\4" | cq | endt
=input('Are you married or single? (s[ingle]|m[arried]) '):try | s#\%[married]\|\%[single]#\=(submatch(0)[0]=='m'?''?'').''# | cat |  echom "Invalid marital status" | cq | endt
:
:let in=input('Are you married or single? (s[ingle]|m[arried]) ') | if matchstr('\%[married]')->len() != 0
