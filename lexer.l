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
"aksi"              { return ELSE; }
"halde"             { /* sadece okunur, yoksay */ }

"fonk"              { return FONK; }
"knof"              { return KNOF; }

"tus_basildi"       { return TUS_BASILDI; }
"TUS_YUKARI"        { return TUS_YUKARI; }
"TUS_ASAGI"         { return TUS_ASAGI; }
"TUS_SOLA"          { return TUS_SOLA; }
"TUS_SAGA"          { return TUS_SAGA; }

"daire_ciz"         { return DRAW_CIRCLE; }

"CALL"              { return CALL; }
"RETURN"            { return RETURN; }

"<-"                { return ASSIGN; }
"+<-"|"-<-"        { return ADD_SUB_ASSIGN; }
"="                 { return EQUAL; }
"<>"                { return NOT_EQUAL; }

"dongu"             { return DONGU; }
"iken"              { return IKEN; }
"neki"              { return NEKI; }

"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MULT; }
"/"                 { return DIV; }
"%"                 { return MOD; }
"^"                 { return POW; }

{DIGIT}             { yylval.num = atoi(yytext); return NUMBER; }
{ID}                { yylval.id = strdup(yytext); return IDENTIFIER; }
{COMMENT}           { /* yorumlari yoksay */ }
[ \t\r\n]+          { /* bosluklari yoksay */ }
.                   { return *yytext; }

%%

int yywrap(void) {
    return 1;
}