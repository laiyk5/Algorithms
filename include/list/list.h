#include <stdio.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;


// Every list has a dump head.


void listInsert(Node* list, Node* newNode, int pos);

void printList(Node *list);
