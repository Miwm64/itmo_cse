num = input("Введите 7-значный код Хэмминга:   ")
arr = [int(x) for x in num]

s1 = arr[0]^arr[2]^arr[4]^arr[6]
s2 = arr[1]^arr[2]^arr[5]^arr[6]
s3 = arr[3]^arr[4]^arr[5]^arr[6]
final_s = int(str(s1)+str(s2)+str(s3), 2)

match (final_s):
    case 1:
        print("Ошибка в r3")
        arr[3] = arr[3]^1
    case 2:
        print("Ошибка в r2")
        arr[1] = arr[1]^1
    case 3:
        print("Ошибка в i3")
        arr[5] = arr[5]^1
    case 4:
        print("Ошибка в r1")
        arr[0] = arr[0]^1
    case 5:
        print("Ошибка в i2")
        arr[4] = arr[4]^1
    case 6:
        print("Ошибка в i1")
        arr[2] = arr[2]^1
    case 7:
        print("Ошибка в i4")
        arr[6] = arr[6]^1
    case _:
        print("Ошибок нет")
num = "".join(str(i) for i in arr)
print(num[2]+num[4:])