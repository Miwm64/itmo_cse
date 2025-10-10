# Author = Mikhail Konstantinovich Dobkes
# Group = P3106
# Date = 10.10.2025
# Assignment variant = 3

import re

VOWELS = "АОЭЕУЁЮЯИЫаеёиоуыэюя"
CONSONANTS = "БВГДЖЗЙКЛМНПРСТФХЦЧШЩбвгджзйклмнпрстфхцчшщ"
LETTERS = "А-Яа-яЁёa-zA-Z"
MY_GROUP = "P3106"

def solve(s):
    r = rf"([{LETTERS}-]*)\s+([а-яА-яёЁ]).([а-яА-яёЁ]).\s+([A-Z][0-9]*)"
    m = re.findall(r, s)
    res = ""
    for line in m:
        if not(line[3] == MY_GROUP and line[1] == line[2]):
            res += f"{line[0]} {line[1]}.{line[2]}. {line[3]}\n"
    print("Result:\n"+res)

test1 = "Петров-Петров П.П. P3106\nАнищенко А.А. P33133313\nПетров-Петров П.П. P0000\nИванов И.И. P0000"
test2 = formatted_names = """Аруко А.Б. P3106
Бахеткин А.В. P3106
Гатин Р.Р. P3106
Джунь А.В. P3106
Добкес М.К. P3106
Завражин И.А. P3106
Киреев Д.О. P3106
Кобленц М.А. P3106
Лишик А.Ю. P3106
Пегушина В.А. P3106
Сафин И.Д. P3106
Тайлаков К.Е. P3106
Тарбаев М.А. P3106
Чуева А.А. P3106
Юрганова М.К. P3106"""
test3 = "Петров-Петров С.С. P3106\nСидоров И.И. P3106\nПетров П.П. P3106"
test4 = "П п пп 0932\n\n\nP3106"
test5 = "Алехин Ф.Ф. P3106\nБелова И.К. P3106\nВоронцов Р.Р. P3106\nГоршкова А.М. P3106\nДемидов М.О. P3106\nАрусов Ф.Б. P5023\nБелова И.И. P5049\nВоронцов Р.Д. P5033\nГоршкова М.М. P5018\nДемидов М.М. P5023"


solve(test1)
solve(test2)
solve(test3)
solve(test4)
solve(test5)