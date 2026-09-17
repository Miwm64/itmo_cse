    .data

.org             0x0

result_buffer:   .byte  '________________________________________________________________'



    .data

.org             0x100

    ; D0-D2, A0-A2 caller saved

    ; D3-D7, A3-A7 callee saved

input_address:   .word  0x80

output_address:  .word  0x84

stack_top:       .word  0x600



    .text

_start:
    ; stack init
    movea.l  stack_top, A7
    movea.l  (A7), A7

    ; call read_line
    movea.l  input_address, A0
    movea.l  (A0), A0
    movea.l  line_buffer, A1
    jsr      read_line

    ; call count_words
    movea.l  line_buffer, A0
    jsr      count_words

    movea.l  output_address, A1
    movea.l  (A1), A1

    cmp.l    0, D0
    bmi      print_error
    movea.l  result_buffer, A2
    jsr      print_save_result

    halt


print_error:
    move.l   -1, D0
    move.l   D0, (A1)
    halt


read_line:
    xor.l    D0, D0
    xor.l    D1, D1

read_loop:
    jsr      read_char
    cmp.b    0x0, D0                         ; null
    beq      read_done
    cmp.b    0xA, D0                         ; newline
    beq      read_done

    move.b   D0, (A1)+
    add.l    0x1, D1
    jmp      read_loop

read_done:
    move.l   D1, D0
    rts


read_char:
    move.b   (A0), D0
    rts



    .text

    .org     0x200

    ; count_words(buffer_address, size) -> amount of unique words, address of count_array
    ; arg A0 - buffer address
    ; arg D0 - size of array
    ; ret D0 - status/amount
    ; ret A0 - address of count_array
    ; counts amounts of unique word occurences
    ; if any length of word > 3 -> ret -1
count_words:
    ; current word - D0
    ; curr char - D1
    ; symbols left - D7
    ; unique words - D6
    move.l   D7, -(A7)
    move.l   D6, -(A7)
    move.l   D0, D7
    xor.l    D0, D0
    xor.l    D1, D1
    xor.l    D6, D6

count_words_loop:
    cmp.l    0, D7
    beq      last_word                       ; if symbols ended -> process ramain

    move.b   (A0)+, D1                       ; load another symbol
    sub.l    1, D7

    ; if newline -> process word
    cmp.b    ' ' , D1
    beq      call_process_word
    cmp.b    '.' , D1
    beq      call_process_word
    cmp.b    ',' , D1
    beq      call_process_word

    ; if another character -> add it
    lsl.l    8, D0
    add.b    D1, D0

    ; if word size > 3 -> return -1
    cmp.l    0xFFFFFF, D0
    bgt      too_long

    jmp      count_words_loop                ; just a normal char was added to D0 above - keep accumulating

call_process_word:
    jsr      process_word
    cmp.l    -1, D0
    beq      too_long                        ; 13th unique word - abort like an over-long word does
    jmp      count_words_loop

last_word:
    ; if word size > 3 -> return -1
    cmp.l    0xFFFFFF, D0
    bgt      too_long

    jsr      process_word                    ; count whatever's left in D0 (no-op if line ended on a separator)
    jmp      done

too_long:
    move.l   -1, D0

done:
    cmp.l    -1, D0
    beq      count_words_ret
    move.l   D6, D0                          ; report the unique-word count, like the header promises

count_words_ret:
    movea.l  count_array, A0
    move.l   (A7)+, D6
    move.l   (A7)+, D7
    rts


    ; process_word(word) -> status
    ; arg D0 - packed word (up to 3 chars in the low bytes), 0 = empty word (skip)
    ; ret D0 - status: 0 = ok, -1 = would be a 13th unique word
    ; uses/updates D6 - count of unique words so far (persists across calls)
    ; scratch: D1, D2, A1, A2 (caller-saved, not restored)
process_word:
    cmp.l    0, D0
    beq      process_word_ok                 ; empty word (e.g. two separators in a row) -> nothing to do

    movea.l  word_array, A1                  ; A1 -> word_array[0]
    movea.l  count_array, A2                 ; A2 -> count_array[0]
    xor.l    D2, D2                          ; D2 = index into known words

process_word_search:
    cmp.l    D6, D2
    beq      process_word_new                ; checked every known word, no match

    move.l   (A1)+, D1                       ; load word_array[D2], A1 -> word_array[D2+1]
    cmp.l    D1, D0
    beq      process_word_found              ; A2 is still at count_array[D2] - not advanced yet

    move.b   (A2)+, D1                       ; not this one - advance A2 -> count_array[D2+1] too
    add.l    1, D2
    jmp      process_word_search

process_word_found:
    move.b   (A2), D1
    add.b    1, D1
    move.b   D1, (A2)
    jmp      process_word_ok

process_word_new:
    cmp.l    12, D6
    beq      process_word_full

    move.l   D0, (A1)
    move.b   1, (A2)
    add.l    1, D6

process_word_ok:
    xor.l    D0, D0
    rts

process_word_full:
    move.l   -1, D0
    rts


    ; print_result(length, array_address, output_address, buffer_address) -> void
    ; arg A0 - array address
    ; arg A1 - output_address
    ; arg A2 - buffer address
    ; arg D0 - length of array
    ; prints array with spaces
print_save_result:

print_save_loop:
    cmp.l    0, D0
    beq      print_save_ret
    move.b   (A0)+, D1
    add.b    '0' , D1
    move.b   D1, (A1)
    move.b   D1, (A2)+

    sub.l    1, D0
    cmp.l    0, D0
    beq      print_save_ret
    move.b   ' ' , (A1)
    move.b   ' ' , (A2)+
    jmp      print_save_loop

print_save_ret:
    move.b   0, (A2)                         ; C-string terminator
    rts



    .data

.org             0x460

word_array:      .word  0x1

    .data

.org             0x490

count_array:     .byte  0x1

    .data

.org             0x500

line_buffer:     .byte  '_'

