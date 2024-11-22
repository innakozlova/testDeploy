import datetime
import configparser
from flask import Flask, url_for, request, render_template, make_response, session, abort, jsonify
from flask import redirect, flash
from flask_login import LoginManager, login_user, logout_user, login_required
from flask_login import current_user
from mail_sender import send_mail
from forms.loginform import LoginForm
from mailform import MailForm
from werkzeug.utils import secure_filename
import json, os
from data import db_session
from data.users import User
from data.news import News
from forms.add_news import NewsForm
import news_api
import our_resources
from flask_restful import Api

import requests
from forms.user import RegisterForm


MS1 = 'http://127.0.0.1:5000/api/news'


current_directory=os.path.dirname(__file__)
UPLOAD_FOLDER=f'{current_directory}/static/uploads'
ALLOWED_EXTENTIONS={'txt','pdf','png','jpg','jpeg','gif'}


app = Flask(__name__)
api=Api(app) # регистрация нашего микросервиса
login_manager=LoginManager()
login_manager.init_app(app) #привязали менеджер авторизации к приложению

app.config['SECRET_KEY'] = 'too_short_key'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['PERMANENT_SESSION_LIFETIME']=datetime.timedelta(days=365)

config = configparser.ConfigParser()  # объект для обращения к ini


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENTIONS


@app.errorhandler(400)
def http_400_handler(_):
    return make_response(jsonify({'error': 'Новость не найдена'}), 400)
#обработка ошибки сервера 401
#пользователь не авторизован для просмотра данной страницы
@app.errorhandler(401)
def http_401_handler(error):
    return render_template('error401.html', title='Требуется аутентификация')

@app.errorhandler(404)
def http_404_handler(error):
    return make_response(jsonify({'error': 'Новость не найдена'}), 404)
# def http_404_handler(error):
#    return render_template('error404.html', title='Страница не найдена')

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

@login_manager.user_loader
def user_loader(user_id):
    db_sess=db_session.create_session()
    return db_sess.get(User, user_id)


@app.route('/session_test')
def session_test():
    visit_count=session.get('visit_count', 0)
    session['visit_count']=visit_count+1
    #visit_count % 3 - 0,1,2  номер новости или контента в зависимости от visit count
    #session.pop('visit_count', None) # если надо программно уничтожить сессию
    return make_response(f'Вы посетили данную страницу {visit_count} раз')

@app.route('/cookie_test')
def cookie_test():
    visit_count=int(request.cookies.get('visit_count',0))
    if visit_count:
        res=make_response(f'Вы посетили данную страницу {visit_count +1} раз')
        res.set_cookie('visit_count', str(visit_count+1), max_age=60*60*24*365*2)
    else:
        res=make_response('За последние 2 года вы посетили данную страницу впервые.')
        res.set_cookie('visit_count','1', max_age=60*60*24*365*2)
       # res.set_cookie('visit_count', '1', max_age=0) удаляем cookies
    return res

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

#тестируем наш API
@app.route('/apitest')
def api_test():
    res = requests.get(MS1).json()
    return render_template('apitest.html', title='Тестируем наш первый API', news=res['news'])

@app.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect('/')
    form = RegisterForm()
    if form.validate_on_submit():
        if form.password.data !=form.password_again.data:
            return render_template('register.html', title='Регистрация', form=form, message='Пароли не совпадают')
        db_sess= db_session.create_session()
        if db_sess.query(User).filter(User.email == form.email.data).first():
            return render_template('register.html', title='Регистрация', form=form, message=f'Пользователь с Email {form.email.data} уже зарегистрирован')
        user = User(
            name=form.name.data,
            email=form.email.data,
            about=form.about.data
        )
        user.set_password(form.password.data)
        db_sess.add(user)
        db_sess.commit()
        return redirect('/login')
    return render_template('register.html', title='Регистрация', form=form)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect('/')
    form = LoginForm()
    if form.validate_on_submit():
        db_sess = db_session.create_session()
        user = db_sess.query(User).filter(User.email == form.email.data).first()
        if user and user.check_password(form.password.data):
            login_user(user, remember=form.remember_me.data)
            return redirect('/')  # request.url либо на нужную страницу
        return render_template('login.html', title='Ошибка авторизации', message='Неправильная пара: логин-пароль!',
                               form=form)
    return render_template('login.html', title='Авторизация', form=form)
@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('/')


@app.route('/add', methods=['GET','POST'])
@login_required
def add_news():
    form = NewsForm()
    if form.validate_on_submit():
        db_sess = db_session.create_session()
        news = News()
        news.title = form.title.data
        news.content = form.content.data
        news.is_private = form.is_private.data
        current_user.news.append(news)
        db_sess.merge(current_user)
        db_sess.commit()
        return redirect('/blog')
    return render_template('add_news.html', title='Добавление новости', form=form)

@app.route('/blog/<int:id>', methods=['GET','POST'])
@login_required
def edit_news(id):
    form = NewsForm()
    if request.method =='GET':
        db_sess=db_session.create_session()
        news=db_sess.query(News).filter(News.id == id, News.user == current_user).first()

        if news:
            form.title.data=news.title
            form.content.data=news.content
            form.is_private.data=news.is_private
            form.submit.data='Отредактировать'
        else:
            abort(404)

    if form.validate_on_submit():
        db_sess = db_session.create_session()
        news = db_sess.query(News).filter(News.id == id, News.user == current_user).first()

        if news:
            news.title = form.title.data
            news.content =  form.content.data
            news.is_private = form.is_private.data
            db_sess.commit()
            return redirect('/blog')
        else:
            abort(404)
    return render_template('add_news.html', title='Редактирование новости', form=form)

@app.route('/news_delete/<int:id>', methods=['GET','POST'])
@login_required
def news_delete(id):
    db_sess=db_session.create_session()
    news=db_sess.query(News).filter(News.id == id, News.user == current_user).first()

    if news:
        db_sess.delete(news)
        db_sess.commit()
    else:
        abort(404)
    return redirect('/blog')

@app.route('/success')
@login_required
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
    params={}
    if form.validate_on_submit():
        name = form.username.data
        params['name'] = name
        phone = form.phone.data
        params['phone'] = phone
        email = form.email.data
        params['email'] = email
        message = form.message.data
        params['message'] = message
        params['page'] = request.url

        text=f""" Пользователь {name} оставил Вам сообщение:
        {message}.
        Его телефон {phone},
        Email: {email},
       # Страница:{request.url}.
        """

        text_to_user = f""" 
        Уважаемая {name} !
                Ваши данные:
                Его телефон {phone},
                Email: {email},
                успешно по получены.
                Ваше сообщение: {message} принято к рассмотрению.
                Страница:{request.url}.
        """
        send_mail('pochtovy@rambler.ru', 'Запрос сайта', text_to_user)
        send_mail('inkys@yandex.ru', 'Запрос сайта', text)


        return render_template('mailresult.html', title='Ваши данные', params=params)

    return render_template('contacts.html', title='Наши контакты', form=form)
@app.route('/aboutus')
def aboutus():
    return render_template('aboutus.html', title='О нас')


@app.route('/blog')
def blog():
    #if current_user.is_admin()
    #else Доступа нет
    db_sess = db_session.create_session()
    news = db_sess.query(News).filter(News.is_private != True)
    return render_template('blog.html', title='Новости', news=news)

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
#

if __name__ == '__main__':
    db_session.global_init('db/blogs.db')
    # прописываем blueprint в основное приложение
    app.register_blueprint(news_api.blueprint)
    #прописываем доступ к отдельной новости по RESTful API v2
    api.add_resource(our_resources.NewsResource, '/api/v2/news/<int:news_id>')
    # прописываем доступ ко всем новостям по RESTful API v2
    api.add_resource(our_resources.NewsResourceList, '/api/v2/news')
    app.run(port=5000, host='127.0.0.1')


  #  db_sess = db_session.create_session()
#News create
   # news = News(title="Срочная новость", content="срочная новость", user_id = 1, is_private = False)
   # db_sess.add(news)
   # db_sess.commit()

#Read news
   # news=db_sess.query(News).filter(News.user_id==1).first()
   # print(news.title, news.content)
    #Read user
   # result = db_sess.query(User).first() только первая запись из запроса
   # result = db_sess.query(User).all()
   # result = db_sess.query(User).filter(User.id>1, User.about.like ("%четвертая%"))
   # for user in result:
    # print(user.name, user.email)

    #Update user
   # result = db_sess.query(User).filter(User.id==4).first()
  #  result.name='User22'
   # result.created_date=datetime.datetime.now()
  #  db_sess.commit()
   # print(result.email)

    #Create user
  #  user=User()
  #  user.name='User2'
  #  user.about='второй пользователь нашей БД'
  #  user.email='email2@email.ru'
  #  db_sess= db_session.create_session()
  #  db_sess.add(user)
  #  db_sess.commit()

    #Delete user
   # db_sess.query(User).filter(User.id > 1).delete()
   # db_sess.query(User).filter(User.id==2).delete()
   # db_sess.commit()

#   app.run(port=5000, host='127.0.0.1')
