%token sprintf anything
%x PREBODY BODY PARENS
%%
start: sprintf '(' ')';
%%
char '([^'\\\r\n]|\\.)+'
name [A-Z_a-z][0-9A-Z_a-z]*
string \"([^"\\\r\n]|\\.)*\"
ws [ \t\r\n]+|"//".*|"/*"(?s:.)*?"*/"
%%
<INITIAL>sprintf<PREBODY>     sprintf
<PREBODY>\(<BODY>        '('
<PREBODY>(?s:.)<.>       skip()
<BODY,PARENS>\(<>PARENS> skip()
<PARENS>\)<<>            skip()
<BODY>\)<INITIAL>        ')'
<BODY,PARENS>{char}<.>   skip()
<BODY,PARENS>{name}<.>   skip()
<BODY,PARENS>{string}<.> skip()
<BODY,PARENS>{ws}<.>     skip()
<BODY,PARENS>(?s:.)<.>   skip()
{char}                   anything
{name}                   anything
{string}                 anything
{ws}                     anything
(?s:.)                   anything
%%
