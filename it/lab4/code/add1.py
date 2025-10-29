from main import yaml_filepath_to_struct


def struct_to_hcl(struct) -> str:
    return "data = " + struct_to_hcl_worker(struct)

def struct_to_hcl_worker(struct, curr_tabs = 0, add_tabs = True) -> str:
    res = ""
    if type(struct) == list:
        if add_tabs:
            res = "\t"*curr_tabs + "[\n" + res
        else:
            res = "[\n" + res
        printed = 0
        for val in struct:
            if type(val) in [dict, list]:
                res += struct_to_hcl_worker(val, curr_tabs + 1)+ ( ",\n" if printed + 1 != len(struct) else "")
            else:
                if type(val) == str:
                    res += ("\t"*(curr_tabs+1)) + f'"{str(val)}"' + ( ",\n" if printed + 1 != len(struct) else "")
                elif type(val) == bool:
                    res += ("\t"*(curr_tabs+1)) + f'{str(val).lower()}' + ( ",\n" if printed + 1 != len(struct) else "")
                elif val is None:
                    pass
                else:
                    res += ("\t"*(curr_tabs+1)) + str(val) + ( ",\n" if printed + 1 != len(struct) else "")
            printed += 1
        res = res + "\n" + "\t"*curr_tabs + "]\n"
    elif type(struct) == dict:
        if add_tabs:
            res = "\t" * curr_tabs + "{\n" + res
        else:
            res = "{\n" + res

        printed = 0
        for key, val in struct.items():
            if val is None:
                continue
            res += ("\t"*(curr_tabs+1) + str(key) + " = ")
            if type(val) in [dict, list]:
                res += struct_to_hcl_worker(val, curr_tabs + 1, False)
            else:
                if type(val) == str:
                    res += f'"{str(val)}"' + ( "\n" if printed + 1 != len(struct) else "\n")
                elif type(val) == bool:
                    res += f'{str(val).lower()}' + ( "\n" if printed + 1 != len(struct) else "\n")
                elif val is None:
                    pass
                else:
                    res += str(val) + ("\n" if printed + 1 != len(struct) else "\n")

        res = res + "\t"*curr_tabs + "}\n"


    return res

if __name__ == '__main__':
    struct = yaml_filepath_to_struct("input.yaml")
    with open("output_add1.hcl", "w") as f:
        f.write(struct_to_hcl(struct))