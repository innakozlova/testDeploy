#Обработка исключений

def divide():
    a = input('Введите А')
    b = input('Введите В')
    try:
        temp=float(a)/float(b)
        return temp
    except ZeroDivisionError:
        return 'Не делите на ноль'
    except ValueError:
        return 'Нужно вводить только числа'
    return a / b
print(divide())
