%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable.h"
#include <string.h>

char* anchor_generator();
%}

%union{
	char* stringa;
	int int_t;
}

%token AHTML CHTML AHEAD CHEAD ABODY CBODY ATITLE CTITLE 
%token<int_t> AH1 CH1 AH2 CH2 AH3 CH3 AH4 CH4
%token ATAG CTAG 
%token<stringa> TEXT HTEXT
%type<stringa> Header 
%start Input

%error-verbose

%%

Input: AHTML Head Body CHTML
	 ;

Head: AHEAD Tag_list CHEAD
	;

Body: ABODY Tag_list CBODY		{ print_table(table); printf("</body>\n"); }
	;

Tag_list: Tag_list Tag	
		| Tag_list ATAG
		| Tag_list Title	
		| Tag_list Header	
		| Tag_list TEXT	
		| /* Epsilon */
		;

Title: ATITLE CTITLE
	 ;

Tag: ATAG CTAG 
   ;

Header: AH1 HTEXT CH1 	{	struct entry* tmp = malloc(sizeof(struct entry));
  							tmp->name = $2; 
							tmp->anchor = anchor_generator();
							tmp->level = $1;
							add_entry(table, tmp);
			 			}
	  | AH2 HTEXT CH2    {	struct entry* tmp = malloc(sizeof(struct entry));
  							tmp->name = $2; 
     	  	  				tmp->anchor = anchor_generator();
							tmp->level = $1;
			  				add_entry(table, tmp);
			  			}
	  | AH3 HTEXT CH3   {	struct entry* tmp = malloc(sizeof(struct entry));
  							tmp->name = $2; 
							tmp->anchor = anchor_generator();
							tmp->level = $1;
							add_entry(table, tmp);
			  			}
	  | AH4	HTEXT CH4	{	struct entry* tmp = malloc(sizeof(struct entry));
  							tmp->name = $2; 
							tmp->anchor = anchor_generator();
							tmp->level = $1;
							add_entry(table, tmp);
			  			}
	  ;

%%

int main(void){
	table = create_table();
	yyparse();
	free_table(table);
}

yyerror(char* s){
	printf("%s\n", s);
}

char* anchor_generator(){
	static int val = 1;
	char buf[5];
	char title[7];
	sprintf(buf, "%d", val);
	val++;
	strcpy(title, "H_");
	strcat(title, buf);
	return strdup(title);
}
