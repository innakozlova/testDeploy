# Классы фигур с учетом наследования
# Родительский класс (superclass) (базовый)
# Дочерний (производный, наследник) класс

from math import pi

class Rectangle:
    def __init__(self, w, h):
        self.width = w
        self.height = h

    def area(self):
        return self.width * self.height

    def perimeter(self):
        return round((self.width + self.height) * 2, 1)

    #Геттер
    def get_width(self):
        return self.width

    def get_heigth(self):
        return self.height

    #CЕттер
    def set_width(self, new_w):
       self.width = new_w

    def set_heigth(self, new_h):
        self.height = new_h

    def __str__(self):  # строковое представление того, что получилось
        return f'Это квадрат со стороной {self.side}'

    def __eq__(self, other):  # сравнение объектов
        return self.side == other.side

    def __gt__(self, other):
        return self.side > other.side

    def __add__(self, other):
        return Square(self.side + other.side)

    def __sub__(self, other):
        return Square(self.side - other.side)  # констурирование нового объекта типа Square

    def __del__(self):  # удаление объектов, программа живет, пока не начал работу del
        print(f'квадрат со стороной {self.side} стёрт')

    def __repr__(self):  # для сложных объектов вместо str
        return f'Квадрат со стороной {self.side}'


class Square(Rectangle): #  базовый класс прямоугольника
    def __init__(self, s = 1):
        super().__init__(s, s) # конструктор Квадрата
        self.side = s # сторона квадрата


class Circle:
    def __init__(self, r):
        self.radius = r

    def area(self):
        return pi * self.radius ** 2

    def perimeter(self):
        return round(2 * pi * self.radius, 2)



