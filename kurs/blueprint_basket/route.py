from flask import (
    Blueprint, render_template,
    request, current_app,
    session, redirect, url_for
)
from work_with_db import select_dict
from sql_provider import SQLProvider
from cache.wrapper import fetch_from_cache
import access
import os

blueprint_basket = Blueprint('bp_basket', __name__, template_folder='templates', static_folder='static')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_basket.route('/', methods=['GET', 'POST'])
@access.login_required
def basket_index():
    db_config = current_app.config['db_config']
    cache_config = current_app.config['cache_config']
    cached_func = fetch_from_cache('all_items_cached', cache_config)(select_dict)
    sql = provider.get('all_items.sql')
    items = cached_func(db_config, sql)
    print(items)
    if request.method == 'GET':
        basket_items = session.get('basket', {})
        return render_template('basket.html', items=items, basket_items=basket_items, role=session["user_role"])
    else:
        dish_id = request.form['dish_id']
        item_description = [item for item in items if str(item['id']) == str(dish_id)]
        if item_description:
            item_description = item_description[0]
            curr_basket = session.get('basket', {})
            if dish_id in curr_basket:
                curr_basket[dish_id]['amount'] = curr_basket[dish_id]['amount'] + 1
            else:
                curr_basket[dish_id] = {
                    'name': item_description['name'],
                    'price': item_description['price'],
                    'amount': 1
                }
            session['basket'] = curr_basket
            session.permanent = True
        else:
            # Обработайте ситуацию, когда товар не найден
            # Например, вы можете добавить сообщение об ошибке или перенаправить пользователя на другую страницу
            pass

        return redirect(url_for('bp_basket.basket_index'))

@blueprint_basket.route('/clear-basket')
def clear_basket():
    if 'basket' in session:
        session.pop('basket')
    return redirect(url_for('bp_basket.basket_index'))

@blueprint_basket.route('/order')
def order():
    sum = 0
    for item in session.get('basket').values():
        sum += item['amount'] * item['price']

    sql_order = provider.get('new_order.sql', user_id=session['user_id'], sum=sum)
    select_dict(current_app.config['db_config'], sql_order)
    for key, value in session['basket'].items():
        sql_basket = provider.get('new_order_line.sql', dish_id=key, amount=value['amount'])
        select_dict(current_app.config['db_config'], sql_basket)
    session.pop('basket')
    return render_template('order.html', sum=sum)
