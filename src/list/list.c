#include "list/list.h"
#include "util.h"

void listInsert(Node* list, Node* newNode, int pos)
{
    Node* prev = list;    
    if (prev == NULL) {
        fprintf(stderr, "Error: list can't be a NULL.");
        return;
    }

    for (int i = 0; i < pos; i++) {
        if (prev->next == NULL) {
            fprintf(stderr, "Error: out of range.");
            return;
        }
        prev = prev -> next;
    }

    newNode->next = (prev->next);
    prev->next = newNode;

    return;
}



void printList(Node *list) {
    if (list == NULL) {
        printErr("Error: list is NULL.\n");
        return;
    }

    Node *cur = list -> next;
    if (cur == NULL) {
        puts("(empty list.)");
        return ;
    }

    if (cur != NULL) {
        printf("%d", cur->data);
        cur = cur->next;
    }

    for ( ; cur != NULL; cur = cur->next) {
        printf("->%d", cur->data);
    }
    printf("\n");

}