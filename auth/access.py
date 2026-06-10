from functools import wraps
from flask import session, redirect, render_template, url_for, current_app


# Декоратор для проверки авторизации
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "username" not in session:
            return redirect(url_for("auth.login"))
        return f(*args, **kwargs)

    return decorated_function


# Декоратор для проверки роли
def role_required(allowed_roles):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if "role" not in session or session["role"] not in allowed_roles:
                return render_template(
                    "auth/err.html", err_message="Недостаточно прав!"
                )
            return f(*args, **kwargs)

        return decorated_function

    return decorator
