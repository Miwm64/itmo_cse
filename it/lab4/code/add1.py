from main import yaml_filepath_to_struct


def struct_to_hcl(struct) -> str:
    return "data = " + struct_to_hcl_worker(struct, 0, False).rstrip() + "\n"


def struct_to_hcl_worker(struct, curr_tabs=0, add_tabs=True) -> str:
    tab = "\t"
    indent = tab * curr_tabs
    res = ""

    # LIST
    if isinstance(struct, list):
        res += ("[\n" if not add_tabs else indent + "[\n")
        for i, val in enumerate(struct):
            comma = "," if i + 1 != len(struct) else ""
            if isinstance(val, (dict, list)):
                res += struct_to_hcl_worker(val, curr_tabs + 1, True).rstrip() + comma + "\n"
            else:
                res += tab * (curr_tabs + 1) + format_scalar(val) + comma + "\n"
        res += indent + "]"

    # DICT
    elif isinstance(struct, dict):
        res += ("{\n" if not add_tabs else indent + "{\n")
        items = [(k, v) for k, v in struct.items() if v is not None]
        for i, (key, val) in enumerate(items):
            res += tab * (curr_tabs + 1) + f"{key} = "
            if isinstance(val, (dict, list)):
                res += struct_to_hcl_worker(val, curr_tabs + 1, False).rstrip() + "\n"
            else:
                res += format_scalar(val) + "\n"
        res += indent + "}"

    else:
        res = format_scalar(struct)

    return res


def format_scalar(val):
    if isinstance(val, str):
        return f'"{val}"'
    elif isinstance(val, bool):
        return str(val).lower()
    elif val is None:
        return 'null'
    else:
        return str(val)


if __name__ == '__main__':
    struct = yaml_filepath_to_struct("input.yaml")
    with open("output_add1.hcl", "w", encoding="utf-8") as f:
        f.write(struct_to_hcl(struct))