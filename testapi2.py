from requests import get, post, delete

#тест REST на GET
print(get('http://127.0.0.1:5000/api/v2/news').json())
print(get('http://127.0.0.1:5000/api/v2/news/5').json())

res= get('http://127.0.0.1:5000/api/news/').json()
if res.get ('error', None): # метод словаря get возвращает None, если значения ключа нет
    print(res['error'])
else:
    print(res['news']['content'])
    print(res['news']['user_id'])

#тест REST на POST
#print(post('http://127.0.0.1:5000/api/news',json={}).json())
#print(post('http://127.0.0.1:5000/api/news', json={'title':'Заголовок'}).json())
#print(post('http://127.0.0.1:5000/api/news',
#           json={'title': 'Заголовок через API3',
#                 'content': 'Текст3',
#                 'user_id': 3,
#                 'is_private': False
#                 }).json())

#Rest API удаление новости
#print(delete('http://127.0.0.1:5000/api/news/8').json())
#проверка
#print(delete('http://127.0.0.1:5000/api/news/8').json())

#тест REST на POST версия 2
print(post('http://127.0.0.1:5000/api/v2/news',json={}).json())
print(post('http://127.0.0.1:5000/api/v2/news', json={'title':'Заголовок'}).json())
print(post('http://127.0.0.1:5000/api/v2/news',
           json={'title': 'Заголовок через API7',
                 'content': 'Текст7',
                 'user_id': 7,
                 'is_private': False
                 }).json())

# Версия 2 на DELETE
#print(delete('http://127.0.0.1:5000/api/v2/news/6').json())
#print(delete('http://127.0.0.1:5000/api/v2/news/8').json())