# Author = Mikhail Konstantinovich Dobkes
# Group = P3106
# Date = 10.10.2025
# Assignment variant = 5
import re

VOWELS = "АОЭЕУЁЮЯИЫаеёиоуыэюя"
CONSONANTS = "БВГДЖЗЙКЛМНПРСТФХЦЧШЩбвгджзйклмнпрстфхцчшщ"
LETTERS = "А-Яа-яЁё"
SPECIAL_SYMBOLS = " \t\n\r.,;:!?-–—()[]{}\"'«»„“…"
SPECIAL_SYMBOLS_ESC = re.escape(SPECIAL_SYMBOLS)

def solve(s):
    r = (rf"(\b[{LETTERS}]*?[{VOWELS}]{{2}}[{LETTERS}]*?\b)"+
         rf"[{SPECIAL_SYMBOLS_ESC}]*"+
         rf"(\b[{VOWELS}]*[{CONSONANTS}]?[{VOWELS}]*[{CONSONANTS}]?[{VOWELS}]*[{CONSONANTS}]?[{VOWELS}]*\b)")

    m = []
    for match_start in re.finditer(r'\b', s):
        i = match_start.start()
        match = re.match(r, s[i:])
        if match and match.group(2).strip() != "":
            m.append(match.groups())

    print("Result:")
    if len(m) == 0:
        print()
        return
    for i, x in enumerate(m):
        if x[1].strip() == "":
            continue
        print(x[0]+(", " if i != len(m)-1 else ""), end="")
    print("\n")

test1 = "Кривошеее существо гуляет по парку"
test2 = "Яичный ккккк"
test3 = "Яичный яичный\nяичный \nяичный"
test4 = "А это тест на использование(скоб)"
test5 = "Так говорила в июле 1805 года известная Анна Павловна Шерер, фрейлина и приближенная императрицы Марии Феодоровны, встречая важного и чиновного князя Василия, первого приехавшего на ее вечер. Анна Павловна кашляла несколько дней, у нее был грипп, как она говорила (грипп был тогда новое слово, употреблявшееся только редкими). В записочках, разосланных утром с красным лакеем, было написано без различия во всех"

solve(test1)
solve(test2)
solve(test3)
solve(test4)
solve(test5)