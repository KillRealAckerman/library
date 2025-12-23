SELECT 
    bb.total_coast as "Полная сумма", 
    bb.date_delivery as "Дата Доставки", 
    ph.namee as "Название"
FROM 
    library.batch_books bb
JOIN 
    library.publishing_house ph ON bb.idpublishing_house = ph.idpublishing_house
WHERE 
    bb.date_delivery >= '$left' AND bb.date_delivery <= '$right';
