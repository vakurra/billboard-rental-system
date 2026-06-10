SELECT b_id, install_address, size, cost, quality_score, owner_id
FROM Billboard
WHERE cost BETWEEN %s AND %s
ORDER BY cost;
