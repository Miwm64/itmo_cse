     ; hamming distance for acc32

    .text
    .org         0x00

_start:

    ; read first number
    load_addr    0x80
    store_addr   num1

    ; read second number
    load_addr    0x80
    store_addr   num2

    ; num1 xor num2
    load_addr    num2
    xor          num1
    store_addr   xor_value

loop:

    ; acc = current XOR value
    load_addr    xor_value

    ; if value = 0 -> finish
    beqz         finish

    ; acc = value & 1
    and          one

    ; res += acc
    add          res
    store_addr   res

    ; logical shift right by 1
    load_addr    xor_value
    shiftr       one
    and          mask
    store_addr   xor_value

    jmp          loop

finish:
    ; print result
    load_addr    res
    store_addr   0x84
    halt


    .data
.org             0x90

num1:            .word  0x00000000
num2:            .word  0x00000000
xor_value:       .word  0x00000000
one:             .word  0x00000001
mask:            .word  0x7FFFFFFF
res:             .word  0x00000000

