# Объектно-ориентированный подход
# Инкапсуляция
class Ball:
    #спец методы ( с нижними подчеркиваниями)
    def __init__(self,d=1, color='желтый'):
        #Поля класса
       self.diametr = d
       self.color=color

  # Методы класса - привязаны к объектуб рассказывают о нем
    def info(self):
        print('Мяч имеет цвет:', self.color)
        print('Мяч имеет размер:', self.diametr)

ball1=Ball(5, 'Красный') #ball1- экземпляр класса Ball1
ball2=Ball(20, 'Синий' )
ball3=Ball()
ball4=Ball()

print(id(ball1))
print(id(ball2))
print(id(ball3))
print(id(ball4))


ball1.info()
ball2.info()
ball3.info()
ball4=Ball()

#print(ball1.color, ball1.diametr)
#print(ball2.color, ball2.diametr)

