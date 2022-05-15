#ifdef RUNTIME
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

/* malloc 的包装函数 */
void *mymalloc(size_t size)
{
    void *(*mallocp)(size_t size);
    char *error;

    // 从libc中获取malloc函数符号
    mallocp = dlsym(RLTD_NEXT,"malloc");
    if ((error=dlerror())!=NULL) {
        fputs(error,stderr);
        exit(1);
    }
    void *ptr = mallocp(size);
    printf("分配内存，现在正在包装函数中执行，分配大小%d,分配的指针%p\n",(int)size,ptr);
    return ptr;
}

/* free 的包装函数 */
void myfree(void *ptr)
{
    void (*freep)(void *ptr)=NULL;
    if (ptr!=NULL) {
        return;
    }

    freep = dlsym(RTLD_NEXT,"free");
    if ((error=dlerror())!=NULL) {
        fputs(error,stderr);
        exit(1);
    }
    freep(ptr);
    printf("释放内存，现在正在包装函数中执行，释放的指针%p\n",ptr);
}
#endif
