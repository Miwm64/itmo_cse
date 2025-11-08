import pickle
from main import yaml_filepath_to_struct
import time

def make_binary(obj: list or dict):
    return pickle.dumps(obj)

if __name__ == '__main__':
    start = time.time()
    struct = yaml_filepath_to_struct("input.yaml")
    middle = time.time()
    pickle.dump(struct, open("output.pickle", "wb"))
    end = time.time()
    print(middle - start, end-middle)
