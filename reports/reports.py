from flask import Blueprint, render_template, request, current_app
from auth.access import role_required
from reports import logic


reports = Blueprint(
    "reports", __name__, template_folder="templates", static_folder="static"
)


@reports.route("/")
@role_required(["admin"])
def menu():
    """Получение меню отчетов"""
    reports_config = current_app.config["reports_config"]
    return render_template("reports/reports_menu.html", reports=reports_config)


@reports.route("/<report_type>", methods=["GET", "POST"])
@role_required(["admin"])
def process_report(report_type):
    """Выполнить конкретный тип отчета(создать/удалить)"""

    reports_config = current_app.config["reports_config"]
    config = reports_config.get(report_type)

    if not config:
        return render_template(
            "reports/err.html", err_message="Такой тип отчета не найден"
        )

    if request.method == "POST":
        month = int(request.form["month"])
        year = int(request.form["year"])
        action = request.form["action"]

        if action == "create":
            ok, err = logic.create_report(report_type, month, year, reports_config)

            if not ok:
                return render_template("reports/err.html", err_message=err)

        report, err = logic.view_report(report_type, month, year, reports_config)

        if err:
            return render_template("reports/err.html", err_message=err)

        return render_template(
            "reports/report_result.html", report=report, title=config["title"]
        )

    return render_template(
        "reports/report_form.html",
        title=config["title"],
        fields=config["fields"],
        submit_create=config["submit_create"],
        submit_view=config["submit_view"],
    )
