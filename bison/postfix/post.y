%{
#include <stdio.h>
#include <string.h>
#include "tree.h"
%}

%union{
	char* stringa;
	struct albero* tree;
}

%token N
%token<stringa> NUM
%type<tree> Espr
%start Input

%error-verbose
%%

Input: Input Linea		{ printf("\n"); }
	 | /*Empty rule */
	 ;

Linea: Espr N	{ printInfix($1); clearTree($1); }
	 | N

Espr: Espr Espr '+'		{ $$ = newNode("+", $1, $2); }	
	| Espr Espr '-'		{ $$ = newNode("-", $1, $2); }
	| Espr Espr '/'	   	{ $$ = newNode("/", $1, $2); }
	| Espr Espr '*'		{ $$ = newNode("*", $1, $2); }
	| NUM				{ $$ = newNode($1, NULL, NULL); }
	;

%%

int main(void){
	yyparse();
	return(0);
}

yyerror(char* s){
	printf("%s\n", s);
}
