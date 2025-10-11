# Author = Mikhail Konstantinovich Dobkes
# Group = P3106
# Date = 10.10.2025
# Assignment variant = 1

import re

ENDINGS = r"юю|ья|ыя|ым|ими|ыми|их|ых|ого|его|ому|ему|ом|ем|ую|ая|яя|ое|ее|ый|ий|ой|ые|ие|ов|ев|ыхов|ихев"
FIND_REGEX = rf"\b([^ !.,-?\n\t\r]+)({ENDINGS})\b.*?(?=\1({ENDINGS})\b)"

def solve(s, n=2):
    m = re.findall(FIND_REGEX, s, re.IGNORECASE)
    roots = []
    roots_endings = []
    done_roots = set()
    for (root, ending1, ending2) in m:
        roots.append(root.lower())
        if n == 1 and not done_roots.__contains__(root.lower()):
            roots_endings.append((root, ending1))
            done_roots.add(root.lower())
        elif n == 2 and not done_roots.__contains__(root.lower()):
            roots_endings.append((root, ending2))
            done_roots.add(root.lower())
        elif roots.count(root) == n and not done_roots.__contains__(root.lower()):
            roots_endings.append((root, ending2))
            done_roots.add(root.lower())
    for (root, ending2) in roots_endings:
        s = re.sub(rf"\b({root})([^ \n\t\r!.,-?]+)\b", rf"\1{ending2}", s, flags = re.IGNORECASE)
    print(f"Result:\n{s}\n")



'''
Tests
'''
test1 = "Футбольный клуб «Реал Мадрид» является 15-кратным обладателем главного футбольного европейского трофея – Лиги Чемпионов. Данный турнир организован Союзом европейских футбольных ассоциаций (УЕФА). Идея о континентальном футбольном турнире пришла к журналисту Габриэлю Ано в 1955 году."
test2 = "Прилагательное прилагательные прилагательный прилагательная"
test3 = "Машины проезжают по дороге и останавливаются на светофоре."
test4 = "Красивый парк, красивое озеро и красивым деревьям любовались все."
test5 = """В учебном пособии рассматриваются основы функционирования и
построения ЭВМ. Приводятся общие сведения о представлении и обработке
информации в ЭВМ. Описывается функциональная модель гипотетической
микроЭВМ (Базовой ЭВМ), структурно похожей на любые несложные ЭВМ,
и работа с этой моделью. На ней можно исследовать взаимодействия
устройств ЭВМ при выборке и исполнении команд и изучить ее
функционирование на микропрограммном уровне. Эта ЭВМ впервые была
подробно описана в [2,3] и с тех пор используется для обучения студентов на
кафедре вычислительной техники, а также на многих кафедрах ИТМО и ряда
других университетов. За 25 лет описания в [2,3] устарели и возникла
необходимость их переработки и издания этого учебного пособия, в которое
включены из [2] отредактированные разделы по Базовой ЭВМ. 
"""

solve(test1, 1)
solve(test2, 2)
solve(test3, 2)
solve(test4, 2)
solve(test5, 2)