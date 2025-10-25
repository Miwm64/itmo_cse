from main import yaml_to_struct, delete_comments

# extra_line
# true not True
# null or None?

def struct_to_hcl(struct):
    return "data = " + struct_to_hcl_worker(struct)

def struct_to_hcl_worker(struct, curr_tabs = 0, add_tabs = True):
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
            res += ("\t"*(curr_tabs+1) + str(key) + " = ")
            if type(val) in [dict, list]:
                res += struct_to_hcl_worker(val, curr_tabs + 1, False)
            else:
                if type(val) == str:
                    res += f'"{str(val)}"' + ( ",\n" if printed + 1 != len(struct) else "\n")
                else:
                    res += str(val) + (",\n" if printed + 1 != len(struct) else "\n")

        res = res + "\t"*curr_tabs + "}"


    return res

if __name__ == '__main__':
    with open("test2.yaml") as f:
        example = f.readlines()
        example = delete_comments(example)
        res = yaml_to_struct(example)
        # print(struct_to_hcl(res))
        open("output.hcl", "w").write(struct_to_hcl(res))