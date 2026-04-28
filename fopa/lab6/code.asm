ORG 0x0
V0: WORD $default, 0X180
V1: WORD $default, 0X180
V2: WORD $int2, 0X180
V3: WORD $int3, 0x180
V4: WORD $default, 0X180
V5: WORD $default, 0X180
V6: WORD $default, 0X180
V7: WORD $default, 0X180

default:
    IRET

ORG 0x19
X: WORD 0x0
TMP: WORD 0x0
TMP2: WORD 0x0
TMP3: WORD 0x0
START:
    DI
    CLA

    OUT 0x1     ; Запрет прерываний для неиспользуемых ВУ
    OUT 0x7
    OUT 0xB
    OUT 0xD
    OUT 0x11
    OUT 0x15
    OUT 0x19
    OUT 0x1D

    LD #0xB     ; Загрузка в аккумулятор MR (1000|0001=1001)
    OUT 7               ; Разрешение прерываний для 3 ВУ
    LD #0xA     ; Загрузка в аккумулятор MR (1000|0010=1010)
    OUT 5               ; Разрешение прерываний для 2 ВУ

    EI
main:
    LD X
    SUB #2
    CALL check

    ST X
    JUMP main


int2:	
    DI			; Обработка прерывания на ВУ-2
CLA
    IN 4
    ST TMP
; XOR = (X AND ~TMP) OR (~X AND TMP)

    LD TMP          ; AC = TMP
    NOT             ; AC = ~TMP
    AND X           ; AC = X AND ~TMP
    ST TMP2         ; TMP2 = X AND ~TMP

    LD X            ; AC = X
    NOT             ; AC = ~X
    AND TMP         ; AC = ~X AND TMP
    ST TMP3         ; TMP3 = ~X AND TMP

    LD TMP2         ; AC = X AND ~TMP
    OR TMP3         ; AC = (X AND ~TMP) OR (~X AND TMP) = XOR

    CALL check
    ST X            ; X = XOR
    EI
    IRET

int3: 		
    DI			; Обработка прерывания на ВУ-3
    ST TMP
    ASL
    ASL
    ASL
    SUB TMP
    NOT    
    ADD #5
    OUT 6

    CALL check
    ST X
    


    EI
    IRET


ORG 0x090
check:
check_min:
    CMP min
    BPL check_max
    JUMP load_max
check_max:
    CMP max
    BMI return
load_max:
    LD max
return:
    RET

min: WORD 0xFFEF
max: WORD 0x12 
