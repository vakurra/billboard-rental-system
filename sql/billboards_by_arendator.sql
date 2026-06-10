SELECT DISTINCT b_id, install_address, `size`, cost, quality_score, owner_id
FROM Billboard
JOIN Order_line ON Billboard.b_id = Order_line.billboard_id
JOIN `Order` ON Order_line.order_id = `Order`.ord_id
JOIN Arendator ON `Order`.arendator_id = Arendator.a_id
WHERE Arendator.lastname = %s
  AND MONTH(Order_line.rent_start) = %s
  AND YEAR(Order_line.rent_start) = %s;
