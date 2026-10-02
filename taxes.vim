:!curl -O https://www.irs.gov/pub/irs-pdf/f1040.pdf
:r! pdftk f1040.pdf generate_fdf output -
o
"Are you married or single? (s[ingle]|m[arried]) " '\v%[married]|%[single]' '\="/".submatch(0)=="m"'
"What is your full name? (first m? last) " '\v(\w+(\s+\w)?)\s+(\w+)'
"What is your SSN? (xxx-xx-xxxx) " '\v(\d{3}-\d\d-\d{4})'
"How much did you earn? " '\v\$?(\d+)'

=input('Are you married or single? (s[ingle]|m[arried]) '):try | s/\%[married]\|\%[single]/\=(submatch(0)[0]=='m'?''?'').''/ | cat |  echom "Invalid marital status" | cq | endt
:
:let in=input('Are you married or single? (s[ingle]|m[arried]) ') | if matchstr('\%[married]')->len() != 0
