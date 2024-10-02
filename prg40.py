
s='Python'
#s=(255,128,64)
print(len(s))
lst= ['бремя', 'время', 'стремя']

#result=sorted(s)
#temp=list(enumerate(lst))
for item in enumerate(lst):
    print(item)
#print(result)
print ('существительные:')
for index, value in enumerate(lst):
    print(f'\t{index+1}.{value}')

