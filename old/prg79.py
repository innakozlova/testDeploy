
import sqlite3
#Подключение (connection)
#connection=sqlite3.connect('films_db.sqlite')
#Создаем курсор
#cursor=connection.cursor()
#исполнение запроса
#result=cursor.execute("""select title from films where year =? and duration >?""", (2010,90)).fetchall(), (2010,90)).fetchall()
#result = cursor.execute("""
   #                     insert into genres(id,title)
    #                    values (12,'Жанр 12')"""
     #                   )
#подтверждаем все изменения в БД
#nconnection.commit()
#for item in result:
#    print(item)
#закрытие соединения с базой
#connection.close()

connection=sqlite3.connect('films_db.sqlite')
#Создаем курсор
cursor=connection.cursor()
#исполнение запроса
#result=cursor.execute("""select title from films where year =? and duration >?""", (2010,90)).fetchall(), (2010,90)).fetchall()
result = cursor.execute("""
                        update films set duration='282'
                        where title='Аватар'"""
                        )

choice = input('Вы действительно хотите обновить (Y/N:)')
if choice=='Y':
    connection.commit()
#подтверждаем все изменения в БД
#connection.commit()