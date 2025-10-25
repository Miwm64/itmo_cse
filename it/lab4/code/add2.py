import yaml
import json

def yaml_to_hcl(s: str):
    content = yaml.load(s, Loader=yaml.Loader)
    data = "data = " + json.dumps(content, indent=4, ensure_ascii=False)
    return data

if __name__ == '__main__':
    text = ""
    with open("input.yaml", "r") as f:
        text = f.read()
    with open("output_add2.hcl", "w") as f:
        d = yaml_to_hcl(text)
        f.write(d)