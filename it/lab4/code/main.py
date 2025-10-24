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

# BASIC TOKENS (missing from your original)
<letter> ::= [A-Za-z]
<digit> ::= [0-9]
<space> ::= " "
<indent> ::= <space>+
<line-end> ::= "\n" | "\r\n" | "\r"
<line-content> ::= [^\r\n]*
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


            
            else:
                left = 0
                addition = ""
                while line[left] in " -":
                    left += 1
                if line[left] in '"':
                    # Double quotes - process escape sequences
                    addition = line.strip()[left+1:-1]
                    addition = addition.replace('\\n', '\n')      # Newline
                    addition = addition.replace('\\t', '\t')      # Tab
                    addition = addition.replace('\\r', '\r')      # Carriage return
                    addition = addition.replace('\\"', '"')       # Escaped double quote
                    addition = addition.replace('\\\\', '\\')     # Escaped backslash
                elif line[left] in "'":
                    # Single quotes - treat everything literally (standard YAML)
                    addition = line.strip()[left+1:-1]
                    # Only replace escaped single quote
                    addition = addition.replace("''", "'") 
                else:
                    addition = line.strip()[left:]
                

                if addition.lower() in ["false", "true"]:
                    struct.append(addition == "true")
                    continue
                elif addition == "null":
                    struct.append(None)
                    continue
                if line.count("'")+line.count('"') == 0:
                    try:
                        struct.append(int(addition))
                    except:
                        try:
                            struct.append(float(addition))
                        except:
                            struct.append(addition)
                else:
                    struct.append(addition)



                
        return struct
    else:
        struct = {}
    

    


            
        

    return struct

    

            
    



with open("test1.yaml") as f:
    example = f.readlines()
    res = yaml_to_struct(example)
    print(res)