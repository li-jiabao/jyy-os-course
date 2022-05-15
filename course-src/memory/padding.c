#include <stdio.h>


struct{
    int a;
    char b;
    int c;
}t={ 10, 'C', 20 };

int main(){
    printf("length: %d\n", sizeof(t));
    printf("&a: %X\n&b: %X\n&c: %X\n", &t.a, &t.b, &t.c);
    return 0;
}
