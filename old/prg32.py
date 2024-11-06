s={'a', 1, 36.6}
empty_set=set()

array=list() # пустой список
array=['ясно', 'пасмурно', 36.6]
# index  0        1          2
print(array[-3][0])

okroshka = ['огурец', 'квас', 'кефир', 'соль','перец']
print(okroshka[::2])

word='pithon'
#word[1]='y'# так нельзя

lst= list(word)
lst[1]='y'
print(*lst, sep='')

dishes=['борщ','пюре','компот', 'сок']
first, second, third, forth =dishes
*eat, compot, juice=dishes

print(compot)