; strstr_cstr -- find a substring inside a C string.

    .text

_start:
    lui      sp, 1                           ; sp = 0x1000, the stack grows down
    jal      ra, main
    halt

    .data

input_addr:      .word  0x80               ; Input port
output_addr:     .word  0x84               ; Output port

    ; Skip past the memory mapped IO range (0x80..0x87).
    .text
    .org     0x0

    ;; -----------------------------------------------------------------------
    ;; main() -- read the line, split it, report the index
    ;; -----------------------------------------------------------------------

main:
    addi     sp, sp, -4
    sw       ra, 0(sp)

    addi     a0, zero, line_buf              ; int len = read_line(line_buf, 0x40);
    addi     a1, zero, 0x40
    jal      ra, read_line

    addi     t0, zero, -1
    beq      a0, t0, main_overflow           ; if (len == -1) goto overflow;

    mv       a1, a0                          ; int rc = split_line(line_buf, len);
    addi     a0, zero, line_buf
    jal      ra, split_line

    addi     t0, zero, -1
    beq      a0, t0, main_not_found          ; if (rc == -1) goto not_found;
    addi     t0, zero, -2
    beq      a0, t0, main_overflow           ; if (rc == -2) goto overflow;

    addi     a0, zero, hay_buf               ; result = strstr_rec(hay_buf, ndl_buf);
    addi     a1, zero, ndl_buf
    jal      ra, strstr_rec
    j        main_store

main_not_found:
    addi     a0, zero, -1
    j        main_store

main_overflow:
    lui      a0, 0xCCCCD                     ; a0 = 0xCCCCD000
    addi     a0, a0, 0xCCC                   ; a0 = 0xCCCCD000 - 0x334 = 0xCCCCCCCC

main_store:
    lui      t0, %hi(output_addr)
    addi     t0, t0, %lo(output_addr)
    lw       t0, 0(t0)                       ; t0 = output port address
    sw       a0, 0(t0)                       ; *output_addr = result;

    lw       ra, 0(sp)
    addi     sp, sp, 4
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; read_line(a0 -- buffer, a1 -- capacity) -> a0 -- length, or -1
    ;;
    ;; Reads symbols until '\n'. The newline is consumed but not stored, the
    ;; buffer is closed with a zero byte. If `capacity` symbols have been read
    ;; and none of them was '\n', the line does not fit: exactly `capacity`
    ;; symbols are consumed and -1 is returned.
    ;; -----------------------------------------------------------------------

read_line:
    addi     sp, sp, -16
    sw       ra, 12(sp)
    sw       s1, 8(sp)
    sw       s2, 4(sp)
    sw       s3, 0(sp)

    mv       s1, a0                          ; s1 -- buffer
    mv       s2, a1                          ; s2 -- capacity
    addi     s3, zero, 0                     ; s3 -- count

read_line_loop:
    bleu     s2, s3, read_line_overflow      ; while (count < capacity) {
    jal      ra, read_char                   ;     int c = read_char();

    addi     t0, zero, 10
    beq      a0, t0, read_line_done          ;     if (c == '\n') break;

    add      t1, s1, s3
    sb       a0, 0(t1)                       ;     buffer[count] = c;
    addi     s3, s3, 1                       ;     count++;
    j        read_line_loop                  ; }

read_line_done:
    add      t1, s1, s3
    sb       zero, 0(t1)                     ; buffer[count] = '\0';
    mv       a0, s3                          ; return count;
    j        read_line_return

read_line_overflow:
    addi     a0, zero, -1                    ; return -1;

read_line_return:
    lw       s3, 0(sp)
    lw       s2, 4(sp)
    lw       s1, 8(sp)
    lw       ra, 12(sp)
    addi     sp, sp, 16
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; read_char() -> a0 -- the next symbol of the input
    ;; -----------------------------------------------------------------------

read_char:
    lui      t0, %hi(input_addr)
    addi     t0, t0, %lo(input_addr)
    lw       t0, 0(t0)                       ; t0 = input port address
    lw       a0, 0(t0)                       ; return *input_addr;
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; split_line(a0 -- line, a1 -- length)
    ;;     -> a0 -- 0 on success, -1 without a '|', -2 on buffer overflow
    ;;
    ;; Splits the line by the first '|' into hay_buf and ndl_buf. Each part
    ;; plus its terminator must fit into a 0x20 byte buffer.
    ;; -----------------------------------------------------------------------

split_line:
    addi     sp, sp, -20
    sw       ra, 16(sp)
    sw       s1, 12(sp)
    sw       s2, 8(sp)
    sw       s3, 4(sp)
    sw       s4, 0(sp)

    mv       s1, a0                          ; s1 -- line
    mv       s2, a1                          ; s2 -- length
    addi     s3, zero, 0                     ; s3 -- separator index

split_line_find:
    bleu     s2, s3, split_line_no_sep       ; while (i < length) {
    add      t1, s1, s3
    lb       t0, 0(t1)
    addi     t2, zero, 124
    beq      t0, t2, split_line_found        ;     if (line[i] == '|') break;
    addi     s3, s3, 1                       ;     i++;
    j        split_line_find                 ; }

split_line_found:
    addi     t0, zero, 0x20
    addi     t1, s3, 1                       ; haystack length + terminator
    bgtu     t1, t0, split_line_overflow

    sub      s4, s2, s3
    addi     s4, s4, -1                      ; s4 -- needle length
    addi     t1, s4, 1                       ; needle length + terminator
    bgtu     t1, t0, split_line_overflow

    addi     a0, zero, hay_buf               ; copy_cstr(hay_buf, line, i);
    mv       a1, s1
    mv       a2, s3
    jal      ra, copy_cstr

    addi     a0, zero, ndl_buf               ; copy_cstr(ndl_buf, line + i + 1,
    add      a1, s1, s3                      ;           needle length);
    addi     a1, a1, 1
    mv       a2, s4
    jal      ra, copy_cstr

    addi     a0, zero, 0                     ; return 0;
    j        split_line_return

split_line_no_sep:
    addi     a0, zero, -1                    ; return -1;
    j        split_line_return

split_line_overflow:
    addi     a0, zero, -2                    ; return -2;

split_line_return:
    lw       s4, 0(sp)
    lw       s3, 4(sp)
    lw       s2, 8(sp)
    lw       s1, 12(sp)
    lw       ra, 16(sp)
    addi     sp, sp, 20
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; copy_cstr(a0 -- destination, a1 -- source, a2 -- count)
    ;;
    ;; Copies `count` bytes and closes the destination with a zero byte.
    ;; -----------------------------------------------------------------------

copy_cstr:
    addi     t0, zero, 0                     ; t0 -- i

copy_cstr_loop:
    bleu     a2, t0, copy_cstr_done          ; while (i < count) {
    add      t1, a1, t0
    lb       t2, 0(t1)
    add      t3, a0, t0
    sb       t2, 0(t3)                       ;     destination[i] = source[i];
    addi     t0, t0, 1                       ;     i++;
    j        copy_cstr_loop                  ; }

copy_cstr_done:
    add      t3, a0, t0
    sb       zero, 0(t3)                     ; destination[count] = '\0';
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; strstr_rec(a0 -- haystack, a1 -- needle) -> a0 -- index, or -1
    ;;
    ;; strstr_rec(h, n) = 0                       , if n is a prefix of h
    ;;                  = -1                      , if *h == '\0'
    ;;                  = -1                      , if strstr_rec(h + 1, n) < 0
    ;;                  = strstr_rec(h + 1, n) + 1, otherwise
    ;; -----------------------------------------------------------------------

strstr_rec:
    addi     sp, sp, -12
    sw       ra, 8(sp)
    sw       s1, 4(sp)
    sw       s2, 0(sp)

    mv       s1, a0                          ; s1 -- the haystack tail
    mv       s2, a1                          ; s2 -- the needle

    jal      ra, match_at                    ; if (match_at(h, n))
    bnez     a0, strstr_rec_here             ;     return 0;

    lb       t0, 0(s1)                       ; if (*h == '\0')
    beqz     t0, strstr_rec_absent           ;     return -1;

    addi     a0, s1, 1                       ; int r = strstr_rec(h + 1, n);
    mv       a1, s2
    jal      ra, strstr_rec

    addi     t0, zero, -1                    ; if (r == -1)
    beq      a0, t0, strstr_rec_absent       ;     return -1;

    addi     a0, a0, 1                       ; return r + 1;
    j        strstr_rec_return

strstr_rec_here:
    addi     a0, zero, 0                     ; return 0;
    j        strstr_rec_return

strstr_rec_absent:
    addi     a0, zero, -1                    ; return -1;

strstr_rec_return:
    lw       s2, 0(sp)
    lw       s1, 4(sp)
    lw       ra, 8(sp)
    addi     sp, sp, 12
    jr       ra

    ;; -----------------------------------------------------------------------
    ;; match_at(a0 -- haystack, a1 -- needle) -> a0 -- 1 if n is a prefix of h
    ;;
    ;; An empty needle is a prefix of any string.
    ;; -----------------------------------------------------------------------

match_at:
    mv       t0, a0                          ; t0 -- the haystack cursor
    mv       t1, a1                          ; t1 -- the needle cursor

match_at_loop:
    lb       t2, 0(t1)
    beqz     t2, match_at_yes                ; the needle is over -- matched
    lb       t3, 0(t0)
    beqz     t3, match_at_no                 ; the haystack is over -- no match
    bne      t2, t3, match_at_no
    addi     t0, t0, 1
    addi     t1, t1, 1
    j        match_at_loop

match_at_yes:
    addi     a0, zero, 1                     ; return 1;
    jr       ra

match_at_no:
    addi     a0, zero, 0                     ; return 0;
    jr       ra

    .data

    ; The buffers are pre filled so that every cell is initialized; '_' marks
    ; the unused tail in the memory dump.
line_buf:        .byte  '________________________________________________________________'
hay_buf:         .byte  '________________________________'
ndl_buf:         .byte  '________________________________'
