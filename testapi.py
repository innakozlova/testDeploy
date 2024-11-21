from requests import get, post

#тест REST на GET
print(get('http://127.0.0.1:5000/api/news').json())
print(get('http://127.0.0.1:5000/api/news/1').json())

res= get('http://127.0.0.1:5000/api/news/ук').json()
if res.get ('error', None): # метод словаря get возвращает None, если значения ключа нет
    print(res['error'])
else:
    print(res['news']['content'])

#тест REST на POST
print(post('http://127.0.0.1:5000/api/news',json={}).json())

print(post('http://127.0.0.1:5000/api/news', json={'title':'Заголовок'}).json())

print(post('http://127.0.0.1:5000/api/news',
           json={'title': 'Заголовок через API',
                 'content': 'Текст',
                 'user_id': 1,
                 'is_private': False
                 }).json())