%{
	#include<stdio.h>
	#include<string.h>
	
	struct albero{
		char val;
		struct albero* sx;
		struct albero* dx;
	}
	void inord_trav(struct albero* p);
	struct albero* crea_nodo(char val, struct albero* sx, struct albero* dx);
%}
%token NUM NEWL

%start Input
%error-verbose

%%

Input: /* Empty string */
	 | Input Line
	 ;

Line: NEWL
	| Post { inord_trav($$); }
	;

Post: Expr Expr '*' { $$ = crea_nodo('*', (struct albero*)$1, (struct albero*) $2); }
	| Expr Expr '+' { $$ = crea_nodo('+', (struct albero*)$1, (struct albero*)$2); }
	;

Expr: NUM NUM '+' { $$ = crea_nodo('+', $1+'0', $2+'0'); }
	| NUM NUM '*' { $$ = crea_nodo('*', $1+'0', $2+'0'); }
	| NUM { $$ = crea_nodo($1+'0', NULL, NULL); }
	;
%%

main(void){
	yyparse();
}

yyerror(char* s){
	printf("%s", s);
}

struct albero* crea_nodo(char val, struct albero* sx, struct albero* dx){
	struct albero* tmp = (struct albero*) malloc(sizeof(struct albero));
	tmp->val = val;
	tmp->sx = sx;
	tmp->dx = dx;
	return tmp;
}

void inord_trav(struct albero* p){
	if(p->sx != NULL)
		inord_trav(p->sx);
	printf("%c ", p->val);
	if(p->dx != NULL)
		inord_trav(p->dx);
	free(p);
}
