#ifndef TREE_H
#define TREE_H

struct albero{
	char* val;
	struct albero* sx;
	struct albero* dx;
};
typedef struct albero *Tnode;

Tnode newNode(char* newval, Tnode sx, Tnode dx);
void printInfix(Tnode root);
void clearTree(Tnode root);

#endif
