import json
from flask import Flask, render_template, session, flash, redirect, url_for
from auth.auth import auth
from auth.access import login_required
from query.query import query
from orders.orders import orders
from reports.reports import reports

app = Flask(__name__)
app.register_blueprint(auth, url_prefix="/auth")
app.register_blueprint(query, url_prefix="/query")
app.register_blueprint(orders, url_prefix="/orders")
app.register_blueprint(reports, url_prefix="/reports")
app.config["SECRET_KEY"] = "super_secret_key_123"


@app.route("/")
@login_required
def main_menu():
    """Главное меню"""
    return render_template("main_menu.html")


@app.route("/end", endpoint="end_session")
@login_required
def end_session():
    """Завершение работы"""
    session.clear()
    flash("Сеанс завершён")
    return redirect(url_for("main_menu"))


with open("data/db_config.json") as f:
    """Подключение конфигурации БД"""
    app.config["db_config"] = json.load(f)

with open("data/reports.json") as f:
    """Подключение конфигурации отчетов"""
    app.config["reports_config"] = json.load(f)

with open("data/queries.json") as f:
    """Подключение конфигурации запросов"""
    app.config["queries_config"] = json.load(f)


if __name__ == "__main__":
    app.run()
