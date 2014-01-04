#ifndef SYMTABLE_H
#define SYMTABLE_H

struct entry{
	char* name;
	char* anchor;
	int level;
};

struct table{
	struct entry **table;
	int pos;
	int read_pos;
	int max_level;
};
typedef struct table *symtable;

symtable table;

symtable create_table();

int add_entry(symtable t, struct entry *new_entry);

struct entry* get_next_entry(symtable t);

int has_entry(symtable t);

void free_table(symtable t);

void print_table(symtable t);
#endif
