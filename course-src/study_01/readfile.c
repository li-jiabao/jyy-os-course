#include <stdio.h>

void printFile(FILE *,FILE *);

int main ()
{
    FILE *fp;
    fp = fopen("F://cProject/hello.c","r");
    printFile(fp,stdout);
    return 0;
}

void printFile(FILE *ifp,FILE *ofp)
{
    int c;
    while ((c=getc(ifp))!=EOF) {
        putc(c,ofp);
    }
    fclose(ifp);
}
