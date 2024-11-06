
name='Виктор'
age=10
height=141.5


f_string='имя: %10s, \nвозраст:  %2d,\nрост: %6.1f см'  % (name, age, height)
print(f_string)

f_string='Имя:{:12s},возраст:{:6d}лет,рост:{:.2f}'.format(name,age,height)
print(f_string)
#Интерполяция строк
f_string=f'Имя:{name}, Рост:{height:.2f}, Возраст:{age}\n'

print(f_string)

f_string+=f'При фигуре из 4 сторон угол будет: {360/4}'
print(f_string)
