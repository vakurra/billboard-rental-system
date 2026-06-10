from dataclasses import dataclass

from database.select import select_list, call_procedure, insert_order


@dataclass
class ResultInfo:
    result: tuple
    status: bool
    err_message: str


def execute_query(provider, sql_name: str, params: list):
    """Выполнить запрос, вернуть ResultInfo"""
    sql = provider.get(sql_name)
    result = select_list(sql, params)
    if result:
        return ResultInfo(result, True, "")

    return ResultInfo((), False, "Данные не получены")


def execute_procedure(proc_name: str, params: list):
    """Выполнить процедуру, вернуть ResultInfo"""
    result = call_procedure(proc_name, params)

    if not result:
        return ResultInfo((), False, "Процедура ничего не вернула")

    return ResultInfo(result, True, "")


def execute_order_transaction(
    order_sql,
    order_params,
    order_line_sql,
    rental_schedule_sql,
    cart,
    rent_start,
    rent_end,
):
    """Оформить заказ, вернуть ResultInfo"""

    try:
        order_id = insert_order(
            order_sql,
            order_params,
            order_line_sql,
            rental_schedule_sql,
            cart,
            rent_start,
            rent_end,
        )

        return ResultInfo(order_id, True, "")

    except Exception as e:
        return ResultInfo((), False, str(e))
