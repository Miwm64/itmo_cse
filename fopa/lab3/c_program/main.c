#include <stdio.h>


int func(const int arr[], int n){
    int res = 0;
    for (int i = 0; i < n; ++i) {
        res = res << 1;

        if (arr[i] % 2 == 1){
            continue;
        }
        if (arr[i] % 4 != 2){
            res += 1;
        }
    }
    return res;
}

int main(void) {
    const int len = 14;
    int arr[len];
    int start = 2;
    for (int i = 0; i < len; ++i) {
        arr[i] = start;
        ++start;
    }
    int res = func(arr, len);
    printf("%d\n", res);
    return 0;
}

