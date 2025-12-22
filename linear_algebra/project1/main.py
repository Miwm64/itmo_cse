import random
from math import gcd

alphabet_size = 37
alphabet = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ␣.,!?"
char_to_int = {ch: i for i, ch in enumerate(alphabet)}
int_to_char = {i: ch for i, ch in enumerate(alphabet)}


def text_to_ints(text):
    return [char_to_int[ch] for ch in text]
def ints_to_text(int_list):
    return ''.join(int_to_char[i] for i in int_list)

def generate_key_matrix():
    while True:
        matrix = [[random.randint(0, alphabet_size - 1) for _ in range(2)] for _ in range(2)]
        det = (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]) % alphabet_size
        if gcd(det, alphabet_size) == 1:
            return matrix

def modinv(a, m):
    a %= m
    if gcd(a, m) != 1:
        raise ValueError("No modular inverse")

    m0, x0, x1 = m, 0, 1
    while a > 1:
        q = a // m
        a, m = m, a % m
        x0, x1 = x1 - q * x0, x0
    return x1 % m0

def hill_encode(text, key_matrix):
    nums = text_to_ints(text)
    if len(nums) % 2 != 0:
        nums.append(char_to_int['␣'])

    result = []
    for i in range(0, len(nums), 2):
        x, y = nums[i], nums[i+1]
        r0 = (key_matrix[0][0]*x + key_matrix[0][1]*y) % alphabet_size
        r1 = (key_matrix[1][0]*x + key_matrix[1][1]*y) % alphabet_size
        result.extend([r0, r1])

    return ints_to_text(result)

def hill_decode(text, key_matrix):
    a, b = key_matrix[0]
    c, d = key_matrix[1]
    det = (a * d - b * c) % alphabet_size
    det_inv = modinv(det, alphabet_size)
    inv_matrix = [
        [(d * det_inv) % alphabet_size, (-b * det_inv) % alphabet_size],
        [(-c * det_inv) % alphabet_size, (a * det_inv) % alphabet_size]
    ]
    return hill_encode(text, inv_matrix)

def recover_key_from_12(plain_text, cipher_text):
    nums_plain = text_to_ints(plain_text)
    nums_cipher = text_to_ints(cipher_text)

    for i in range(0, len(nums_plain), 2):
        for j in range(i+2, len(nums_plain), 2):
            P = [[nums_plain[i], nums_plain[j]],
                 [nums_plain[i+1], nums_plain[j+1]]]

            a, b = P[0]
            c, d = P[1]
            det = (a*d - b*c) % alphabet_size
            if gcd(det, alphabet_size) == 1:
                C = [[nums_cipher[i], nums_cipher[j]],
                     [nums_cipher[i+1], nums_cipher[j+1]]]

                det_inv = modinv(det, alphabet_size)
                P_inv = [
                    [(d * det_inv) % alphabet_size, (-b * det_inv) % alphabet_size],
                    [(-c * det_inv) % alphabet_size, (a * det_inv) % alphabet_size]
                ]

                k00 = (C[0][0]*P_inv[0][0] + C[0][1]*P_inv[1][0]) % alphabet_size
                k01 = (C[0][0]*P_inv[0][1] + C[0][1]*P_inv[1][1]) % alphabet_size
                k10 = (C[1][0]*P_inv[0][0] + C[1][1]*P_inv[1][0]) % alphabet_size
                k11 = (C[1][0]*P_inv[0][1] + C[1][1]*P_inv[1][1]) % alphabet_size

                return [[k00, k01], [k10, k11]]

    raise ValueError("No independent columns found, cannot recover key")

# Example usage
plain = "СЕССИЯ␣СКОРО"
key = generate_key_matrix()
encoded = hill_encode(plain, key)
print(encoded)

recovered_key = recover_key_from_12(plain, encoded)
print("Original key:", key)
print("Recovered key:", recovered_key)
print(hill_decode(encoded, recovered_key))
print(hill_decode(hill_encode("ПРИВЕТ,␣МИР!", key), recovered_key))
