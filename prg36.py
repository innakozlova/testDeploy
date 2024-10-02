s='Сабака'

n=s.replace('а','о',1)
print(n)


text='О сколько нам открытий чудных О сколько нам открытий чудных'

#set=(text)
lst=text.split()
count=lst.count('сколько')
print(f'Слово сколько повторилось {count} раз(а)')
lst= set(lst) #превратить в множество
lst= list(lst) #превратить в список
lst.sort() # отсортировали
#lst=list(text)

for word in lst:
    if len(word)>2:
        print(word)

