from main import yaml_to_struct, delete_comments


def struct_to_xml(struct, root_name="root") -> str:
    return f"<{root_name}>\n{struct_to_xml_worker(struct, 1)}</{root_name}>\n"

def struct_to_xml_worker(struct, curr_tabs=0) -> str:
    tab = "\t" * curr_tabs
    res = ""

    if isinstance(struct, dict):
        for key, val in struct.items():
            if val is None:
                res += f"{tab}<{key} xsi:nil=\"true\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"/>\n"
            elif isinstance(val, (dict, list)):
                res += f"{tab}<{key}>\n{struct_to_xml_worker(val, curr_tabs+1)}{tab}</{key}>\n"
            elif isinstance(val, bool):
                res += f"{tab}<{key}>{str(val).lower()}</{key}>\n"
            else:
                res += f"{tab}<{key}>{val}</{key}>\n"

    elif isinstance(struct, list):
        for val in struct:
            if val is None:
                res += f"{tab}<item xsi:nil=\"true\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"/>\n"
            elif isinstance(val, (dict, list)):
                res += f"{tab}<item>\n{struct_to_xml_worker(val, curr_tabs+1)}{tab}</item>\n"
            elif isinstance(val, bool):
                res += f"{tab}<item>{str(val).lower()}</item>\n"
            else:
                res += f"{tab}<item>{val}</item>\n"

    return res


if __name__ == '__main__':
    with open("input.yaml") as f:
        content = f.readlines()
        content = delete_comments(content)
    struct = yaml_to_struct(content)
    res = struct_to_xml(struct)
    with open("output_add3.xml", "w") as f:
        f.write(res)
