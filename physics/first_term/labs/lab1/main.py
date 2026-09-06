arr = [40, 20, 14, 25, 61, 63, 9, 31, 23, 37, 18, 27, 12, 23, 28, 22, 10, 32, 8, 17, 18,
       36, 16, 23, 7, 6, 32, 30, 27, 51, 26, 29, 27, 20, 30, 14, 16, 20, 9, 3, 16, 16, 15, 22, 16,
       14, 47, 14, 31, 29, 21, 26, 29, 25, 14]
print(len(arr))
print(sum(arr))
print(sum(arr)/len(arr))

for i in arr:
       print(i)

print(min(arr))
print(max(arr))


intervals = [0]* 8

for i in arr:
       intervals[(i-3)//8] += 1
print(intervals)
tmp = 0
for i in intervals:
       print(i/len(arr)/8)
       tmp += i/len(arr)/8

sigma1 = 0
for i in arr:
       if i >= 12 and i <= 36:
              sigma1 += 1
print(sigma1)

sigma2 = 0
for i in arr:
       if i >= 0 and i <= 48:
              sigma2 += 1
print(sigma2)

sigma3 = 0
for i in arr:
       if i >= 0 and i <= 60:
              sigma3 += 1
print(sigma3)