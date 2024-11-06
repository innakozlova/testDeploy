
#d = {
#    'стул': 'chair',
#    'стол': 'table',
#    'яблоко': 'apple',
#    'меню': ['суп', 'тефтели', 'чай']
#}
#rus = ''

d={} # аполнять будем из файла dict.dat
with open('dict.dat', encoding='UTF-8') as fo:
    line= fo.readline().rstrip('\n')
    while line != '':  # если строка существует
        k, v, = line.split('|')
        d[k] = v
    line = fo.readline().rstrip('\n')

rus = input('Введите слово на русском языке для перевода (или "q" для выхода): ').strip().lower()

while rus != 'q':


  #  if rus=='q':
   #     print('Приятно было пообщаться!')
    #    break

    if rus in d:
        print(f'Слово "{rus}" переводится как "{d[rus]}"')
    else:
        print(f'К сожалению, я не знаю перевода слова "{rus}"')
        new_word = input(f'А как слово "{rus}" переводится: ')
        d[rus] = new_word
        print(f'Теперь я знаю перевод слова "{rus}". Это -"{d[rus]}"')

    rus = input('Введите слово на русском языке для перевода (или "q" для выхода): ').strip().lower()

print('Приятно было пообщаться!')