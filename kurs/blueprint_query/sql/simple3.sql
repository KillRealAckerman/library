SELECT 
    bb.total_coast as "Полная сумма", 
    bb.date_delivery as "Дата Доставки", 
    ph.namee as "Название"
FROM 
    library.batch_books bb
JOIN 
    library.publishing_house ph ON bb.idpublishing_house = ph.idpublishing_house
WHERE 
    bb.total_coast = (SELECT MAX(total_coast)
                      FROM library.batch_books
                      WHERE date_delivery BETWEEN '$left' AND '$right')
    AND bb.date_delivery BETWEEN '$left' AND '$right';
