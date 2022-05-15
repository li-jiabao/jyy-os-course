#include <stdio.h>

struct {
    int a;
    char c;
    char *word;
    double money;
    float hhh;
} structname;

int main()
{
    printf("struct size %d bytes\n",sizeof structname);
    return 0;
}
