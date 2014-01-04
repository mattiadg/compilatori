%{
#include <stdio.h>
char* max_team = NULL, *max_all = NULL;
int max = 0, punt = 0;
%}

%union{
	int val;
	char* char_t;
}

%token DAY ARR SEP
%token <char_t> SQUADRA ALL
%token <val> NUM
%start Prog

%error-verbose

%%

Prog: Prima SEP Seconda { if( max_all != NULL ) printf("Squadra vincente: %s\nPunteggio: %d\nMiglior allenatore: %s\n", max_team, max, max_all);
						  else printf("Dati non compatibili!\n"); } 
	;

Prima: DAY NUM ';' Results
	 ;

Results: Results Line 
	   | /* empty rule*/
	   ;

Line: SQUADRA ARR NUM NUM NUM NUM NUM ';' { punt = ($3-$4)*4 + $5*3 - $6 - ($7*2); 
											if( punt > max ){
											max = punt;
											max_team = $1;
											}
										}
	;

Seconda: Seconda Coppia
	   | /* Empty Rule */
	   ;

Coppia: SQUADRA ',' ALL ';' { if( !strcmp($1, max_team) ) max_all = $3; }

%%

int main(){
	return(yyparse());
}

yyerror(char* s){
	printf("%s\n", s);
}
