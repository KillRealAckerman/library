import json
from flask import Flask, render_template, session
from blueprint_query.route import blueprint_query
from blueprint_report.route import blueprint_report
from blueprint_auth.auth import blueprint_auth
from blueprint_basket.route import blueprint_basket

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
with open('db_config.json') as f:
    app.config['db_config'] = json.load(f)

with open('access.json') as f:
    app.config['access_config'] = json.load(f)

with open('cache.json') as f:
    app.config['cache_config'] = json.load(f)

app.register_blueprint(blueprint_query, url_prefix = '/query')
app.register_blueprint(blueprint_report, url_prefix = '/report')
app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_basket, url_prefix='/basket')

app.secret_key = "secret"


@app.route('/')
def start():
    return render_template('start.html')

@app.route('/menu')
def main_menu():
    return render_template('index.html', role=session["user_role"])

@app.route('/exit')
def clear_session():
    session.clear()
    return render_template('exit_session.html')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
