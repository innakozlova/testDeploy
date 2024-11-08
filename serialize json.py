import json

pets_info={
    'pets': [
        { 'pet': 'dog',
        'name': 'Reks',
          'food':'Purina',
          'age': 4
          },
        {
          'pet':'cat',
            'name':'Matilda',
            'food': 'Whiskas',
            'age': 3
        }
    ]
}
#print('pets.json','w')

#with open('pets.json','w') as f:
#    json.dump(pets_info, f)

# десериализация json
with open('pets.json','r') as f:
   temp=json.load(f)

print(temp)

#with open('data.pickle', 'rb') as f:
 #   data=pickle.load(f)

  #  print(data)