from database.DBcm import DBContextManager
from flask import current_app


def select_list(sql: str, params: list):
    """выполнение SQL-запроса SELECT с позиционными параметрами, 
    возврат результата в виде кортежа строк"""
    
    with DBContextManager(current_app.config["db_config"]) as cursor:
        if cursor is None:
            raise ValueError("Курсор не создан")

        cursor.execute(sql, params)
        return cursor.fetchall()


def call_procedure(proc_name: str, params: list):
    """вызов хранимых процедур с параметрами"""
    
    with DBContextManager(current_app.config["db_config"]) as cursor:
        if cursor is None:
            raise ValueError("Курсор не создан")

        cursor.callproc(proc_name, params)
        return cursor.fetchall()


def insert_order(
    order_sql,
    order_params,
    order_line_sql,
    rental_schedule_sql,
    cart,
    rent_start,
    rent_end,
):
    """создание заказа и связанных с ним записей в базе данных"""

    with DBContextManager(current_app.config["db_config"]) as cursor:
        if cursor is None:
            raise ValueError("Cursor not created")

        cursor.execute(order_sql, order_params)
        order_id = cursor.lastrowid

        for item in cart:
            cursor.execute(
                order_line_sql, [order_id, item["billboard_id"], rent_start, rent_end]
            )

            cursor.execute(
                rental_schedule_sql, [item["billboard_id"], rent_start, rent_end]
            )

        return order_id
