s = 'ЯзыкПитон'

print(s.lower())

#res=input('Введите строку').lower()

print(s.upper())
print(s.capitalize())
print(s.title())
print(s.rstrip('Я'). lower())
print(s.count('к',3,6))
print(s.index('к',3,6))
print(s.find('к',6,3))
print(s.replace('и', 'е', 2))
print(s.startswith('Язык'))

if s.startswith('Язык'):  # is s[0:4]=='Язык'
    pass