%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
int yylineno;
%}

%union {
    int num;
    char* id;
}

%token <num> NUMBER
%token <id> IDENTIFIER

%token IF THEN ELSE ELSE_IF
%token FUNCTION RETURN CALL
%token DRAW_CIRCLE
%token KEY_PRESSED KEY_UP KEY_DOWN KEY_LEFT KEY_RIGHT
%token LOOP WHILE ENDLOOP

%token ASSIGN ADD_ASSIGN SUB_ASSIGN
%token EQUAL NOT_EQUAL
%token PLUS MINUS MULT DIV MOD POW

%start program

%%

program:
    statement_list
    {
        printf("[Başarılı] Kod gramer kurallarına uygundur.\n");
    }
;

statement_list:
    statement
    | statement_list statement
;

statement:
      IDENTIFIER ASSIGN expression ';'
    | IF expression THEN statement
    | IF expression THEN statement ELSE statement
    | FUNCTION IDENTIFIER IDENTIFIER_LIST ':' statement_list
    | CALL IDENTIFIER argument_list ';'
    | DRAW_CIRCLE expression expression expression ';'
    | KEY_PRESSED KEY_UP statement
    | LOOP expression WHILE statement_list ENDLOOP
    | RETURN expression ';'
;

IDENTIFIER_LIST:
    IDENTIFIER
  | IDENTIFIER_LIST IDENTIFIER
;

argument_list:
    expression
  | argument_list expression
;

expression:
      NUMBER
    | IDENTIFIER
    | expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | expression MOD expression
    | expression POW expression
    | expression EQUAL expression
    | expression NOT_EQUAL expression
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Hata (Satır %d): %s\n", yylineno, s);
}
