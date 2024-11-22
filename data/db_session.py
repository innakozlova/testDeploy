

# для отслеживания состоянии структуры таблиц БД нам потребуется pip install alembic
# в папке alembic сделать настройки env
#alembic init alembic - создает директорию в корне проекта
#Конфигурируем alembic.ini путь к БД после sqlalchemy.url
#в терминале alembic revision __autogenerate -m "added level for user"
#в терминале alembic upgrade head

import sqlalchemy as sa
import sqlalchemy.orm as orm
from sqlalchemy.orm import Session

SqlAlchemyBase=orm.declarative_base()

__factory=None

def global_init(db_file):
    global __factory

    if __factory:
        return

    if not db_file or not db_file.strip():
        raise Exception("Необходимо указать файл БД при вызове функции global_init")

    conn_str=f'sqlite:///{db_file.strip()}?check_same_thread=False'
    print(f'Мы подключились к БД по адресу: {conn_str}')

    engine=sa.create_engine(conn_str, echo=False)
    __factory=orm.sessionmaker(bind=engine)

    from . import __all_models

    SqlAlchemyBase.metadata.create_all(engine)


def create_session() -> Session:
    global __factory
    return __factory()
