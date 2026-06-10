import os
from datetime import date
from flask import Blueprint, render_template, request, session, redirect, url_for

from database.sql_provider import SQLProvider
from database.model_route import execute_order_transaction
from auth.access import role_required

from orders import logic


orders = Blueprint(
    "orders", __name__, template_folder="templates", static_folder="static"
)

provider = SQLProvider(os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql"))


# Сброс фильтров
@orders.route("/clear-filters")
@role_required(["manager"])
def clear_filters():
    """Удалить фильтры из сессии"""
    
    session.pop("rent_start", None)
    session.pop("rent_end", None)
    session.pop("arendator_id", None)
    session.pop("arendator_name", None)
    session.pop("cart", None)

    return redirect(url_for("orders.catalog"))


# Очистка корзины
@orders.route("/clear-cart")
@role_required(["manager"])
def clear_cart():
    """Удалить корзину из сессии"""

    session.pop("cart", None)

    return redirect(url_for("orders.catalog"))


# Каталог
@orders.route("/", methods=["GET", "POST"])
@role_required(["manager"])
def catalog():
    """Отобразить каталог"""

    page = request.args.get("page", 1, type=int)
    warning_message = request.args.get("warning_message")
    order_status = request.args.get("order_status")
    order_message = request.args.get("order_message")
    error_message = None
    rent_start = rent_end = arendator_id = arendator_name = None
    filters_applied = False

    if request.method == "POST" and "start_month" in request.form:
        try:
            rent_start, rent_end, arendator_id, arendator_name = logic.apply_filters(
                provider, request.form
            )
            filters_applied = True

        except ValueError as e:
            error_message = str(e)

    else:
        rent_start, rent_end, arendator_id, arendator_name = logic.restore_filters()

        if rent_start:
            filters_applied = True

    all_results = logic.get_catalog(provider, rent_start, rent_end)
    results, total_pages, offset = logic.paginate(all_results, page)
    cart, cart_total = logic.get_cart()

    return render_template(
        "orders/catalog.html",
        results=results,
        page=page,
        total_pages=total_pages,
        offset=offset,
        filters_applied=filters_applied,
        rent_start=rent_start,
        rent_end=rent_end,
        arendator_id=arendator_id,
        arendator_name=arendator_name,
        error_message=error_message,
        warning_message=warning_message,
        cart=cart,
        cart_total=cart_total,
        order_status=order_status,
        order_message=order_message,
    )


# Добавление в корзину(обработчик http-запроса)
@orders.route("/add_to_cart", methods=["POST"])
@role_required(["manager"])
def add_to_cart():

    page = request.args.get("page", 1, type=int)

    if (
        "rent_start" not in session
        or "rent_end" not in session
        or "arendator_id" not in session
        or "arendator_name" not in session
    ):
        return redirect(
            url_for(
                "orders.catalog",
                page=page,
                warning_message="Для добавления билборда необходимо задать все фильтры",
            )
        )

    billboard_id = int(request.form["billboard_id"])
    logic.add_to_cart(provider, billboard_id)

    return redirect(url_for("orders.catalog", page=page))


# Оформление заказа
@orders.route("/submit-order", methods=["POST"])
@role_required(["manager"])
def submit_order():
    """Оформить заказ из корзины"""

    cart = session.get("cart")

    if not cart:
        return redirect(
            url_for(
                "orders.catalog",
                order_status="error",
                order_message="В корзине ничего нет",
            )
        )

    rent_start = date.fromisoformat(session["rent_start"])
    rent_end = date.fromisoformat(session["rent_end"])
    arendator_id = session["arendator_id"]
    total_cost = sum(i["total"] for i in cart)

    execute_order_transaction(
        order_sql=provider.get("order_insert.sql"),
        order_params=[date.today(), total_cost, arendator_id],
        order_line_sql=provider.get("order_line_insert.sql"),
        rental_schedule_sql=provider.get("rental_schedule_insert.sql"),
        cart=cart,
        rent_start=rent_start,
        rent_end=rent_end,
    )

    session.pop("cart", None)
    session.pop("rent_start", None)
    session.pop("rent_end", None)
    session.pop("arendator_id", None)
    session.pop("arendator_name", None)

    return redirect(
        url_for(
            "orders.catalog",
            order_status="success",
            order_message="Заказ успешно оформлен",
        )
    )
