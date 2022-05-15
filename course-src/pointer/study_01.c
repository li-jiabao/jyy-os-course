#include <stdio.h>

struct Pointer {
    int x,y,z;
};

void printPandPP()
{
    char a[8] = "hello";
    /* 强制类型转换是不会报错的，但是指针的移动会按照指针类型的大小来移动位置 */
    int *ptr = (int *)a;
    /* 指针容易出错正是由于这样的灵活性，指针地址实际上越界访问其他的地址内容 */
    printf("%c\n",*(ptr+7));
    char arr[20] = "hello world!";
    char *p = arr;
    char **pp = &p;
    printf("p=%x\n",p);
    printf("pp=%x\n",pp);
    printf("*p=%c\n",*p);
    printf("**p=%c\n",*(++*pp));
}

void printPointerDetail()
{
    int *ip;
    char *cp;
    double *dp;
    float *fp;
    struct Pointer *pp;
    printf("intPointer=%d  charPointer=%d  doublePointer=%d  floatPointer=%d  structPointer=%d\n",ip,cp,dp,fp,pp);
}


int main(int argc,char *argv[])
{
    void *p;
    // printPointerDetail();
    // sizeof是用来测试对象类型或者某个对象占据的内存大小
    printf("void Pointer size=%d",sizeof(p));
}
