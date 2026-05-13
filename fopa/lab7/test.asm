
ORG  0x460
RESULT: WORD 0x0

CHECK1: WORD 0x0
CHECK2: WORD 0x0
CHECK3: WORD 0x0

RES1: WORD 0x0154
RES2: WORD 0x68AC
RES3: WORD 0x8000

ARG1: WORD 0x00AA
ARG2: WORD 0xAA

ARG3: WORD 0x1234
ARG4: WORD 0x5678

ARG5: WORD 0x7FFF
ARG6: WORD 0x0001

ORG  0x478
START:  CALL TEST1
        CALL TEST2
        CALL TEST3
        LD #0x1
        AND CHECK1
        AND CHECK2
        AND CHECK3
        ST RESULT
STOP:   HLT 

TEST1:  LD ARG1
        PUSH
        LD ARG2
        PUSH
        LD #0x77
        WORD 0x0F03 ; ADDSP
        BMI ERROR1
        BEQ ERROR1
        BHIS ERROR1
        BVS ERROR1
        CMP #0x77
        BNE ERROR1
        POP
        ST CHECK1
        CMP RES1
        BEQ DONE1
ERROR1: POP
        POP
        CLA
        RET
DONE1:  POP 
        POP 
        LD #0x1
        ST CHECK1
        CLA 
        RET 

TEST2:  LD ARG3
        PUSH
        LD ARG4
        PUSH
        LD #0x77
        WORD 0x0F03 ; ADDSP
        BMI ERROR2
        BEQ ERROR2
        BHIS ERROR2
        BVS ERROR2
        CMP #0x77
        BNE ERROR2
        POP
        ST CHECK2
        CMP RES2
        BEQ DONE2
ERROR2: POP
        POP
        CLA
        RET
DONE2:  POP 
        POP 
        LD #0x1
        ST CHECK2
        CLA 
        RET 

TEST3:  LD ARG5
        PUSH
        LD ARG6
        PUSH
        LD #0x77
        WORD 0x0F03 ; ADDSP
        BPL ERROR1
        BEQ ERROR1
        BHIS ERROR1
        BVC ERROR1
        CMP #0x77
        BNE ERROR3
        POP
        ST CHECK3
        CMP RES3
        BEQ DONE3
ERROR3: POP
        POP
        CLA
        RET
DONE3:  POP 
        POP 
        LD #0x1
        ST CHECK3
        CLA 
        RET  
