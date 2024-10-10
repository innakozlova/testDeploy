#GUI - Graphic User Interface

#PyQt6
import tkinter
from PIL import Image, ImageTk

class App:
    def __init__(self):
        self.root = tkinter.Tk()

        #рабочая область
        self.frame=tkinter.Frame(self.root)
        self.frame.grid()


        #добавляем ярклык
        self.label=tkinter.Label(self.frame, text='GUI').grid(row=1,column=1) # поставим ярлык в первую колонку и первый ряд на сетке
        self.but=tkinter.Button(self.frame, text= 'Заменить', command=self.change).grid(row=2, column=2)

        #добавим кнопку
        self.canvas = tkinter.Canvas(self.root, height=300, width=300)

        #Добавляем изображение на холст
        self.image = Image.open('original.png')
        self.photo = ImageTk.PhotoImage(self.image)
        self.canvas.grid(row=2, column=1)
        self.image = self.canvas.create_image(0,0, anchor='nw', image=self.photo)  # якорь северо-запад
        self.root.mainloop() #ожидание действий пользователя

    # Метод change
    def change(self):
        print('Кнопка нажата')
        self.image = Image.open('blur.png')
        self.photo = ImageTk.PhotoImage(self.image)
        self.canvas.create_image(0, 0, anchor='nw', image=self.photo)  # якорь северо-запад
        self.canvas.grid(row=2, column=1)

app=App()