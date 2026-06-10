INSERT INTO Order_line (
    order_id,
    billboard_id,
    rent_start,
    rent_end
)
VALUES (%s, %s, %s, %s);
