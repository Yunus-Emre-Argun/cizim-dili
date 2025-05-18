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

// Anahtar kelimeler ve komutlar
%token IF THEN ELSE
%token FUNCTION END_FUNCTION RETURN CALL
%token DRAW_CIRCLE
%token KEY_PRESSED KEY_UP KEY_DOWN KEY_LEFT KEY_RIGHT
%token DONGU IKEN NEKI
%token FONK KNOF
%token TUS_BASILDI TUS_YUKARI TUS_ASAGI TUS_SOLA TUS_SAGA

// Operatörler
%token ASSIGN ADD_SUB_ASSIGN
%token EQUAL NOT_EQUAL
%token PLUS MINUS MULT DIV MOD POW

%start program

%%

program:
    statement_list
    {
        printf("[Basarili] Kod gramer kurallarina uygundur.\n");
    }
;

statement_list:
      statement
    | statement_list statement
;

statement:
      IDENTIFIER ASSIGN expression ';'
    | IDENTIFIER ADD_SUB_ASSIGN expression ';'
    | IF expression THEN statement
    | IF expression THEN statement ELSE statement
    | FONK IDENTIFIER IDENTIFIER_LIST ':' statement_list KNOF
    | FUNCTION IDENTIFIER IDENTIFIER_LIST ':' statement_list END_FUNCTION
    | CALL IDENTIFIER argument_list ';'
    | DRAW_CIRCLE expression expression expression ';'
    | TUS_BASILDI direction statement
    | DONGU expression IKEN statement_list NEKI
    | RETURN expression ';'
;

direction:
      TUS_YUKARI
    | TUS_ASAGI
    | TUS_SOLA
    | TUS_SAGA
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
    fprintf(stderr, "Hata (Satir %d): %s\n", yylineno, s);
}