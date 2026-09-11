    .data

input_addr: .word 0x80
output_addr: .word 0x84

	.data
test: .word 0
    .text

_start:
	@p input_addr a! @ \ read first - load input addr, put in A, then write to DS 
	!p base

	@p input_addr a! @ \ read second
	!p exp

	power 

	@p result \ load result to top of DS
	@p output_addr a! ! \ output result - load output result, put in A, then write to mem[A] 


end:
    halt


.org 0x100
\ procedure
    .data
base: .word 0
exp: .word 0
result: .word 1

	.text

power:
power_check:
	@p exp
	if exponent_zero
	
	@p base
	if base_zero

	@p base
	-1 +
	if base_one 

power_do:	
	@p exp
	-1
	+
	
	
	>r	

	power_loop ;	

exponent_zero:
	1 !p result
	;
	
base_one:
	1 !p result
	;

base_zero:
	0 !p result
	;

power_loop:
	multiply
	!p result

	next power_loop
	;


multiply:
    @p result
    a!

    @p base
    0

    31 >r

multiply_loop:
    +*
    next multiply_loop
    drop
	drop
	a
    ;
