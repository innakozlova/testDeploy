from PIL import ImageDraw, Image, ImageFont,

# создаем и рисуем
# 1 холст
canvas = Image.new("RGB",(200,200), (255,255,255))

#создаем рисовальщик
draw = ImageDraw.Draw(canvas)

#рисуем линию
draw.line((100,0,100,200), fill ='brown', width=5)
draw.line((0,100,200,100), fill ='brown', width=5)

draw.rectangle((0,0,200,200), outline= 'brown', width=3)
draw.ellipse((0,0,200,200), outline = 'brown', width=5)

# напишем текст
text = 'Окно'
f = ImageFont.truetype('arial.ttf', size=28)
draw.text((80, 90), text, f)

#рисуем полигон (треугольник)
#draw.polygon()
#сохраняем
canvas.save('line.png','PNG')