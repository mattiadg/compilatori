#include "symtable.h"
#include <stdio.h>
#include <stdlib.h>

symtable create_table(){
	symtable t = (struct table*) malloc(sizeof(struct table));
	t->table = (struct entry**) malloc(50*sizeof(struct entry*));
	t->pos = 0;
	t->read_pos = 0;
}

int add_entry(symtable t, struct entry* new_entry){
	t->table[t->pos] = new_entry;
	(t->pos)++;
}

struct entry* get_next_entry(symtable t){
	return (t->table[(t->read_pos)++]);
}

int has_entry(symtable t){
	return (t->pos > t->read_pos)? 1 : 0;
}

void free_table(symtable t){
	int i;
	for(i = 0; i < t->pos; i++){
		free(t->table[i]);
	}
	free(t->table);
	free(t);
}

/*void adjust_levels(symtable t){
	int i, max = 0;
	for(i = 0; i < t->pos; i++){
		if(t->table[i]->level > max)
			max = t->table[i]->level;
	}
	for(i = 0; i < t->pos; i++){
		t->table[i]->level = max - t->table[i]->level + 1;
	}
}*/

void print_table(symtable t){
	int i;	
	int curr_lev = 0, new_lev;
	int openul = 0;
	struct entry* entry;
	printf("<H1>Indice</H1>\n");
	while(has_entry(t)){
		entry = get_next_entry(t);
		new_lev = entry->level;
		if(new_lev > curr_lev){
			printf("<ul>\n");
			curr_lev = new_lev;
			openul++;
		}
		else if(new_lev < curr_lev){
			printf("</ul>\n");
			curr_lev = new_lev;
			openul--;
		}
		printf("<li><a href=#%s>%s</a>\n", entry->anchor, entry->name);
	}
	for( ; openul > 0; openul--){
		printf("</ul>\n");
	}
}
