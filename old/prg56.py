#Обработка исключений
# Try (начало обработки) выполняется попытка какого либо действия
# except (собственно обработчик) исключение обрабатывается
# finnally программа продолжается с этого места не зависимо от того, было исключение или нет
# else если не было исключения

def divide():
    a = input('Введите А:')
    b = input('Введите В:')
    try:
        temp=float(a)/float(b)
        return temp
    except ZeroDivisionError:
        return 'Не делите на ноль'
    except ValueError:
        return 'Нужно вводить только числа'
    except Exception as exp:
        return f'Вот такое вот: {exp} '
    return a / b
print(divide())
