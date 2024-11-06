# справочная вокзала

trains={
    '001A': ['Красная стрела', 'Москва - СПб', '23:35'],
    '025B': ['Смена', 'Москва - Воронеж', '20:47'],
}

while True:
    num = input('Введите номер поезда (или "стоп" для выхода) :').strip().upper()
    if num == 'СТОП' or num =='CNJG':
        break


    if num not in trains:
        print('Такого номера нет.')
        for k, v in trains.items():
            print(f'{k}-{v[1]}')
    else:
            print(f'Поезд{num} {trains[num][0]} маршрут:{trains[num][1]}. '
                  f'Отправляется в {trains[num][2]}.')