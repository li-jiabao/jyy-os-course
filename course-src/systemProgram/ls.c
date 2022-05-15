//
// Created by jiabao on 2022/4/17.
//
#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>

void isdir();
void do_ls(char *dirname);

int main()
{
    char *dirname;
    do_ls(dirname);
}

void do_ls(char *dirname)
{
    DIR *dir;
    struct dirent *direntp;
    char filepath[200];
    struct stat statinfo;
    if ((dir=opendir(dirname))==NULL)
        fprintf(stderr,"cannot open dir: %s\n",dirname);
    while ((direntp=readdir(dir))!=NULL) {
        int left=0,right=0;
        while ((filepath[left]=dirname[right])!='\0'){
            left++;
            right++;
        }
        filepath[left++]='/';
        right=0;
        while ((filepath[left]=direntp->d_name[right])!='\0') {
            left++;
            right++;
        }
        filepath[left]='\0';
        stat(filepath,&statinfo);
        if (S_ISDIR(stat.st_mode)) {
            printf(RED"%s "NONE,direntp->d_name)
        }else {
            printf("%s\n",direntp->d_name);
        }
    }
}
