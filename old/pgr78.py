# CRUD Create Read(Retrieve) Update Delete

#PEP 249 (connection, cursor)

import sqlite3
#Подключение (connection)
connection=sqlite3.connect('films_db.sqlite')
#Создаем курсор
cursor=connection.cursor()
#исполнение запроса
#result=cursor.execute("""select title from films where year =? and duration >?""", (2010,90)).fetchall(), (2010,90)).fetchall()
result = cursor.execute("""select title from films where genre=(select id from genres where title=?)""",
                        ('фантастика')).fetchall()

for item in result:
    print(item)
#закрытие соединения с базой
connection.close()