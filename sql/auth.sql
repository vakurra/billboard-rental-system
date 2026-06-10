SELECT user_id, username, role
FROM Internal_users
WHERE username = %s AND password = %s;
