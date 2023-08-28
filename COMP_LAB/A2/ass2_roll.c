#include "myl.h"

#define BUFF 50


int printStr(char* s){
    int bytes=0;
    while(s[bytes]!='\0')bytes++;  
    
    __asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(s), "d"(bytes)
    );
    return bytes; // return the length
}

int printInt(int n){
    char buff[BUFF], zero='0';
    int j, k, bytes;
    int i=0;
    if(n==0){
        buff[i++]=zero;
    }
    else {
        if(n<0){
            buff[i++]='-';
            n= -n;
        }
        while(n){
            int dig=n%10;
            buff[i++] = (char)(zero+dig);
            n /= 10;
        }
        if(buff[0]=='-') j=1;
        else j=0;
        k = i-1;
        while(j<k){
            char temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
    }
    buff[i]='\n';
    bytes = i+1;
    int result=0;
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :"=a"(result)
        :"S"(buff), "d"(bytes)
    );
    if(result==bytes){
        return bytes;
    }
    return ERR;
}

int printFlt(float f){

    char buff[BUFF], zero='0';
    int j, k, bytes;
    int i=0;
    if(f==0.0){
        buff[i++]=zero;
    }
    else {
        if(f<0.0){
            buff[i++]='-';
            f= -f;
        }
        int n=(int) f;
        float p = f-n;
        if(n==0) {
            buff[i++] = zero;
        }
        while(n){
            int dig=n%10;
            buff[i++] = (char)(zero+dig);
            n /= 10;
        }
        if(buff[0]=='-') j=1;
        else j=0;
        k = i-1;
        while(j<k){
            char temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
        buff[i++]='.';
        while(p>0.0){
            p = p*10.0;
            int y = (int) p;
            int dig = y%10;
            buff[i++]= (char)(zero+dig);
            p = p-y;
        }
        buff[i++] = zero;

    }
    buff[i]='\n';
    bytes = i+1;
    int result=0;
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :"=a"(result)
        :"S"(buff), "d"(bytes)
    );
    if(result==bytes){
        return bytes;
    }
    return ERR;

}

int readInt(int *n) {
    char buff[BUFF] = {'0'}; // Initialize buff array to zeros
    int bytes = 0;
    
    while (1) {
        asm (
            "movq $0, %%rax;"
            "movq $0, %%rdi;"
            "syscall;"
            : "=a"(bytes)
            : "S"(buff), "d"(BUFF)
        );

        if (bytes <= 1) {   
            return ERR;     //reading failed
        }

        int i = 0;
        int flag=0;
        // while(i<bytes && (buff[i]<'0' || buff[i]>'9')) {
        //     if(buff[i]=='-') break;
        //     i++;
        // }
        // if(buff[i]=='-') i--;
        while(i<bytes && (buff[i]<'0' || buff[i]>'9' || buff[i]=='-')) {
            if(buff[i]=='-') flag=1;
            i++;
        }
        if(flag==1) i--;

        if (i < bytes) {
            // Found a valid character, start parsing the integer
            int negative = 0;
            int num = 0;

            if (buff[i] == '-') {
                negative = 1;
                i++;
            }

            while (i < bytes && buff[i] >= '0' && buff[i] <= '9') {
                num = num * 10 + (buff[i] - '0');
                i++;
            }

            *n = (negative ? -num : num);
            return OK; // Successfully read an integer
        }
    }
}


int readFlt(float *n) {
    char buff[BUFF]={'0'};
    int bytes = 0;

    while (1) {
        asm (
            "movq $0, %%rax;"
            "movq $0, %%rdi;"
            "syscall;"
            : "=a"(bytes)
            : "S"(buff), "d"(BUFF)
        );

        if (bytes <= 1) {
            return ERR; // Reading failed
        }

        int i = 0;
        int flag = 0;
        int floatflag = 0;
        while (i < bytes && (buff[i] < '0' || buff[i] > '9' || buff[i] == '-')) {
            if (buff[i] == '-') flag = 1;
            if(buff[i]=='.') break;
            i++;
        }
        if (flag == 1) i--;
        
        if (i < bytes) {
            // Found a valid character, start parsing the float
            int negative = 0;
            float num = 0.0;
            float divisor = 1.0; // For decimal part

            if (buff[i] == '-') {
                negative = 1;
                i++;
            }
            
            while (i < bytes && ((buff[i] >= '0' && buff[i] <= '9') || buff[i] == '.')) {
                if (buff[i] == '.') {
                    floatflag = 1;
                } else {
                    if (floatflag==1) {
                        divisor *= 10.0;
                        num += (buff[i] - '0') / divisor;
                    } else {
                        num = num * 10.0 + (buff[i] - '0');
                    }
                }
                i++;
            }

            *n = (negative ? -num : num);
            return OK; // Successfully read a floating-point number
        }
    }
}
