import yaml
import hcl2

def yaml_to_hcl(s: str) -> str:
    content = yaml.load(s, Loader=yaml.Loader)
    tree = hcl2.reverse_transform({"data": content})
    data = hcl2.writes(tree)
    return data


if __name__ == '__main__':
    text = ""
    with open("input.yaml", "r") as f:
        text = f.read()
    with open("output_add2.hcl", "w") as f:
        d = yaml_to_hcl(text)
        f.write(d)