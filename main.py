from flask import Flask, url_for

app = Flask(__name__)


@app.route('/')
@app.route('/index')
def index():
    return 'Привет, я приложение  Flask!'

#http://localhost:5000/countdown
@app.route('/countdown')
def countdown():
    cl=['Cтарт']
    cl+=[str(x) for x in reversed(range(11))]
    cl.append('Финищ')
    return '<br>'.join(cl)

@app.route('/contacts')
def contacts():
    return""" <b>E-mail: </b> inkys@yandex.ru<br> 
    <a href ='/'> Контакты в Санкт-Петербурге </a>"""

#Статический контент в папке static
# Все изображения static/images
#Таблицы стилей static/css
#Файлы для скачивания
#Шрифты static/fonts
#Файлы JS- cценариев static/js
#Музыка,видео
# для удобства пользуемся url_for
@app.route('/img/<num>')
def show_img(num=''):
    """

    :param num: по умолчанию строка
    <int:num> -целое число
    <float:num> - действительное число
    <path:num> -строка со слешами для URL
    <uuid:num> - идентификатор в 16-м представлении
    :return: путь к картинке
    """
    if num !=0:
        return f"""
         <h1>Python</h1>
          <img src="{url_for('static', filename=f'images/python-{num}.jpeg')}">
          """
#http://localhost:5000/two-params/Victor/12
@app.route('/two-params/<username>/<int:number>')
def two_params_func(username, number):
    param=100+number
    return f"""
   <h1>Пользователь {username}</h1>
   <h2>Номер в системе {param}</h2> 
   """
if __name__ == '__main__':
    app.run(port=5000, host='127.0.0.1')
