#спецметоды
# полиморфизм

class Square:
    def __init__(self, s=1):
        self.side = s

    def area(self):
        return self.side * self.side

    def perimeter(self):
        return float (round(self.side * 4), 2)

    def __str__(self): #строковое представление того, что получилось
        return f'Это квадрат со стороной {self.side}'

    def __eq__(self, other):  # сравнение объектов
        return self.side==other.side

    def __gt__(self, other):
        return self.side > other.side

    def __add__(self, other):
        return Square(self.side+other.side)

    def __sub__(self, other):
        return Square(self.side-other.side) # констурирование нового объекта типа Square
    def __del__(self): # удаление объектов, программа живет, пока не начал работу del
        print(f'квадрат со стороной {self.side} стёрт')

    def __repr__(self): # для сложных объектов вместо str
        return f'Квадрат со стороной {self.side}'

sq1=Square(5)
sq2=Square(4)
complex_sq = [Square(2), Square(3)] # комплексный объект со сторонами 2 и 3
print(complex_sq)
square=sq1-sq2
print(square)
print(sq1)
#print(sq1==sq2)
#print(sq1 >=sq2)