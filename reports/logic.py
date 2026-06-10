import os

from database.sql_provider import SQLProvider
from database.model_route import execute_procedure

provider = SQLProvider(os.path.join(os.path.dirname(os.path.dirname(__file__)), "sql"))


def create_report(report_type, month, year, reports_config):
    """Создание отчета"""

    proc_name = reports_config[report_type]["create"]
    result = execute_procedure(proc_name, [month, year])

    if not result.status:
        return False, result.err_message

    status = result.result[0][0]

    if status == "EXISTS":
        return False, "Отчет уже существует"

    if status == "CREATED":
        return True, None

    return False, "Ошибка создания отчета"


def view_report(report_type, month, year, reports_config):
    """Просмотр отчета"""

    proc_name = reports_config[report_type]["view"]
    result = execute_procedure(proc_name, [month, year])

    if not result.status:
        return None, result.err_message

    rows = result.result

    if not rows:
        return None, "Отчет не найден"

    columns = reports_config[report_type]["columns"]
    report = {"columns": columns, "rows": rows}

    return report, None
