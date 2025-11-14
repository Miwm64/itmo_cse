import time
from copy import deepcopy

from add1 import struct_to_hcl
from add2 import yaml_to_hcl
from add3 import struct_to_xml
from def1 import make_binary
from main import yaml_str_to_struct


def check_speed(input, funcs):
    start  = time.time()
    res_for_operation = []
    for op_n in range(len(funcs)):
        loc_start = time.time()
        for i in range(100):
            res = funcs[op_n](input)
            if i == 99:
                input = res
        loc_end = time.time()
        res_for_operation.append(loc_end - loc_start)
    end = time.time()
    return end - start, res_for_operation

with open("input.yaml") as f:
    content = f.read()

print("MY yaml -> hcl2 with pickle ", check_speed(content, [yaml_str_to_struct, struct_to_hcl, make_binary]))
print("MY  yaml -> hcl2: ", check_speed(content, [yaml_str_to_struct, struct_to_hcl]))
print("MY  yaml -> xml:  ", check_speed(content, [yaml_str_to_struct, struct_to_xml]))
print("LIB yaml -> hcl2: ", check_speed(content, [yaml_to_hcl]))

