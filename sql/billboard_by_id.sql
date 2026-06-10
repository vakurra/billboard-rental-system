SELECT
    install_address,
    cost
FROM Billboard
WHERE b_id = %s;
