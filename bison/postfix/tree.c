#include <stdlib.h>
#include <stdio.h>
#include "tree.h"

Tnode newNode(char* newval, Tnode sx, Tnode dx){
	Tnode tmp = (Tnode) malloc(sizeof(struct albero));
	tmp->val = newval;
	tmp->sx = sx;
	tmp->dx = dx;
	return tmp;
}

void printInfix(Tnode root){
	if( (root->sx != NULL) && (root->dx != NULL) ){
		printf("(");
		printInfix(root->sx);
		printf("%s", root->val);
		printInfix(root->dx);
		printf(")");
	}
	else
		printf("%s", root->val);
}

void clearTree(Tnode root){
	if(root->sx != NULL)
		clearTree(root->sx);
	if(root->dx != NULL)
		clearTree(root->dx);
	free(root);
}
