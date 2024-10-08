# спец методы

#private __
#public
#protected_
class Man:
    #спец методы ( с нижними подчеркиваниями)

    def __init__(self, name='noname', age=0): #конструктор объекта
        #Поля класса
       self.name = name #инкапсулируются в MAN
       self.age = age
       self.non_legal_name=['Васёк']

  # Методы класса - привязаны к объектуб рассказывают о нем
    def info(self):
        print(f'{self.name}, возрастом {self.age}')


# Сеттер (setter) #задают новые значения полям класса при проведения
    def set_age(self,new_age):

        if new_age<0:
            self.age = -new_age
        else:
            self.age = new_age


    def set_name(self, new_name):
        if new_name not in self.non_legal_name:
            self.name = new_name
        print('Имя недопустимо, замены не было.\n' 'список запрещенных имен', end=':')
        self.print_non_legal_name()
    def print_non_legal_name(self):
        print(*self.non_legal_name, sep=',')
# Геттеры
    def get_name(self):
        return self.name
   # def get_age(self):
   #     return self.age



dima =Man('Дима',17) #man1- экземпляр класса Man1
dima.set_name('Васёк')
dima.set_age(-18)
#dima.info()
name=dima.get_name()
print(name)
#name=dima.get_age()
#print(age)

max=Man('Максим', 10)
max.info()

