import os
from flask import Blueprint, render_template, request, redirect, url_for, session
from database.sql_provider import SQLProvider
from database.model_route import execute_query


auth = Blueprint("auth", __name__, template_folder="templates", static_folder="static")


provider = SQLProvider(os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql"))


@auth.route("/", methods=["GET", "POST"])
def login():
    """Авторизация - занесение пользователя в сессию"""

    if request.method == "GET":
        return render_template("auth/login.html")

    username = request.form.get("username")
    password = request.form.get("password")
    result = execute_query(provider, "auth.sql", [username, password])

    if result.status:
        user = result.result[0]
        session["user_id"] = user[0]
        session["username"] = user[1]
        session["role"] = user[2]
        return redirect(url_for("main_menu"))

    else:
        return render_template("auth/err.html", err_message="Неверный логин или пароль")
