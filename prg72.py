# Syntax Sugar (синтаксический сахар)
#списочные выражения (list comprehensions)
# [выражение for переменная in  источник if условие]

a=[i for i in range(1,11)]
print(a)

a=[i*i for i in range(1,11)]
print(a)

ipaddress='192.168.0.1'
#s= ipaddress.split('.')
#a=map(int,s)
#print(s)

a=[int(i) for i in ipaddress.split('.') if int(i)>0]
print(a)

#b=[i for i in range(0,2,10)]
b=[i for i in range(2,11,2)]
print(b)

greet='Hello World'
c=[i for i in greet if i.isupper()]
print(c)

d=[(pos,char) for pos, char in enumerate(greet)]
print(d)



#lambda a,b: a+b
#def ala lambda(a,b):
#return a+b

# функция высшего порядка map и filter
#users =[
 #   {'name': 'Igor','age':25},
  #  {'name': 'Vova','age':5},
  #  {'name': 'Matew','age':16},
   # {'name': 'Ivan','age':11},
#]
#filtered_users=filter(lambda u: 6< u['age']<16, users)
#print(list(filtered_users))


