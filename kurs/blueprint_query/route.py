from flask import Blueprint, render_template, request, current_app
from work_with_db import select_dict
from sql_provider import SQLProvider
from access import group_required, login_required
import os

blueprint_query = Blueprint('bp_query', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_query.route('/')
@login_required
def work_with_queries():
    return render_template('select.html')

@blueprint_query.route('/input', methods=['GET', 'POST'])
@login_required
def query_index():
    if request.method == 'GET':
        return render_template('input.html')
    else:
        category = request.form.get('category')
        price = request.form.get('price')
        if not category or not price:
            return render_template('input.html')
        label = f'Товары из категории {category} ценой ниже {price}' 
        if category.isdigit():
            error = 'Неверно введена категория товара'
            return render_template('input.html', error=error)
        if  not price.isdigit():
            error = 'Неверно введена цена товара'
            return render_template('input.html', error=error)
        _sql = provider.get('category_price.sql', category=category, price=price)
        
        products = select_dict(current_app.config['db_config'], _sql)
        try:
            if products:
                return render_template('dynamic.html', products=products, label=label)
            else:
                return render_template('error.html')
        except Exception:
            error = 'Товары не найдены'
            return render_template('input.html', error=error)


@blueprint_query.route('/simple1', methods=['GET', 'POST'])
def simple1():
    if request.method == 'GET':
        return render_template('date_input.html', label="Сведения об издательства не сделавших поставки")
    else:
        left = request.form.get('left')
        right = request.form.get('right')
        _sql = provider.get('simple1.sql', left=left, right=right)
        result = select_dict(current_app.config['db_config'], _sql)
        label = 'Сведения об издательства не сделавших поставки'
        try:
            if result:
                data = []
                for item in result:
                    data.append(item.values())
                return render_template('dynamic.html', headers=result[0].keys(), data=data, result=result, label=label)
            else:
                return render_template('error.html', label=label)
        except Exception:
            error = 'Ничего не было найдено'
            return render_template('date_input.html', error=error)


@blueprint_query.route('/simple2', methods=['GET', 'POST'])
def simple2():
    if request.method == 'GET':
        return render_template('date_input.html', label="Сумма Заказов")
    else:
        left = request.form.get('left')
        right = request.form.get('right')
        _sql = provider.get('simple2.sql', left=left, right=right)
        result = select_dict(current_app.config['db_config'], _sql)
        label = 'Сумма Заказов'
        try:
            if result:
                data = []
                for item in result:
                    data.append(item.values())
                    # print(item.values())
                return render_template('dynamic.html', headers=result[0].keys(), data=data, result=result, label=label)
            else:
                return render_template('error.html', label=label)
        except Exception:
            error = 'Ничего не было найдено'
            return render_template('date_input.html', error=error)

@blueprint_query.route('/simple3', methods=['GET', 'POST'])
def simple3():
    if request.method == 'GET':
        return render_template('date_input.html', label="Заказ с максимальной суммой")
    else:
        left = request.form.get('left')
        right = request.form.get('right')
        _sql = provider.get('simple3.sql', left=left, right=right)
        result = select_dict(current_app.config['db_config'], _sql)
        label = 'Заказ с максимальной суммой'
        try:
            if result:
                data = []
                for item in result:
                    data.append(item.values())
                    # print(item.values())
                return render_template('dynamic.html', headers=result[0].keys(), data=data, result=result, label=label)
            else:
                return render_template('error.html', label=label)
        except Exception:
            error = 'Ничего не было найдено'
            return render_template('date_input.html', error=error)
        
@blueprint_query.route('/simple4', methods=['GET', 'POST'])
def simple4():
    if request.method == 'GET':
        return render_template('date_input.html', label="Издательство, оформившее партию артия с наибольшим количеством копий")
    else:
        left = request.form.get('left')
        right = request.form.get('right')
        _sql = provider.get('simple4.sql', left=left, right=right)
        result = select_dict(current_app.config['db_config'], _sql)
        label = 'Издательство, оформившее партию артия с наибольшим количеством копий'
        try:
            if result:
                data = []
                for item in result:
                    data.append(item.values())
                    # print(item.values())
                return render_template('dynamic.html', headers=result[0].keys(), data=data, result=result, label=label)
            else:
                return render_template('error.html', label=label)
        except Exception:
            error = 'Ничего не было найдено'
            return render_template('date_input.html', error=error)
        
# @blueprint_query.route('/simple3')
# def simple3():
#     if request.method == 'GET':
#         return render_template('input.html',label="Заказ с максимальной суммой")
#     else:
#         _sql = provider.get('simple3.sql')
#         result = select_dict(current_app.config['db_config'], _sql)
#         label = 'Заказ с максимальной суммой'
#         if result:
#             return render_template('dynamic.html', result=result, label=label)
#         else:
#             return render_template('error.html', label=label)

# @blueprint_query.route('/all_products')
# @login_required
# def all_products():
#     _sql = provider.get('all_products.sql')
#     products = select_dict(current_app.config['db_config'], _sql)
#     label = 'Католог всех продуктов'
#     if products:
#         return render_template('dynamic.html', products=products, label=label)
#     else:
#         return render_template('error.html')
#
#
# @blueprint_query.route('/all_sales')
# @login_required
# def sales():
#     _sql = provider.get('sales.sql')
#     products = select_dict(current_app.config['db_config'], _sql)
#     label = 'Все продукты со скидками'
#     if products:
#         return render_template('dynamic.html', products=products, label=label)
#     else:
#         return render_template('error.html')

