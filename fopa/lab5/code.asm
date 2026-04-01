ORG 0x357
N:      WORD    0x56B
LEN:    WORD    ?

START:  CLA        
; load len     
        LD        (N)    
        INC
        BEQ     STOP
        BMI     STOP
        ST      LEN     

S2:     IN      7    ; second byte
        AND     #0x40
        BEQ     S2      
        LD      (N)+    
        OUT     6      

        LOOP    LEN
        JUMP    S1  
        JUMP    STOP

S1:     IN      7   ; first byte
        AND     #0x40
        BEQ     S1      
        LD      (N)     
        SWAB          
        OUT     6     

        LOOP    LEN   
        JUMP    S2     
STOP:   
HLT 

ORG 0x56B
S:      WORD    0x000C
VALUES: WORD    0xCFCE, 0xD1C5, 0xD9C0, 0xC5CC, 0xCED1, 0xD2DC
