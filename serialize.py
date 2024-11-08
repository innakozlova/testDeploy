import pickle

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
#print(pets_info['pets'][1]['pet'])

#with open('data.pickle','wb') as f:
#    pickle.dump(pets_info, f)

with open('data.pickle', 'rb') as f:
    data=pickle.load(f)

    print(data)