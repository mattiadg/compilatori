%{
#include <stdio.h>
int max = 0;
char* nome = NULL;
char* data = NULL;
char* rist = NULL;
%}

%union{
	char* stringa;
	int int_t;
}

%token DATA RIST CAM ACAM CCAM ABAR CBAR AANT CANT APRI CPRI ASEC CSEC ADOL CDOL END SEP
%token<stringa> DAY NRIST NCAM ORD
%type <int_t> Comanda Lista
%type <stringa> Cameriere
%start Prog

%error-verbose

%%

Prog: Prima SEP Seconda		{ printf("Data: %s;\nNome ristorante: %s;\nNome cameriere: %s;\nPunteggio: %d;\n", data, rist, nome, max); }
	;

Prima: Riga1 Riga2 Riga3 
	 ;

Riga1: DATA DAY ';'			{ data = $2; }
	 ;

Riga2: RIST NRIST ';'		{ rist = $2; }
	 ;

Riga3: CAM El_camerieri ';'
	 ;

El_camerieri: El_camerieri ',' NCAM
			| NCAM
			;
	 
Seconda: Seconda Cameriere Comanda END		{ if($3 > max){ max = $3; nome = $2; } }
	   | Cameriere Comanda END				{ if($2 > max){ max = $2; nome = $1; } }
	   ;

Cameriere: ACAM NCAM CCAM 	{ $$ = $2; }
		 ;

Comanda: Comanda ABAR Lista CBAR	{ $$ = $1 + $3; }
	   | ABAR Lista CBAR			{ $$ = $2; }
	   | Comanda AANT Lista CANT	{ $$ = $1 + $3; }
	   | AANT Lista CANT			{ $$ = $2; }
	   | Comanda APRI Lista CPRI	{ $$ = $1 + 2 * $3; }
	   | APRI Lista CPRI			{ $$ = $2; }
	   | Comanda ASEC Lista CSEC	{ $$ = $1 + 3 * $3; }
	   | ASEC Lista CSEC			{ $$ = $2; }
	   | Comanda ADOL Lista CDOL	{ $$ = $1 + $3; }
	   | ADOL Lista CDOL			{ $$ = $2; }
	   ;

Lista: Lista ',' ORD	{ $$ = $1 + 1; }
	 | ORD				{ $$ = 1; }
	 ;

%%

int main(){
	return(yyparse());
}

yyerror(char* s){
	printf("%s\n", s);
}
