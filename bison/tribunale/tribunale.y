%{
#include <stdio.h>
#include <string.h>
int base = 0, punt = 0, min = 0;
%}

%union{
	int int_val;
	char* str;
}
%token TRIB ASTA IMMO BASE ARR SEP
%token<int_val> NUM
%token<str> CITTA COSE NOME
%type<int_val> Asta Prima Input
%type<str> Offerte Offerta
%start Input
%error-verbose

%%

Input: Prima SEP Offerte 		{ printf("asta N: %d\nVincitore: %s\nOfferta: %d\n", $1, $3, min); }
	 ;

Prima: Trib Asta Immo Base		{ $$ = $2; }
	 ;

Trib: TRIB CITTA ';'
	;

Asta: ASTA NUM ';'		{ $$ = $2; }
	;

Immo: IMMO Immo_list ';'
	;

Immo_list: COSE
		 | COSE ',' Immo_list
		 ;

Base: BASE NUM ';' 		{ base = $2; }
	;

Offerte: Offerte Offerta		 { if( (punt < min) && (punt > base)){ $$ = $2; min = punt; } } 
	   | Offerta				 { min = punt; $$ = $1; }
	   | /* Empty string */		
	   ;

Offerta: NOME NOME ARR NUM ';' 		{ punt = $4; $$ = strdup(strcat($1, $2)); }
	   ;

%%

int main(void){
	return(yyparse());
}

yyerror(char* s){
	printf("%s\n", s);
}
