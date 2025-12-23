from DBcm import DBContextManager
from pymysql import connect
from pymysql import OperationalError


def select_dict(db_config: dict, _sql: str):
    with DBContextManager(db_config) as cursor:
        if cursor is None:
            raise ValueError('Курсор не создан')
        else:
            cursor.execute(_sql)
            products = cursor.fetchall()
            if products:
                products_dict = []
                schema = [item[0] for item in cursor.description]
                for product in products:
                    products_dict.append(dict(zip(schema, product)))
                return products_dict
            else:
                return None

