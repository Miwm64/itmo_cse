     ; strstr_cstr
    .data

line_buf:        .byte  '________________________________________________________________'
input_addr:      .word  0x80
output_addr:     .word  0x84

    .text
_start:
    lui      sp, 1                           ; stack on top of the memory
    jal      ra, main
    halt
	
	.org 0x88
    ; main: read the line, split it, search, store the result
main:
    addi     sp, sp, -4
    sw       ra, 0(sp)

    addi     a0, zero, line_buf
    addi     a1, zero, 0x40                  ; the whole line must fit in 0x40
    jal      ra, read_line                   ; len = read_line(line_buf, 0x40)

    addi     t0, zero, -1
    beq      a0, t0, main_overflow           ; the line did not fit

    mv       a1, a0
    addi     a0, zero, line_buf
    jal      ra, split_line                  ; rc = split_line(line_buf, len)
    ; a1 <- index of '|' if rc == 0

    addi     t0, zero, -1
    beq      a0, t0, main_not_found          ; was no '|'
    addi     t0, zero, -2
    beq      a0, t0, main_overflow           ;did not fit into 0x20

    addi     t0, zero, line_buf
    add      a1, t0, a1
    addi     a1, a1, 1                       ; a1 = &line_buf[sep + 1] (needle)
    addi     a0, zero, line_buf              ; a0 = &line_buf[0]       (haystack)
    jal      ra, strstr_rec
    j        main_store

main_not_found:
    addi     a0, zero, -1
    j        main_store

main_overflow:
    lui      a0, 0xCCCCD                     ; addi sign extends 0xCCC to -0x334,
    addi     a0, a0, 0xCCC                   ; ->  0xCCCCCCCC

main_store:
    addi     t0, zero, output_addr
    lw       t0, 0(t0)
    sw       a0, 0(t0)

    lw       ra, 0(sp)
    addi     sp, sp, 4
    jr       ra

    ; read_line(a0 -- buffer, a1 -- capacity) -> length, or -1 if there was no '\n'
    ; among the first `capacity` symbols. The newline is eaten but not stored.
read_line:
    addi     sp, sp, -16
    sw       ra, 12(sp)
    sw       s1, 8(sp)
    sw       s2, 4(sp)
    sw       s3, 0(sp)

    mv       s1, a0
    mv       s2, a1
    addi     s3, zero, 0                     ; s3 -- how many symbols read

read_line_loop:
    bleu     s2, s3, read_line_overflow
    jal      ra, read_char

    addi     t0, zero, 10
    beq      a0, t0, read_line_end

    add      t1, s1, s3
    sb       a0, 0(t1)
    addi     s3, s3, 1
    j        read_line_loop

read_line_end:
    add      t1, s1, s3
    sb       zero, 0(t1)
    mv       a0, s3
    j        read_line_ret

read_line_overflow:
    addi     a0, zero, -1

read_line_ret:
    lw       s3, 0(sp)
    lw       s2, 4(sp)
    lw       s1, 8(sp)
    lw       ra, 12(sp)
    addi     sp, sp, 16
    jr       ra

    ; read_char() -> the next symbol of the input
read_char:
    addi     t0, zero, input_addr
    lw       t0, 0(t0)
    lw       a0, 0(t0)
    jr       ra

    ; split_line(a0 -- line, a1 -- length) -> a0 -- 0, -1 without '|', -2 if a
    ; part does not fit into 0x20 bytes together with its terminator;
    ; a1 -- index of the '|' if a0 == 0.
split_line:
    addi     t0, zero, 0                     ; t0 -- |

split_line_find:
    bleu     a1, t0, split_line_no_sep
    add      t1, a0, t0
    lb       t2, 0(t1)
    addi     t3, zero, 124
    beq      t2, t3, split_line_found
    addi     t0, t0, 1
    j        split_line_find

split_line_found:
    addi     t3, zero, 0x20
    addi     t1, t0, 1                       ; haystack length + terminator
    bgtu     t1, t3, split_line_overflow

    sub      t1, a1, t0                      ; needle length + terminator
    bgtu     t1, t3, split_line_overflow

    add      t1, a0, t0
    sb       zero, 0(t1)                     ; line[i] = '\0'

    mv       a1, t0
    addi     a0, zero, 0
    jr       ra

split_line_no_sep:
    addi     a0, zero, -1
    jr       ra

split_line_overflow:
    addi     a0, zero, -2
    jr       ra

    ; strstr_rec(a0 -- haystack, a1 -- needle) -> index, or -1.
strstr_rec:
    addi     sp, sp, -12
    sw       ra, 8(sp)
    sw       s1, 4(sp)
    sw       s2, 0(sp)

    mv       s1, a0
    mv       s2, a1

    jal      ra, match_at
    bnez     a0, strstr_rec_here

    lb       t0, 0(s1)
    beqz     t0, strstr_rec_absent           ; the haystack is over

    addi     a0, s1, 1
    mv       a1, s2
    jal      ra, strstr_rec

    addi     t0, zero, -1
    beq      a0, t0, strstr_rec_absent
    addi     a0, a0, 1
    j        strstr_rec_ret

strstr_rec_here:
    addi     a0, zero, 0
    j        strstr_rec_ret

strstr_rec_absent:
    addi     a0, zero, -1

strstr_rec_ret:
    lw       s2, 0(sp)
    lw       s1, 4(sp)
    lw       ra, 8(sp)
    addi     sp, sp, 12
    jr       ra

    ; match_at(a0 -- haystack, a1 -- needle) -> 1 if the needle is a prefix.
    ; An empty needle is a prefix of anything.
match_at:
    mv       t0, a0
    mv       t1, a1

match_at_loop:
    lb       t2, 0(t1)
    beqz     t2, match_at_yes
    lb       t3, 0(t0)
    beqz     t3, match_at_no
    bne      t2, t3, match_at_no
    addi     t0, t0, 1
    addi     t1, t1, 1
    j        match_at_loop

match_at_yes:
    addi     a0, zero, 1
    jr       ra

match_at_no:
    addi     a0, zero, 0
    jr       ra

