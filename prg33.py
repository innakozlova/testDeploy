#print(dir([]))


okroshka = ['огурец', 'квас', 'кефир', 'соль','перец']
additional= ['колбаса', 'редис', 'картофель']

final=okroshka +additional+['петрушка']
final+=['укроп']
#способ 1
print('Ингредиентов в окрошке:',len(final))
print('Вот они:')
count=1
for item in final:
    print(f'\t{count}.{item}')
    count+=1


#Способ 2
print('Ингредиентов в окрошке:',len(final))
print('Вот они:')
final.sort()
for item in range(len(final)):
    print(f'\t{item+1}.{final[item]}')

#Способ 3
#final.sort()
#print(*final sep end)

final=okroshka +additional+['петрушка']
final.append('укроп')
temp=final.pop(3)

print(final.pop(3))
print(final.remove('соль'))


final.insert(3,temp)

print(final.index('колбаса'))
print(final)