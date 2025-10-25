import yaml
import json

def yaml_to_hcl(s: str):
    content = yaml.load(s, Loader=yaml.Loader)
    data = "data = " + json.dumps(content, indent=4, ensure_ascii=False)
    return data

