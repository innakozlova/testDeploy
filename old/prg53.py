# Функция (encapsulation -инкапсуляция)
# Описание функции
def odd_even(num: int) -> str:
    """
    Функция, возвращающая чёт или нечёт
    :param num:
    :return:
    """
    if not isinstance(num, int):
        return 'Ну ты даешь'
    if num % 2:
      return 'нечёт'
    return 'чёт'

# вызов
res = odd_even('3')
print(res)
