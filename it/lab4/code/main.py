# 121
# Понедельник, суббота
# YAML -> HCL
'''FORMAL GRAMMAR - EBNF
<yaml> ::= <block>

# BLOCKS
<block> ::= <map>+ | <list>+ | <scalar>
<list> ::= "-" <space>+ <block>
<map> ::= <key> ":" <value>
<items> ::= <block> ("," <block>)*
<key-value-pairs> ::= <key> ":" <value> ("," <key> ":" <value>)*

# MAP
<key> ::= <scalar>
<value> ::= <space>* <block> | <inline-map> | <inline-list>

# FLOW STYLES  
<inline-map> ::= "{" <key-value-pairs>? "}"
<inline-list> ::= "[" <items>? "]"

# SCALARS
<scalar> ::= <plain-scalar> | <quoted-scalar> | <block-scalar>
<plain-scalar> ::= <safe-char>+
<safe-char> ::= <letter> | <digit> | <safe-symbol>
<safe-symbol> ::= " " | "-" | "_" | "."
<quoted-scalar> ::= <single-quoted> | <double-quoted>
<single-quoted> ::= "'" [^']* "'"
<double-quoted> ::= '"' ([^"\\] | "\\" .)* '"'
<block-scalar> ::= <block-style> <line-end> <indented-content>
<block-style> ::= "|" | ">"  (* literal | folded *)
<indented-content> ::= <indent> <line-content> <line-end> <indented-content> | ""
'''

def count_indents(s: str):
    amount = 0
    while s[amount] == " ":
        amount += 1
    return amount

def find_pos(s: str, char: str):
    if s.count(char) == 0:
        return 10**4
    else:
        return s.find(char)

def get_scalar(line: str):
    if line[0] in '"':
        addition = line.strip()[1:-1]
        addition = addition.replace('\\n', '\n')
        addition = addition.replace('\\t', '\t')
        addition = addition.replace('\\r', '\r')      
        addition = addition.replace('\\"', '"')
        addition = addition.replace('\\\\', '\\')     
    elif line[0] in "'":
        addition = line.strip()[1:-1]
    else:
        addition = line.strip()[0:]
    

    if addition.lower() in ["false", "true"]:
        return addition.lower() == "true"
    elif addition == "null":
        return None
    if line.count("'")+line.count('"') == 0:
        try:
            return(int(addition))
        except:
            try:
                return(float(addition))
            except:
                return(addition)
    else:
        return(addition)


# Check last line errors
# [start_index, end_index]
def yaml_to_struct(content: list[str], start_index = 0, indent_level = 0):
    struct = None
    curr_index = start_index
    if content[curr_index].strip() == "---":
        curr_index += 1
    
    if content[curr_index].strip()[0] == "-":
        struct = []
        while curr_index < len(content):
            line = content[curr_index]
            curr_index += 1
            if count_indents(line) > indent_level:
                continue
            if count_indents(line) < indent_level:
                break

            if min(find_pos(line, ":"),
                find_pos(line, ">")) < min(
                    find_pos(line, "'"), find_pos(line, '"')) or line.strip() == "-":
                pass # TODO fix
            elif min(find_pos(line, "|"), 
                    find_pos(line, ">")) < min(
                    find_pos(line, "'"), find_pos(line, '"')):
                pass # TODO fix


            # Basic case - just character
            else:
                left = 0
                addition = ""
                while line[left] in " -":
                    left += 1
                struct.append(get_scalar(line[left:]))
                


                
        return struct
    else:
        struct = {}
    

    


            
        

    return struct

    

            
    



with open("test1.yaml") as f:
    example = f.readlines()
    res = yaml_to_struct(example)
    print(res)