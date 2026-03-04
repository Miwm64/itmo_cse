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


102 0200
103 EE19
104 AE15
105 0740
106 0C00
107 D6FA
108 0800
109 6E13
10A EE12
10B AE0F
10C 0C00
10D D6FA
10E 0800
10F 0740
110 4E0C
111 EE0B
112 AE09
113 0700
114 0C00
115 D6FA
116 0800
117 6E05
118 EE04
119 0100
11A ZZZZ
11B YYYY
11C XXXX
11D 0FA2


6FA: AC01
6FB: F204
6FC: F003
6FD: 7E0A
6FE: F006
6FF: F805
700: 0500
701: 0500
702: 6C01
703: 6E05
704: CE01
705: AE02
706: EC01
707: 0A00
708: 0E3C
709: 00B1