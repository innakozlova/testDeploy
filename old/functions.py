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

#if __name__ == '__main__':
    print('не запускай меня', Это библиотека функции)

