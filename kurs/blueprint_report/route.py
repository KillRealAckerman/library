from flask import Blueprint, render_template, request, current_app, session, flash, redirect, url_for
from work_with_db import select_dict
from sql_provider import SQLProvider
from access import group_required, login_required
import os
import json

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

with open('report.json', 'r', encoding='utf-8') as f:
    reports = json.load(f)

# @blueprint_report.route('/input', methods=['GET', 'POST'])
# @group_required
# @login_required
# def query_index():
#     if request.method == 'GET':
#         return render_template('input.html', role=session["user_role"])
#     else:
#         category = request.form.get('category')
#         price = request.form.get('price')
#         label = f'Товары из категории {category} ценой ниже {price}' 
#         # if category.isdigit():
#         #     error = 'Неверно введена категория товара'
#         #     return render_template('input.html', error=error)
#         # if (not price.isdigit()):
#         #     error = 'Неверно введена цена товара'
#         #     return render_template('input.html', error=error)
#         _sql = provider.get('category_price.sql', category=category, price=price)
#         
#         products = select_dict(current_app.config['db_config'], _sql)
#         try:
#             if products:
#                 return render_template('report_dynamic.html', products=products, label=label, role=session["user_role"])
#             else:
#                 return render_template('report_error.html', role=session["user_role"])
#         except Exception:
#             error = 'Товары не найдены'
#             return render_template('input.html', error=error, role=session["user_role"])

@blueprint_report.route('/', methods=['GET', 'POST'])
@group_required
@login_required
def index():
    return render_template('report_select.html', reports=reports)



@blueprint_report.route('/report_1', methods=['GET', 'POST'])
@group_required
@login_required
def report_1():
    return render_template('report_1.html', label=reports[0]["name"])

@blueprint_report.route('/create_1', methods=['GET', 'POST'])
@group_required
@login_required
def create_1():
    if request.method == 'GET':
        return render_template('create_1.html', label=reports[0]["name"])
    else:
        month = request.form.get('month')
        year = request.form.get('year')
        find_check_count = provider.get(reports[0]['sql_check'], month=month, year=year)
        check_count = select_dict(current_app.config['db_config'], find_check_count)
        if check_count[0]['count'] <= 0 :
            sql = provider.get(reports[0]['sql_create'], month=month, year=year)
            result = select_dict(current_app.config['db_config'], sql)
            if result is None:
                flash(f"Вы создали отчёт за {month} месяц {year} года", 'success')
                # return redirect(url_for('bp_report.index'))
                return render_template('create_1.html', error=f"Вы создали отчёт за {month} месяц {year} года")
            else:
                flash(f"Нельзя создать отчёт на этот месяц и год", 'error')
                return render_template('create_1.html', error="Нельзя создать отчёт на этот месяц и год")

        else:
            flash('Такой отчёт уже существует', 'error')
            return render_template('create_1.html', label=reports[0]["name"], error="Такой отчёт уже существует")


@blueprint_report.route('/view_1', methods=['GET', 'POST'])
@group_required
@login_required
def view_1():
    if request.method == 'GET':
        return render_template('view_1.html', label=reports[0]["name"])
    else:
        month = request.form.get('month')
        year = request.form.get('year')
        find_check_count = provider.get(reports[0]['sql_check'], month=month, year=year)
        check_count = select_dict(current_app.config['db_config'], find_check_count)
        if check_count[0]['count'] != 0:
            sql = provider.get(reports[0]['sql_view'], month=month, year=year)
            result = select_dict(current_app.config['db_config'], sql)
            data = []
            if result:
                for item in result:
                    data.append(item.values())
            title = f"Отчёт за {month} месяц {year} года "
            return render_template("report_dynamic.html", result=result,  headers=result[0].keys(), data=data, label=title, num=1)
        else:
            flash('Такой отчёт ещё не был создан', 'error')
            return render_template('view_1.html', label=reports[0]["name"], error="Такой отчёт ещё не был создан")


# @blueprint_report.route('/reports_1', methods=['GET', 'POST'])
# @group_required
# @login_required
# def reports_1():
#     label="Цена заказов по месяцу и году"
#     if request.method == 'GET':
#         # reports = provider.get('get_all_reports.sql')
#         # result = select_dict(current_app.config['db_config'], reports)
#         # if result:
#             # return render_template('report_dynamic.html', reports=result, label=label)
#         # return render_template('report_dynamic.html')
#         return render_template('look_or_create.html', label=label)
#     else:
#         reports = provider.get('get_all_reports.sql')
#         year = request.form.get('year')
#         month = request.form.get('month')
#         _sql = provider.get('check_report_1.sql', year=year, month=month)
#         cost = select_dict(current_app.config['db_config'], _sql)
#         if cost:
#             _sql = provider.get('gen_report.sql', year=year, month=month)
#             # cost = select_dict(current_app.config['db_config'], _sql)
#             # prod_title = 'Отчёт за данный месяц был обновлен'
#             prod_title = 'Отчёт за данный месяц уже существует'
#             result = select_dict(current_app.config['db_config'], reports)
#             return render_template('report_dynamic.html', label=label, reports=result, prod_title=prod_title)
#         else:
#             _sql = provider.get('gen_report.sql', year=year, month=month)
#             cost = select_dict(current_app.config['db_config'], _sql)
#             result = select_dict(current_app.config['db_config'], reports)
#             prod_title = 'Отчёт успешно создан'
#             return render_template('report_dynamic.html', label=label, reports=result, prod_title=prod_title)
#
# @blueprint_report.route('/reports_2', methods=['GET', 'POST'])
# @group_required
# @login_required
# def reports_2():
#     _sql = provider.get('get_all_reports.sql')
#     result = select_dict(current_app.config['db_config'], _sql)
#     if result:
#         return render_template('report_dynamic.html', reports=result, label="Отчёт №2")
#     return render_template('report_dynamic.html')
#
#
# @blueprint_report.route('/create_report', methods=['GET', 'POST'])
# @group_required
# @login_required
# def report_create():
#     if request.method == 'GET':
#         return render_template('otchet_in.html')
#     else:
#         year = int(request.form.get('year'))
#         month = int(request.form.get('month'))
#         _sql = provider.get('check_rep.sql', year=year, month=month)
#         cost = select_dict(current_app.config['db_config'], _sql)
#         label='Отчет'
#         print(cost)
#         if cost:
#             prod_title = 'Данный отчет уже существует'
#             return render_template('report_dynamic.html', label=label, reports=cost, prod_title=prod_title)
#         else:
#             _sql = provider.get('gen_report.sql', year=year, month=month)
#             cost = select_dict(current_app.config['db_config'], _sql)
#             prod_title = 'Отчёт успешно создан'
#             return render_template('report_dynamic.html', label=label, reports=cost, prod_title=prod_title)

# @blueprint_report.route('/all_external_users')
# @group_required
# @login_required
# def all_external_users():
#     _sql = provider.get('all_external_users.sql')
#     users = select_dict(current_app.config['db_config'], _sql)
#     label = 'Все внешние пользователи'
#     if users:
#         return render_template('report_dynamic.html', users=users, label=label)
#     else:
#         return render_template('report_error.html')
#
# @blueprint_report.route('/all_internal_users')
# @group_required
# @login_required
# def all_internal_users():
#     _sql = provider.get('all_internal_users.sql')
#     users = select_dict(current_app.config['db_config'], _sql)
#     label = 'Все внутренние пользователи'
#     if users:
#         return render_template('report_dynamic.html', users=users, label=label)
#     else:
#         return render_template('report_error.html')

# @blueprint_report.route('/')
# @group_required
# @login_required
# def work_with_queries():
#     return render_template('report_select.html')
