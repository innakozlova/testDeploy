#строки, списки, операции с ними и их методы

text='О сколько нам открытий чудных! О сколько, нам открытий чудных'

p='!,.?;' # знаки пунктуации
#p= list(temp)

# делаем замену на пустую строку для каждого из них
for item in p:
    text=text.replace(item,'')

#разбиваем по пробелам и получаем список чистых слов
lst=text.split()

print(lst)

word='P y t h   on'

lst=word.split()
word=''.join(lst)
print(word)

word='P y t h   on'
word=''.join(word.split())
print(word)