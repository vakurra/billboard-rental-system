import os
from flask import Blueprint, render_template, request, current_app
from database.sql_provider import SQLProvider
from database.select import select_list
from database.model_route import execute_query
from auth.access import role_required

query = Blueprint(
    "query", __name__, template_folder="templates", static_folder="static"
)

provider = SQLProvider(os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql"))


@query.route("/", methods=["GET"])
@role_required(["admin", "manager"])
def menu():
    """Показывает меню запросов"""
    queries = current_app.config["queries_config"]
    return render_template("query/query_menu.html", queries=queries)


@query.route("/<query_name>", methods=["GET", "POST"])
@role_required(["admin", "manager"])
def process_query(query_name):
    """Выполняет конкретный запрос"""

    queries = current_app.config["queries_config"]
    query_config = queries.get(query_name)

    if not query_config:
        return render_template(
            "query/err.html", err_message="Такой тип запроса не найден"
        )

    # показать форму
    if request.method == "GET":
        return render_template(
            "query/query_form.html",
            title=query_config["title"],
            fields=query_config["fields"],
            submit_text=query_config["submit_text"],
            query_name=query_name,
        )

    params = [request.form[p] for p in query_config["sql_params"]]
    result_info = execute_query(provider, query_config["sql"], params)

    if result_info.status:
        return render_template(
            "query/query_result.html",
            results=result_info.result,
            title=query_config["title"],
        )

    return render_template("query/err.html", err_message=result_info.err_message)
