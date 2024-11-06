# доп библиотека PIL PILLOW
from PIL import Image, ImageFilter, ImageDraw

# пробуем прочитать файл original.png
try:
    orig= Image.open('original.png')
except FileNotFoundError:
    print('Файл не найден')

print('параметры считанного файла:')
print(f'Формат:{orig.format}')
print(f'Размеры: {orig.size}') #кортеж
print(f'Цветовая схема:{orig.mode}')

w,h = orig.size # получили и распоковали кортеж
pixels = orig.load() # загрузить список пикселей
r,g,b = pixels[200,200]

for x in range(w):
    for y in range(h):
        r, g, b = pixels[x, y]
        average = (r + g + b) // 3
        print[x, y] = average, average, average

orig.save=('grayscale.png')



blur = orig.filter(ImageFilter.GaussianBlur(1))
cropped = orig.crop((200,200,300,300 ))
contour = orig.filter(ImageFilter.CONTOUR)

cropped.save('cropped.png')
blur.save('blur.png')
contour.save('contour.png')

