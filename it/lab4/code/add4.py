import time
from add1 import struct_to_hcl
from add2 import yaml_to_hcl
from add3 import struct_to_xml
from main import yaml_str_to_struct


def check_speed(input, funcs):
    start  = time.time()
    for i in range(100):
        res = input
        for func in funcs:
            res = func(input)
    end = time.time()
    return end - start

with open("input.yaml") as f:
    content = f.read()

print("MY  yaml -> hcl2: ", check_speed(content, [yaml_str_to_struct, struct_to_hcl]))
print("MY  yaml -> xml:  ", check_speed(content, [yaml_str_to_struct, struct_to_xml]))
print("LIB yaml -> hcl2: ", check_speed(content, [yaml_to_hcl]))

