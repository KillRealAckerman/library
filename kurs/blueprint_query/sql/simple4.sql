SELECT DISTINCT
    ph.namee as "Название издательства", 
    bb.date_delivery as "Дата доставки", 
    sl.amount_copy as "Количество копий", 
    bb.idbatch_books as "ID партии книг",
    b.title as "Название книги"
FROM 
    publishing_house ph
JOIN 
    batch_books bb ON ph.idpublishing_house = bb.idpublishing_house
JOIN 
    supply_list sl ON ph.idpublishing_house = sl.idpublishing_house
JOIN
    book b ON sl.idbook = b.idbook
WHERE 
    (bb.date_delivery BETWEEN '$left' and '$right') 
    AND (sl.amount_copy = (SELECT MAX(amount_copy) FROM supply_list));
