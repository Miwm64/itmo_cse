    .data
.org             0x00
pattern_buf:     .byte  '--------------------------------'
line_buf:        .byte  '--------------------------------'
input_addr:      .word  0x80
output_addr:     .word  0x84

    .text
    .org 0x88
_start:
    i32.const pattern_buf
    i32.const read_line
    call 1, 1                                ; 0 ok / 1 overflow
    if
        i32.const output_addr
        i32.load
        i32.const 0xCCCCCCCC
        i32.store
        halt
    end

    i32.const line_buf
    i32.const read_line
    call 1, 1                                ; 0 ok / 1 overflow
    if
        i32.const output_addr
        i32.load
        i32.const 0xCCCCCCCC
        i32.store
        halt
    end

    i32.const output_addr
    i32.load
    i32.const pattern_buf
    i32.const line_buf
    i32.const match
    call 2, 1
    i32.store

    halt


; read_line(buf) -> 0 ok, 1 overflow
; locals: 0 = write ptr, 1 = char, 2 = last byte
read_line:
    locals.reserve 2
    local.get 0
    i32.const 0x1F
    i32.add
    local.set 2

    block
        loop
            i32.const input_addr
            i32.load
            i32.load
            local.tee 1
            i32.const 0x0A                   ; '\n'
            i32.eq
            br_if 1

            local.get 0
            local.get 2
            i32.ge_u
            if                               ; no room for char + terminator
                i32.const 1
                return
            end

            local.get 0
            local.get 1
            i32.store8

            local.get 0
            i32.const 1
            i32.add
            local.set 0
            br 0
        end
    end

    local.get 0
    i32.const 0
    i32.store8                               ; '\0'
    i32.const 0
    return


; match(char* p, char* t) -> 1 match, 0 no match
; locals: 0 = pattern pointer, 1 = text pointer, 2 = current char
match:
    locals.reserve 1

    ; c = *p
    local.get 0
    i32.load8_u
    local.set 2

    ; c == 0
    local.get 2
    i32.eqz
    if
        local.get 1
        i32.load8_u
        i32.eqz
        return
    end

    local.get 2
    i32.const '*'
    i32.eq
    if
        local.get 0
        i32.const 1
        i32.add
        local.get 1
        i32.const match
        call 2, 1

        if
            i32.const 1
            return
        end

        local.get 1
        i32.load8_u
        i32.eqz
        if
            i32.const 0
            return
        end

        local.get 0
        local.get 1
        i32.const 1
        i32.add
        i32.const match
        call 2, 1
        return
    end

    local.get 1
    i32.load8_u
    i32.eqz
    if
        i32.const 0
        return
    end

    local.get 2
    i32.const '?'
    i32.eq
    local.get 2
    local.get 1
    i32.load8_u
    i32.eq
    i32.or
    if
        local.get 0
        i32.const 1
        i32.add
        local.get 1
        i32.const 1
        i32.add
        i32.const match
        call 2, 1
        return
    end

    i32.const 0
    return

