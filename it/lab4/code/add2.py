import yaml
import hcl2

def yaml_to_hcl(s: str) -> str:
    content = yaml.load(s, Loader=yaml.Loader)
    tree = hcl2.reverse_transform({"data": content})
    data = hcl2.writes(tree)
    return data

def yaml_to_hcl_filepath(filepath: str) -> str:
    text = ""
    with open(filepath, "r") as f:
        text = f.read()
    content = yaml.load(text, Loader=yaml.Loader)
    tree = hcl2.reverse_transform({"data": content})
    data = hcl2.writes(tree)
    return data

if __name__ == '__main__':
    print(yaml_to_hcl_filepath("input.yaml"))