SELECT b_id, install_address, size, cost, quality_score, owner_id
FROM Billboard
WHERE NOT EXISTS (
    SELECT 1
    FROM Rental_schedule
    WHERE Rental_schedule.billboard_id = Billboard.b_id
      AND MONTH(Rental_schedule.rent_start) <= %s
      AND MONTH(Rental_schedule.rent_end) >= %s
      AND YEAR(Rental_schedule.rent_start) = %s
)
ORDER BY Billboard.b_id;
