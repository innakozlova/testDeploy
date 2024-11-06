import csv


with open ('Personal.csv', encoding='utf-8') as f:
    reader=csv.reader(f, delimiter=';', quotechar='"')
    for index, row in enumerate(reader):
  #  print(list(reader[1][2]))
        print(row)

with open ('Personal.csv', encoding='utf-8') as f:
    reader=csv.DictReader(f, delimiter=';', quotechar='"')
    row =list(reader)
    for r in row:
  #  print(list(reader[1][2]))
        print(r['ФИО'])