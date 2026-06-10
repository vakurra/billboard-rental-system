SELECT b_id, install_address, size, cost
FROM Billboard
WHERE Billboard.b_id NOT IN (
    SELECT Rental_schedule.billboard_id
    FROM Rental_schedule
    WHERE NOT (
        Rental_schedule.rent_end <= %s
        OR Rental_schedule.rent_start >= %s
    )
)
ORDER BY Billboard.b_id;
