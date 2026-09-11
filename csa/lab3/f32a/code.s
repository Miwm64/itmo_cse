    .data
input_addr:      .word  0x80
output_addr:     .word  0x84

    .text

_start:
    @p input_addr a! @
    !p base

    @p input_addr a! @
    !p exp

    power

    @p result
    @p output_addr a! !

end:
    halt

    \ power procedure
    .org 0x100
    .data
base:            .word  0
exp:             .word  0
result:          .word  1
overflow:        .word  0
sign_neg:        .word  0
    .text

power:
    @p exp
    -if power_check

exponent_neg:
 \ if exponent < 0 -> return -1
    -1 !p result
    ;

power_check:
 \ check all special cases
    @p exp
    if exponent_zero         \ -> 1

    @p base
    if base_zero             \ -> 0

    @p base
    -1 +
    if base_one              \ -> 1

    0 !p sign_neg

    @p base
    -if base_ready

    @p base                  \ base=|base|
    inv
    1
    +
    !p base

    @p exp
    1
    and
    if base_ready

    1 !p sign_neg            \ only save negative sign if exp is odd

base_ready:
    1 !p result

power_loop:
    @p exp
    if power_done            \ exp=0 -> return

    @p exp
    1
    and
    if power_square          \ if exp[-1] = 0 -> just shift

    @p result a!             \ result -> A
    multiply
    @p overflow
    if power_mul_store       \ if result fits into 32 bits - continue
    0xCCCCCCCC !p result     \ otherwise - return error
    ;
power_mul_store:
    !p result
    check_bound              \ check if it fits with sign
    @p overflow
    if power_square
    0xCCCCCCCC !p result
    ;

power_square:
    @p exp
    2/                       \ shift exponent right
    !p exp
    @p exp
    if power_done            \ if exponent = 0 -> return

    @p base a!               \ base -> A
    multiply
    @p overflow
    if power_sq_store        \ if base fits into 32 bit - continue
    0xCCCCCCCC !p result
    ;
power_sq_store:
    !p base                  \ save new squared base

    power_loop ;

power_done:
    @p sign_neg
    if power_end
    @p result
    inv
    1
    +
    !p result
power_end:
    ;

exponent_zero:
    1 !p result
    ;

base_one:
    1 !p result
    ;

base_zero:
    0 !p result
    ;


    \ multiply: A * base
    \ overflow=1 if T!=0 (did not fit into 32 bit),otherwise overflow=0 and result in DS
multiply:
    @p base
    0

    31 >r                    \repeat 32 times
multiply_loop:
    +*
    next multiply_loop
    if mul_fits
    1 !p overflow
    drop
    ;
mul_fits:
    0 !p overflow
    drop
    a
    ;


    \ check_bound: границу берём в зависимости от sign_neg, читает/пишет result и overflow
check_bound:
    @p sign_neg
    if check_bound_pos

    @p result                \ = 0x80000000
    0x80000000
    +
    if check_bound_ok

    @p result
    0x80000000               \ >= 0x80000000
    +
    -if check_bound_bad
    0 !p overflow
    ;
check_bound_bad:
    1 !p overflow
    ;
check_bound_ok:
    0 !p overflow
    ;

check_bound_pos:
    @p result
    -if check_bound_ok       \ >= 0
    1 !p overflow
    ;

