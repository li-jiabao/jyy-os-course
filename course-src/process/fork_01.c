#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc,char* argv[])
{
    printf("hello,my pid :{%d}\n",(int)getpid());
    pid_t rc = fork();
    if (rc < 0) {
        fprintf(stderr,"fork create fail\n");
        exit(1);
    }else if (rc == 0) {
        printf("hello, i am child process, my pid :{%d}\n",(int)rc);
    }else {
        printf("hello, i am process {%d}'s parent process\n,my pid: {%d}",(int)rc,(int)getpid());
    }
    return 0;
}
