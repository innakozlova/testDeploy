# Глобальные функции
first =3
second=4
third=2

def summ(a,b):
    """
    :param a: любое
    :param b: число
    :return: сумма
    """

    try:
        res= a+b
    except TypeError:
        return ('Складываю только числа')
    else:
        return res


print(summ(first,second))

def sub(a, b):
    """

    :param a: любое
    :param b: число
    :return: результат вычитания
    """

    try:
        res = a - b
    except TypeError:
        return('Вычитаю только числа')
    else:
        return res

print(sub(first, second))

def multi(a, b):
    """

    :param a: любое
    :param b: число
    :return: результат умножения
    """

    try:
        res = a * b
    except TypeError:
        return('Умножаю только числа')
    else:
        return res

print(multi(first, second))

def divide(a, b):
    """

    :param a: любое
    :param b: число
    :return: результат деления
    """

    try:
        res = a / b
    except TypeError:
        return('Делю только числа')
    except ZeroDivisionError:
        return ('На ноль делить нельзя')
    else:
        return res

print(divide(first, second))