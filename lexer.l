%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

DIGIT       [0-9]+
ID          [a-zA-Z_][a-zA-Z0-9_]*
COMMENT     "--".*

%%

"eger"              { return IF; }
"ise"               { return THEN; }
"daire_ciz"         { return DRAW_CIRCLE; }
"<-"                { return ASSIGN; }
"="                 { return EQUAL; }
{DIGIT}             { yylval.num = atoi(yytext); return NUMBER; }
{ID}                { yylval.id = strdup(yytext); return IDENTIFIER; }
{COMMENT}           { /* yorumları yoksay */ }
[ \t\r\n]+          { /* boşlukları atla */ }
.                   { return *yytext; }

%%

int yywrap(void) {
    return 1;
}
