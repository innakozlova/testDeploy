# Файлы (чтение)

#Режимы r- read, w- write, a- append
# Подрежим b- binary, t- text
# UTF-8 Unicode Text Format (256 - ASCII)
fo=open('sample.txt', 'rt', encoding='UTF-8') # по умолчанию режим rt, чтение текста

print(fo.name, fo.mode, fo.encoding)
fo.read(10)
text=fo.read(6)
print(text)

fo.close()

lst=text.split()
# как извлечь нужный фрагмент из текста 1
if 'внутри' in lst:
    for word in lst:
        if word=='внутри':
            print(word)
else:
    print('Такого слова в файле нет')

# как извлечь нужный фрагмент из текста 2
if 'внутри' in lst:
    index = lst.index('внутри') #метод списка index
    print(lst[index])
else:
    print('Такого слова в файле нет')