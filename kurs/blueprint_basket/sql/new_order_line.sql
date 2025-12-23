INSERT INTO library.OrderList(idOrder, idbook, Quantity)
VALUES((SELECT MAX(`idOrder`) FROM library.Order), '$dish_id', '$amount');
