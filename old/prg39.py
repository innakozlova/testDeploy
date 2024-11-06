#Кортеж тот же список, но не изменяемый

#text='О сколько  нам   открытий   чудных!  '

#lst=text.split()

#res=''.join(lst)
#print(res)
BLACK=(0,0,0)
RED=(255,0,0)
red=[255,0,0]
print(RED.__sizeof__())
print(red.__sizeof__())

result=BLACK+RED
empty_tuple=()
empty_tuple=tuple()

num=(1,)


print(type(num))

print(dir(num))

#список из кортежей

cards=[('Дама', 'Червей'), ('Туз', 'Пик')]
print(cards[0][0], cards[0][1])
print(*cards[0], sep=',')