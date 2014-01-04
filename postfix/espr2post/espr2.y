/*
 * Analizzatore sintattico per espressioni aritmetiche
 * (versione che effettua la valutazione della stringa di input: l'output e' "Errore sintattico" se 
 * c'e' un errore sintattico, altrimenti l'output e' il valore dell'espressione.)
 *
 * Questo file (espr2.y) e' da usare insieme all'analizzatore lessicale
 * realizzato con FLEX a partire da espr2.fl.
 *
 * Riconosce espressioni aritmetiche secondo la seguente grammatica:
 *
 *   E -> E + T | E - T | T
 *   T -> T * F | T / F | F
 *   F -> ( E ) | numero
 *
 *
 * Sequenza di comandi per generare l'analizzatore sintattico:
 *
 *     flex espr2.fl
 *     bison -d espr2.y
 *     gcc lex.yy.c espr2.tab.c -o espr2
 */

%{
#include <stdio.h>
%}

%token NUM PIU PER PAR_AP PAR_CH NEWL

%start Input
%error-verbose
%%
Input: 	/* empty */
	| Input Line ;

Line: NEWL
      | Expr 
	  ;


Expr: Expr PIU Term	{ printf("+ "); }
      | Term  
       ; 

Term: Term PER Factor	{ printf("* "); }  
      | Factor 
      ; 
Factor: NUM { printf("%d ", $1); }
      | PAR_AP Expr PAR_CH 
      ;
%% 

main()
{
  yyparse();
}

yyerror (char *s) 
     
{
  printf ("Errore Sintattico\n");
}
