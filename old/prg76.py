#csv - значения, разделенные запятыми (разделитель ;)

#a=[0,1,2]*5
#print(a)

#a=[[0,1,2],[4,5,6],[7,8,9]]
#print(a[2][1])

#a = [[x for x in range(i, 13, 4)] for i in range(1, 5)]
#print(a)

with open ('Personal.csv', encoding='utf-8') as f:
    text=f.read()

table=[r.split(';') for r in text.split('\n')]
print(table[2][1])

