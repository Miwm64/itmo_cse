ORG 0x10
arr_len: WORD 0x5
arr: WORD 0x1, 0x3, 0x2,  0x4, 0x2
arr_start: WORD $arr

ORG 0x30
START: 
   CLA
   LD arr_start
   PUSH
   LD arr_len
   PUSH 
   CALL $bubble_sort
   POP
   HLT

ORG 0x600
bubble_sort:
; --- Initialize vars ---
    POP
    ST ret_addr
    POP
    ST loc_arr_len 
    POP
    ST loc_arr_start
    CLA
    ST i

outer_loop:
    LD i
    CMP loc_arr_len
    BMI continue_outer
    JUMP end_sort

continue_outer:
    CLA
    ST j

inner_loop:
    LD j
    INC
    CMP loc_arr_len
    BMI continue_inner
    JUMP next_i

continue_inner:
; --- get curr address ---
    LD loc_arr_start
    ADD j
    ST curr_addr
    
; --- get curr element ---
    LD (curr_addr)
    ST a

; --- get curr_address+1 and element in +1 --- 
    LD curr_addr
    INC
    ST curr_addr1
    LD (curr_addr1)
    ST b
 
    ; if a <= b skip swap
    LD a
    CMP b
    BMI no_swap
    BEQ no_swap

; --- swap ---
    LD b
    ST (curr_addr)

    LD a
    ST (curr_addr1)


no_swap:
    ; j++
    LD j
    INC
    ST j
    JUMP inner_loop

next_i:
    ; i++
    LD i
    INC
    ST i
    JUMP outer_loop

end_sort:
    LD ret_addr
    PUSH
    RET

loc_arr_len: WORD ?
loc_arr_start: WORD ?
i:        WORD 0
j:        WORD 0
base:     WORD 0
a:        WORD 0
b:        WORD 0
curr_addr:   WORD 0
curr_addr1:  WORD 0
ret_addr: WORD 0
