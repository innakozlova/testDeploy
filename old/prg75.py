# r строка (raw - "сырая строка, где управляющие последовательности игнорируются" escape sequence)
import re # reqular expressions (поиск по образцу)

pattern ='20'
test_string ='10 плюс 20 будет 30'
result = re.search(pattern, test_string)
#r'C:\\Program\word.exe'

print(result)

pattern=r'\b\w{4}\b'
test_string ='10 плюс 20 буд_ 30'
result = re.findall(pattern, test_string)
print(result)

pattern=r'\d{3}'
test_string ='10 плюс 200 буд_ 30'
result = re.findall(pattern, test_string)
print(result)

pattern=r'[0-5][0-9]' #группировка
test_string ='07:45'
result = re.findall(pattern, test_string)
print(result)

#отрицание
pattern='[^абвгд0]'
test_string ='Время 07:45'
result = re.findall(pattern, test_string, re.I)
print(result)

#{m,} не менее - {,m} не более m раз
pattern=r'\+7\d{10}'
test_string ='google phone +71234567890'
result = re.findall(pattern, test_string)
print(result)

pattern='стеклянн?ый'  # вторая буква может присутствовать, но не обязательно
test_string ='стекляный, стеклянный, олявянный, деревянный, серебряный'
result = re.findall(pattern, test_string)
print(result)

pattern='<img.*>'
test_string ='Картинка <img src ="bg.jpg"> в тексте </p>'
result = re.findall(pattern, test_string)
print(result)

pattern='<img.*?>'
test_string ='Картинка <img src ="bg.jpg"> в тексте </p>'
result = re.findall(pattern, test_string)
print(result)

pattern = '<img[^>]+src="([^">]+)"'
test_string = 'Картинка <img src ="bg.jpg"> в тексте </p>'
result = re.findall(pattern, test_string)
print(result)
