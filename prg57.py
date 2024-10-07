while True: # бесконечный цикл4
    try:
       int_val=int(input('Введите целое число: '))
       print(f'Вы успешно ввели число: {int_val}')
       break

    except ValueError: #ошибка в значении
      print('Нужно вводить только числа')
      print('попробуйте снова')
