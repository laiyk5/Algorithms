#include "list/list.h"
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    Node list = { data: 0, next: NULL};
    printList(&list);

    Node node_1 = { data: 1, next: NULL};
    Node node_2 = { data: 2, next: NULL};
    Node node_3 = { data: 3, next: NULL};

    listInsert(&list, &node_1, 0);
    printList(&list);
    
    listInsert(&list, &node_2, 1);
    printList(&list);

    listInsert(&list, &node_3, 2);
    printList(&list);

    listInsert(&list, &node_3, 10);
    printList(&list);

    return 0;
}
