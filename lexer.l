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
"<>"                { return NOT_EQUAL; }
"+<-"               { return ADD_SUB_ASSIGN; }

"dongu"             { return DONGU; }
"iken"              { return IKEN; }
"neki"              { return NEKI; }
"fonk"              { return FUNCTION; }       // Alternatif isimlendirme: FONK
"knof"              { return END_FUNCTION; }   // Varsa kapanış token'ı
"tus_basildi"       { return KEY_PRESSED; }
"TUS_YUKARI"        { return KEY_UP; }

{DIGIT}             { yylval.num = atoi(yytext); return NUMBER; }
{ID}                { yylval.id = strdup(yytext); return IDENTIFIER; }
{COMMENT}           { /* yorumları yoksay */ }
[ \t\r\n]+          { /* boşlukları atla */ }
.                   { return *yytext; }

%%

int yywrap(void) {
    return 1;
}

