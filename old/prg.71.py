# функция в качестве объекта
# Syntax Sugar (синтаксический сахар)

печать = print

печать('Здравствуйте', sep=' и')

a=list(range(1,11))

# Функция высшего порядка
b= list(map(str,a)) # берет каждую функцию как объект.список строк на выходе
print(b)

res=' и '.join(b)
print(res)

#Сделать список квадратов чисел из исходного списка
#def square(num):
#  return num**2

# square, поскольку простая, может быть записана и так
#ll=lambda num: num**2
# summ= lambda a,b: a+b
sq=list(map(lambda num: num*2,a))


print(sq)

fruits=['Арбуз', 'Ананас','Банан', 'Яблоко', 'Манго']
fruits.sort(key= lambda letter: letter[-1])
print(fruits)

