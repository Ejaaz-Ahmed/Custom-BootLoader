BITS 16
start:
    ; Initialize segments and stack more efficiently
    mov ax, 07C0h
    mov ds, ax
    mov ss, ax
    mov sp, 4096
    mov ax, 3
    int 10h

display_credits:
    xor bh, bh
    mov cx, 1
    mov si, credit_data

.next_line:
    lodsb
    test al, al
    jz main_menu
    
    mov dh, al
    lodsb
    mov dl, al
    lodsb
    mov bl, al
    
    mov ah, 02h
    int 10h
    
.print_string:
    lodsb
    test al, al
    jz .next_line
    
    mov ah, 09h
    or bl, 08h
    int 10h
    
    inc dl
    mov ah, 02h
    int 10h
    jmp .print_string

main_menu:
    mov si, menu_text
    call print_centered
    
.menu_loop:
    mov ah, 0
    int 16h
    
    cmp al, '1'
    je show_pattern
    cmp al, '2'
    je show_time
    cmp al, '3'
    je show_rainbow
    cmp al, 'q'
    je reboot
    jmp .menu_loop

show_pattern:
    mov ax, 3
    int 10h
    call animated_pattern
    jmp main_menu

show_time:
    mov ax, 3
    int 10h
    
    mov ah, 02h
    int 1Ah
    
    mov al, ch
    call print_hex
    mov al, ':'
    call print_char
    mov al, cl
    call print_hex
    
    mov ah, 0
    int 16h
    jmp main_menu

show_rainbow:
    mov ax, 3
    int 10h
    mov cx, 15
    mov dl, 32
    mov dh, 12
.rainbow_loop:
    push cx
    mov ah, 02h
    mov bh, 0
    int 10h
    
    mov ah, 09h
    mov al, '*'
    mov bl, cl
    or bl, 08h
    mov cx, 1
    int 10h
    
    pop cx
    inc dl
    loop .rainbow_loop
    
    mov ah, 0
    int 16h
    jmp main_menu

animated_pattern:
    mov byte [pattern_color], 9
    mov byte [animation_counter], 0

.animation_loop:
    mov ah, 1
    int 16h
    jnz .done
    
    mov ax, 3
    int 10h

    mov cx, 5
    mov byte [current_row], 10
    
.row_loop:
    push cx
    call draw_pattern_row
    inc byte [current_row]
    pop cx
    loop .row_loop
    
    inc byte [pattern_color]
    and byte [pattern_color], 0Fh
    
    inc byte [animation_counter]
    
    mov cx, 0x1FFF
.delay:
    loop .delay
    
    jmp .animation_loop

.done:
    mov ah, 0
    int 16h
    ret

draw_pattern_row:
    mov cx, 20
    mov dl, 30
    mov dh, [current_row]
    mov bl, [pattern_color]
    or bl, 08h

.pattern_loop:
    push cx
    
    mov ah, 02h
    mov bh, 0
    int 10h
    
    mov ah, 09h
    mov al, '0'
    
    mov bl, [pattern_color]
    add bl, cl
    and bl, 0Fh
    or bl, 08h
    
    mov al, '0'
    test cl, 1
    jz .skip
    mov al, '1'
.skip:
    xor al, [animation_counter]
    and al, 1
    add al, '0'
    
    mov cx, 1
    int 10h
    
    pop cx
    inc dl
    loop .pattern_loop
    
    ret

print_hex:
    push ax
    shr al, 4
    call print_hex_digit
    pop ax
    and al, 0Fh
    
print_hex_digit:
    add al, '0'
    cmp al, '9'
    jle .print
    add al, 7
.print:
    call print_char
    ret

print_char:
    mov ah, 0Eh
    int 10h
    ret

print_centered:
    mov ah, 0Eh
.loop:
    lodsb
    test al, al
    jz .done
    int 10h
    jmp .loop
.done:
    ret

reboot:
    int 19h

credit_data:
    db 8, 30, 0Eh, 'EA_OS: Project Mentazzy', 0                  ; Shortened text
    db 11, 35, 0Bh, 'Dev:', 0                  ; Shortened
    db 12, 35, 0Ah, 'Ejaz', 0                  ; Removed dash
    db 13, 35, 0Ch, 'Abdullah', 0              ; Removed dash
    db 15, 35, 0Dh, 'By:', 0                   ; Shortened
    db 16, 35, 0Fh, 'Sir Muzamil', 0              ; Shortened
    db 0

menu_text:
    db 13, 10, '1:Pattern', 13, 10            ; Removed space
    db '2:Time', 13, 10                       ; Removed space
    db '3:Rainbow', 13, 10                    ; Removed space
    db 'Q:Quit', 13, 10, 0                    ; Removed space

pattern_color db 9
animation_counter db 0
current_row db 10

times 510-($-$$) db 0
dw 0xAA55