
def f_open(name:str)-> str:

    """
    Читает текстовый файл и возвращает его содержимое
    :param name: имя файла на чтение
    :return: содержимое файла
    """

    try: # пробует выполнить, если все нормально
        with open(name, encoding='UTF-8') as f:  # по умолчанию режим rt, чтение текста
           return f.read()
    except FileNotFoundError: # если файл не найден, ошибка может быть
        with open(name, 'w', encoding='UTF-8') as f:
            f.write('Файл был заново создан')
        return f'Файл {name} не существует или удалён'


res=f_open('asample.txt')
print(res)
