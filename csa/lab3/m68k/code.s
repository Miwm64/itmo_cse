	.data
	.org 0x100
; D0-D2, A0-A1 caller saved
; D3-D7, A0-A7 callee saved
input_address: .word 0x80
output_address: .word 0x84
stack_top:       .word  0x500     

.text
_start:
	; stack init
	movea.l  stack_top, A7
    movea.l  (A7), A7
	
	movea.l input_address, A0
	movea.l (A0), A0
	movea.l line_buffer, A1
	jsr read_line
	
	movea.l line_buffer, A0
	jsr count_words
	movea.l count_array, A0
	movea.l output_address, A1
	movea.l (A1), A1
	move.l 3, D0
	jsr print_result
	
	halt

; read_line(input_address, buffer_address) -> int
; arg A0 - input address
; arg A1 - buffer address
; ret D0 - status/len 
; reads line into buffer
read_line:
	xor.l D0, D0
	xor.l D1, D1
read_loop:
	jsr read_char
	cmp.b 0x0, D0 ; null
	beq read_done
	cmp.b 0xA, D0 ; newline
	beq read_done

	move.b D0, (A1)+
	add.l 0x1, D1
	jmp read_loop 
read_done:
	move.l D1, D0
	rts

; read_char(input_address) -> int
; arg A0 - input_address
; ret D0 - char/status
; reads single char input
; returns 0 if EOF
read_char:
	move.b (A0), D0
	rts


	.text
	.org 0x200
; count_words(buffer_address) -> amount of unique words, address of count_array
; arg A0 - buffer address
; ret D0 - status/amount
; ret A0 - address of count_array
; counts amounts of unique word occurences
; if any length of word > 3 -> ret -1	
count_words:
	




	rts

; print_result(length, array_address, output_address) -> void
; arg A0 - array address
; arg A1 - output_address
; arg D0 - length of array
; prints array with spaces
print_result:
print_loop:
	cmp.l 0, D0
	beq print_ret
	move.b (A0)+, (A1)
	move.b ' ', (A1)
	sub.l 1, D0
	jmp print_loop
print_ret:
	rts


	.data
	.org 0x360
	word_array: .word 0x1 
	.data
	.org 0x390
	count_array: .byte 0x1
	.data
	.org 0x400
line_buffer: .byte '_'
