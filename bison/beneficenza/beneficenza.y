%{
#include <stdio.h>

int max = 0, punt = 0;
%}

%union{
	int int_val;
	char* stringa;
}

%token ARR END SEP
%token<int_val> NUM
%token<stringa> DENOM NOME

%type <int_val> Lista_num
%type <stringa> Lista_benef Seconda Benef
%start Input

%%

Input: Prima SEP Seconda { printf("Miglior benefattore: %s\nDonazioni: %d\n", $3, max); }
	 ;

Prima: Lista_enti
	 | Ente
	 ;

Lista_enti: Lista_enti Ente
		  | Ente
		  ;

Ente: DENOM ';' NOME '.'
	;

Seconda: Lista_benef	{ $$ = $1; }
	   | Benef			{ $$ = $1; max = punt; printf("%d\n", max); }
	   ;

Lista_benef: Lista_benef Benef { if(max < punt){
		   							max = punt;
									$$  = $2;
								}
								else $$ = $1;
								punt = 0;
								}
		   | Benef	{ $$ = $1; max = punt; printf("%d\n", max); }
		   ;

Benef: NOME ARR Lista_num END { $$ = $1; punt = $3; }
	 ;

Lista_num: NUM					{ $$ = $1; }
		 | Lista_num ';' NUM	{ $$ = $1 + $3; }
		 ;

%%

int main(void){
	return(yyparse());
}

yyerror(char* s){
	printf("%s\n", s);
}
