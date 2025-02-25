#создание класса для работы с БД class

import sqlite3

class DbRead:
    def __init__(self, db_name):
        if db_name=='':
            print('Введите имя базы!')
            return
        try:
            #Подключаемся
            self.db_name=db_name
            self.connection=sqlite3.connect(db_name)
            #Создаем курсор
            self.cursor=self.connection.cursor()
            print('Соединились с БД',db_name)
        except sqlite3.Error as e:
            print(f'Error:{e}')

    def read_all(self,query):
        """
:param query: запрос
:return: результат
"""
        return self.cursor.execute(query).fetchall()
    def __del__(self):
        #закрываем соединение
        print(f'Соединение с {self.db_name} закрыто')
        self.connection.close()

class DbWrite(DbRead):
    def __init__(self, db_name):
        if db_name=='':
            print('Введите имя базы!')
            return
        super().__init__(db_name)

    def data_insert(self,insert_query, insert_data):
        try:
            self.cursor.execute(insert_query, insert_data)
            self.connection.commit()
            print('Добавлено успешно!')
        except sqlite3.Error as e:
            print(f'Error:{e}')
    def data_delete(self, delete_query, delete_data):
        try:
            self.cursor.execute(delete_query,delete_data)
            choice = input('Вы действительно хотите обновить (Y/N:)')
            if choice == 'Y':
                self.connection.commit()
                print('Удалено')
        except sqlite3.Error as e:
            print(f'Error:{e}')

    def data_update(self, update_query, update_data):
            self.cursor.execute(update_query,update_data)
            choice = input('Вы действительно хотите обновить (Y/N:)')
            if choice == 'Y':
                self.connection.commit()
                print('Обновлено')



db=DbWrite('films_db.sqlite')
sql="""update genres set title='Научная фантастика' where id=25
"""

result=db.data_update(sql)

#for item in result:
 #   print(item)