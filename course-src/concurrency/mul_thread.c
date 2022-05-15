#include <stdio.h>
#include "thread.h"

void ta() { while(1) {printf("%c",'a');}}

void tb() { while(1) {printf("%c",'b');}}

int main()
{
    create(ta);
    create(tb);
}
