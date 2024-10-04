# Функции инкапсуляция
# Области видимости
# Global scope -глобальные
# print(b)
b = 5


def calc(x: int = 1, y: int = 0) -> int:
    # local scope - локальные
    a = 3
    res = 2 * x + y + a
    return res

def multy(*args: int)->int:
    """
    Функция вычисления произведения переменного числа аргументов
    :param args: ноль или несколько целых
    :return: произведение аргументов
    """
    if len(args)==0:
        return 0  # число аргументов равно нулю, возвращается 0
    if len(args)==1:
        return args[0] #возвращаем первое значение
    res=1
    for i in range (len(args)): # крутим по длине ряда
        res *=args[i]
    return res


def increment():
    global b
    b += 1

print(multy(2,10,5,5,10))
increment()
result = calc(b)
#garbage collector
print(result)

