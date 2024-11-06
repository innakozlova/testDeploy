# Словари

# d=dict()
# d={} пустой словарь

d = {
    'стул': 'chair',
    'стол': 'table',
    'яблоко': 'apple',
    'меню': ['суп', 'тефтели', 'чай']
}

print(d['меню'] [1])
d['слива']= 'plum'
d[0]='one'
print(d[0])

d[True]='Истина'
print(d[True])

print(d.keys())
print(len(d))
print(list(d.keys()))
print(list(d.values()))
print(list(d.items()))

for keys in d:
    print()

if 'слива' in d.keys():
    print('Слива есть среди ключей')

print(d.get('груша'))

del d['стул']
print(d)