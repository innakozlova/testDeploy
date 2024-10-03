# Файлы (запись)

#Режимы r- read, w- write, a- append
# Подрежим b- binary, t- text
# UTF-8 Unicode Text Format (256 - ASCII)
fo=open('sample.txt', 'wt', encoding='UTF-8') # по умолчанию режим rt, чтение текста

print(fo.name, fo.mode, fo.encoding)
num=fo.write('Это текст внутри файла')
print(num)

fo.close()