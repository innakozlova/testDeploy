#pyTelegramBotAPI
#aiogpram

token ='8135470075:AAFw0XUWEWjdBY4bqjf79FKOvAnc3KfWTyU'

import telebot
from telebot import types


bot=telebot.TeleBot(token)

kb=types.ReplyKeyboardMarkup(row_width=2) #кнопки будут по 2 в ряд
btn1=types.KeyboardButton('🧠 Привет')
btn2=types.KeyboardButton('😀 Как дела')
kb.add(btn1, btn2)

@bot.message_handler(commands=['start'])
def start_message(message):
    bot.send_message(message.chat.id, 'Я запустился и готов повторять за вами', reply_markup=kb)

@bot.message_handler(commands=['help'])
def help_message(message):
    bot.send_message(message.chat.id, 'Я просто эхо')

@bot.message_handler(commands=['url'])
def url(message):
    markup = types.InlineKeyboardMarkup()
    btn_site = types.InlineKeyboardButton(text='Наш сайт', url='https://ipap.ru')
    markup.add(btn_site)
    bot.send_message(message.chat.id, "Перейти на сайт", reply_markup=markup)

@bot.message_handler(content_types=['text'])
def carrot(message):
    if message.text =='Привет':
        bot.send_message(message.chat.id, '🧠 О, Привет')
    elif message.text =='Как дела?':
        #bot.send_message(message.chat.id, '👍')
        answer = types.InlineKeyboardMarkup(row_width=2)
        btn_good = types.InlineKeyboardButton('Хорошо', callback_data='good')
        btn_bad = types.InlineKeyboardButton('Плохо', callback_data='bad')
        answer.add(btn_good, btn_bad)
        bot.send_message(message.chat.id, 'У меня норм, а у тебя?', reply_markup=answer)
    else:
        bot.send_message(message.chat.id, message.text)  # куда пишем, что отвечает

@bot.callback_query_handler(func=lambda call: True)
def callback_inline(call):
    try:
        if call.message=='good':
             bot.send_message(call.message.chat.id, 'Рада за тебя')
        if call.message=='bad':
             bot.send_message(call.message.chat.id, 'Всё наладится')
    except Exception as e:
        print(repr(e))

if __name__ == '__main__':
    bot.infinity_polling()

