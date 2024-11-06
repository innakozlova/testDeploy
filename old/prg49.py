#Чтение нескольких строк

fo = open('sample.txt', encoding='UTF-8')  # по умолчанию режим rt, чтение текста
text = fo.readline()
while text !='': #если строка пустая
    print(text, end='')
    text = fo.readline()
fo.close()