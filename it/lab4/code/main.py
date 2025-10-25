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

#TODO comments? #

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

def parse_block_scalar(content, curr_index, indent_level):
    line = content[curr_index]
    block_type = "|" if find_pos(line, "|") < find_pos(line, ">") else ">"
    
    block_content = []
    curr_index += 1 
    
    while curr_index < len(content):
        next_line = content[curr_index]
        next_indent = count_indents(next_line)
        
        if next_indent <= indent_level:
            break
            
        block_content.append(next_line[next_indent:])
        curr_index += 1
    
    if block_type == "|":
        result = "\n".join(block_content)
    else:  # ">" 
        result = " ".join(line.strip() for line in block_content)
    
    return result, curr_index - 1  # Return to last processed line



def parse_scalar(line: str):
    addition = ""
    quoted = line[0] in "'\""
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
    

    if addition.lower() in ["false", "true"] and not quoted:
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



def delete_comments(arr: list[str]) -> list[str]:
    def find_all_indexes(s: str, ch: str) -> list[int]:
        return [i for i, c in enumerate(s) if c == ch]

    result = []
    for line in arr:
        quotes = sorted(find_all_indexes(line, "'") + find_all_indexes(line, '"'))
        comment_index = line.find('#')
        if comment_index != -1:
            # check if comment_index lies inside any quoted range
            inside_quote = False
            for i in range(0, len(quotes), 2):
                if i + 1 < len(quotes) and quotes[i] < comment_index < quotes[i + 1]:
                    inside_quote = True
                    break
            if not inside_quote:
                line = line[:comment_index]
        result.append(line.rstrip())
    return result

# Check last line errors
# [start_index, end_index]
def yaml_to_struct(content: list[str], start_index = 0, indent_level = 0):
    struct = None
    curr_index = start_index
    
    if content[curr_index].strip()[0] == "-" and (content[curr_index].strip() == "-" or content[curr_index].strip()[1] == " "):
        struct = []
        while curr_index < len(content):
            line = content[curr_index]
            if content[curr_index].strip() == "---":
                curr_index += 1
                continue
            if content[curr_index].strip()[0] == "#":
                curr_index += 1
                continue
            if count_indents(line) > indent_level:
                curr_index += 1
                continue
            if count_indents(line) < indent_level:
                curr_index += 1
                break


            if (find_pos(line, ":") < min(find_pos(line, "'"), find_pos(line, '"')) or 
                line.strip() == "-" or 
                (line.strip().startswith("-") and line.replace("-", "", 1).strip().startswith("-"))):
                if (line.strip() == "-" and curr_index == len(content)-1):
                    struct.append(None)
                elif curr_index != len(content)-1 and count_indents(content[curr_index+1]) <= indent_level and line.strip() == "-":
                    struct.append(None)
                elif line.count(":"):
                    if line.replace("-"," ", 1).strip() != "":
                        content_copy = content
                        content_copy[curr_index] = content_copy[curr_index].replace("-", " ", 1)
                        struct.append(yaml_to_struct(content_copy, curr_index,
                                                    count_indents(content_copy[curr_index])))
                elif curr_index != len(content)-1 and content[curr_index+1].count(":"):
                    struct.append(yaml_to_struct(content, curr_index+1,
                                                 count_indents(content[curr_index+1])))
                else:
                    if line.replace("-"," ", 1).strip() != "":
                        content_copy = content
                        content_copy[curr_index] = content_copy[curr_index].replace("-", " ", 1)
                        struct.append(yaml_to_struct(content_copy, curr_index,
                                                    count_indents(content_copy[curr_index])))
                    else:
                        struct.append(yaml_to_struct(content, curr_index+1,
                                                    count_indents(content[curr_index+1])))
                
                    
            elif min(find_pos(line, "|"), find_pos(line, ">")) < min(find_pos(line, "'"), find_pos(line, '"')):
                block_value, curr_index = parse_block_scalar(content, curr_index, indent_level)
                struct.append(block_value)

            # Basic case - just character
            else:
                left = 0
                while line[left] in " -":
                    left += 1
                if line[left-1] != " ":
                    left += 1
                struct.append(parse_scalar(line[left:]))
                
            curr_index += 1
    elif content[curr_index].strip()[0] == "-":
        return parse_scalar(content[curr_index].strip())
    else:
        struct = {}
        while curr_index < len(content):
                line = content[curr_index]

                if content[curr_index].strip() == "---":
                    curr_index += 1
                    continue
                if content[curr_index].strip()[0] == "#":
                    curr_index += 1
                    continue
                if count_indents(line) > indent_level:
                    curr_index += 1
                    continue
                if count_indents(line) < indent_level:
                    curr_index += 1
                    break

                key = line.split(":")[0].strip()
                value = line[indent_level+len(key)+1:]

                if value.strip() == "":
                    if curr_index == len(content)-1 or count_indents(content[curr_index+1]) <= indent_level:
                        struct[key] = None
                    
                    else:
                        struct[key] = yaml_to_struct(content, curr_index+1,
                                                    count_indents(content[curr_index+1]))
                    
                        
                elif min(find_pos(line, "|"), find_pos(line, ">")) < min(find_pos(line, "'"), find_pos(line, '"')):
                    block_value, curr_index = parse_block_scalar(content, curr_index, indent_level)
                    struct[key] = (block_value)

                # Basic case - just character
                else:
                    left = 0
                    while value[left] in " -":
                        left += 1
                    if left != 0 and value[left-1] != " ":
                        left -= 1
                    struct[key] = (parse_scalar(value[left:]))
                    
                curr_index += 1
    return struct

    





with open("input.yaml") as f:
    example = f.readlines()
    example = delete_comments(example)
    res = yaml_to_struct(example)
    print(res)