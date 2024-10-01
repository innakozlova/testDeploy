import string as s
import random as r

num=4

# набор из букв и цифр
set_of_symbols=s.digits+s.ascii_uppercase+s.ascii_lowercase
# превращаем в множество
set_of_symbols=set(set_of_symbols)
# удаляем сомнительный символы
set_of_symbols=set_of_symbols-{'O','0','1','l','I'}
# множество больше не нужно. конвертируем в список
set_of_symbols=list(set_of_symbols)

# берем первые num символов срезом
temp=set_of_symbols[:num]
# получаем случайные n-символы
#temp = [r.choice(set_of_symbols)]
#for _ in range(num):
   # temp += r.choice(set_of_symbols)
 #   temp.append(r.choice(set_of_symbols))
    # полученную строку превратили в список
#temp=list(temp)
temp = r.sample(set_of_symbols, k=num) #случайная выборка в виде списка без повторов
print(temp)
# добавили спецсимволы
temp+= ['@', '!', '&', '?', '$']
# перемешали список с буквами и спецсимволами
r.shuffle(temp)
while temp[0] in ['@', '!', '&', '?', '$']: #перемешивает до тех пор, пока спецсимвол будет не первым
    r.shuffle(temp)
# объединяем все символы из списка в одну строку
password=''.join(temp)
#выводим результат
print(password)



