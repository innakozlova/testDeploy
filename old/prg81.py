#Декораторы
import time
def decoration(func):  #ничего не декорирует
    def wrapper(): #обертка
        origin=func()
        modified=origin+' декоратор'
        return modified
    return wrapper # вызов внутри обертки

def time_measure(func):
    def wrapper():
        start=time.time()
        func()
        end=time.time()
        print(f'Затраченное время: {end-start}')
    return wrapper #не как функцию, а как объект

@time_measure
def say_hello():
    return 'Hello'

@time_measure
def make_list():
    a=[i for i in range(5000000)]
    return a
make_list()
#greet=no_decoration(say_hello)

#print(say_hello())
