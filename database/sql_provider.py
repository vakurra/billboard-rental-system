import os

# класс хранения sql-запросов
class SQLProvider:
    def __init__(self, file_path):
        self.scripts = {}  # Инициализируем словарь
        for file in os.listdir(file_path):  # Цикл по всем файлам по входной директории
            with open(
                f"{file_path}/{file}"
            ) as f:  # используем with для безопасного чтения
                _sql = f.read()
            self.scripts[file] = (
                _sql  # Заносим SQL-запрос в словарь, где ключ - это имя файла
            )

    def get(self, file):
        """Получить sql-запрос по имени файла"""
        _sql = self.scripts[file]
        return _sql
