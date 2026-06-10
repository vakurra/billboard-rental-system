from datetime import date
from flask import session
from database.model_route import execute_query

PER_PAGE = 10


# Фильтры
def apply_filters(provider, form):
    """Применить фильтры"""

    session.pop("cart", None)
    start_month = int(form["start_month"])
    start_year = int(form["start_year"])
    end_month = int(form["end_month"])
    end_year = int(form["end_year"])
    arendator_id = int(form["arendator_id"])
    res = execute_query(provider, "arendator_by_id.sql", [arendator_id])
    
    if not res.status:
        raise ValueError("Арендатор с таким ID не найден")
    
    arendator_name = res.result[0][0]
    rent_start = date(start_year, start_month, 1)
    rent_end = date(end_year, end_month, 1)
    
    if rent_end <= rent_start:
        raise ValueError("Дата окончания должна быть позже даты начала")

    session["rent_start"] = rent_start.isoformat()
    session["rent_end"] = rent_end.isoformat()
    session["arendator_id"] = arendator_id
    session["arendator_name"] = arendator_name

    return rent_start, rent_end, arendator_id, arendator_name


def restore_filters():
    """Восстановление фильтров из сессии"""
    
    if (
        "rent_start" in session
        and "rent_end" in session
        and "arendator_id" in session
        and "arendator_name" in session
    ):
        return (
            date.fromisoformat(session["rent_start"]),
            date.fromisoformat(session["rent_end"]),
            session["arendator_id"],
            session["arendator_name"],
        )

    return None, None, None, None


# Каталог
def get_catalog(provider, rent_start, rent_end):
    """Получить каталог"""
    
    if rent_start and rent_end:
        res = execute_query(provider, "catalog_with_filters.sql", [rent_start, rent_end])
    else:
        res = execute_query(provider, "catalog.sql", [])

    if not res.status:
        return []

    return res.result


# Пагинация
def paginate(data, page):
    """Пагинация"""

    total_items = len(data)
    total_pages = (total_items + PER_PAGE - 1) // PER_PAGE
    start = (page - 1) * PER_PAGE
    end = start + PER_PAGE

    return data[start:end], total_pages, start


# Корзина
def get_cart():
    """Получить корзину"""
    
    cart = session.get("cart", [])
    total = sum(i["total"] for i in cart)

    return cart, total


def add_to_cart(provider, billboard_id):
    """Добавление в корзину"""
    
    rent_start = date.fromisoformat(session["rent_start"])
    rent_end = date.fromisoformat(session["rent_end"])
    months = (rent_end.year - rent_start.year) * 12 + (rent_end.month - rent_start.month)
    cart = session.get("cart", [])

    if any(i["billboard_id"] == billboard_id for i in cart):
        return cart

    result = execute_query(provider, "billboard_by_id.sql", [billboard_id])
    row = result.result[0]
    monthly_cost = int(row[1])
    total_cost = monthly_cost * months
    cart.append(
        {
            "billboard_id": billboard_id,
            "address": row[0],
            "monthly_cost": monthly_cost,
            "months": months,
            "total": total_cost,
        }
    )
    session["cart"] = cart
