from flask import Flask, url_for, request, render_template
from flask import redirect, flash
#from mail_sender import send_mail
from loginform import LoginForm
from mailform import MailForm
from werkzeug.utils import secure_filename
import json, os
import configparser
import requests

current_directory=os.path.dirname(__file__)
UPLOAD_FOLDER=f'{current_directory}/static/uploads'
ALLOWED_EXTENTIONS={'txt','pdf','png','jpg','jpeg','gif'}


app = Flask(__name__)
app.config['SECRET_KEY'] = 'too_short_key'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

config = configparser.ConfigParser()  # объект для обращения к ini


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENTIONS

@app.route('/')
@app.route('/index')
def index():
    param={}
    param['text']='Этот текст отобразится на главной странице'
    param['title']='Главная'
    return render_template('index.html', **param)
  #  return render_template('index.html', title='Главная', content=content)
  #  return """
   #  <a href ="/index"> Главная</a> | <a href ="/contacts">Контакты</a>| <a href ="/img/1">Картинка 1</a>
    # | <a href ="/img/2">Картинка 2</a>
    #"""
#    'Привет, я приложение  Flask!'

@app.route('/weather', methods=['GET', 'POST'])
def weather():
    if request.method == 'GET':
        return render_template('weather.html', title='Погода', form=None) #форма с городом
    elif request.method == 'POST':
        config.read('settings.ini')
        #return render_template('weather.html', title='Погода в городе', form=request.form) #обращение к API openweathermap
        city= request.form['city']
        if len(city) <2:
            flash('Город введен не полностью')
            return redirect(request.url)
        key = config['Weather']['key']

        res = requests.get('http://api.openweathermap.org/data/2.5/find',
                           params={'q': city, 'type': 'like', 'units': 'metric', 'APPID': key})

        data = res.json()

        temp = data['list'][0]['main']
        params = {}
        params['temper'] = temp['temp']
        params['press'] = temp['pressure']
        params['humid'] = temp['humidity']

        return render_template('weather.html', title=f'Погода в {city}', form=request.form, params=params)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        return redirect('/success')
    return render_template('login.html', title='Авторизация', form=form)

@app.route('/success')
def success():
    return 'Успех'
@app.route('/pets')
def pets():
    with open("pets.json", "rt", encoding="utf-8") as f:
        pets_list = json.load(f)
    print(pets_list)
    return render_template('pets.html', pets=pets_list, title='Питомцы')
@app.route('/upload', methods=['GET','POST'])
def upload_file():
    if request.method =='GET':
        return render_template('upload.html', title='Выбор файла', form=None)
    elif request.method =='POST':
        if 'file' not in request.files:
            flash('Файл не был найден')
            return redirect(request.url)
        file = request.files['file']
        if file.filename=='':
            flash('Файл не был отправлен')
            return redirect(request.url)
        if not allowed_file(file.filename):
            flash('Загрузка файлов данного типа запрещена')
        if file:
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return render_template('upload.html', title='Файл загружен', form=True)
@app.route('/quere')
def quere():
    return render_template('quere.html', title='Очередь')

@app.route('/odd_even/', defaults={'num':0})
@app.route('/odd_even/<int:num>')
def odd_even(num):
    return render_template('index.html', num=num, title='Четное или нечетное')

#http://localhost:5000/countdown
@app.route('/countdown')
def countdown():
    cl=['Cтарт']
    cl+=[str(x) for x in reversed(range(11))]
    cl.append('Финищ')
    return '<br>'.join(cl)


@app.route('/contacts', methods=['GET', 'POST'])
def contacts():
    form = MailForm()
    if form.validate_on_submit():
        return redirect('/success')
    return render_template('contacts.html', title='Наши контакты', form=form)
@app.route('/aboutus')
def aboutus():
    return render_template('aboutus.html', title='О нас')

#Статический контент в папке static
# Все изображения static/images
#Таблицы стилей static/css
#Файлы для скачивания
#Шрифты static/fonts
#Файлы JS- cценариев static/js
#Музыка,видео
# для удобства пользуемся url_for
@app.route('/img/', defaults={'num': None})
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
    if num:
        return f"""
         <h1>Python</h1>
          <img src="{url_for('static', filename=f'images/python-{num}.jpeg')}"><br><a href ="/index"> Назад на главную</a>
          """
    else:
        return f"""
                 <h1>Здесь ничего нет</h1>
                  <img src="{url_for('static', filename='images/python.jpeg')}"><br><a href ="/index"> Назад на главную</a>
                  """


#http://localhost:5000/two-params/Victor/12
@app.route('/two-params/<username>/<int:number>')
def two_params_func(username, number):
    param=100+number
    return f"""
   <h1>Пользователь {username}</h1>
   <h2>Номер в системе {param}</h2> 
   """

#методы:
#GET -запрашивает информацию с сервера, не меняя его состояния
#POST- отправляет данные на сервер для обработки
#PUT - заменяет текущие данные на сервере данными запроса (insert)
#PATCH -частичная замена данных на сервере (update)
#DELETE -удаляет указанные данные

@app.route('/form_sample', methods=['POST', 'GET'])
def form_sample():
    if request.method == 'GET':
        return render_template('form_sample.html', title='Заполните форму', form='None')
    elif request.method == 'POST':
        return render_template('form_sample.html', title='Ваши данные', form=request.form)



      #  print(request.form['email'])
       # print(request.form['password'])
       # print(request.form['profession'])
       # return 'Форма успешно отправлена'

if __name__ == '__main__':
    app.run(port=5000, host='127.0.0.1')
