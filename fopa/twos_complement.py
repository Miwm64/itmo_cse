while True:
    hex_input = input("Enter hex value: ").strip()
	
    if "exit" in hex_input:
        exit()	

    if len(hex_input) == 0:
        print("Error: Empty input.")
        continue

    try:
        value = int(hex_input, 16)
    except ValueError:
        print("Error: Invalid hex input.")
        continue

    # 4 bits per hex digit
    total_bits = len(hex_input) * 4

    # 2^(n-1)
    sign_threshold = 1 << (total_bits - 1)

    # If sign bit is set
    if value >= sign_threshold:
        value -= 1 << total_bits

    print(f"{total_bits}-bit signed decimal:", value)
