SELECT DISTINCT
    ph.idpublishing_house as "ID Издательства", 
    ph.namee as "Название", 
    ph.addres as "Адрес", 
    ph.date_contract as "Дата Контракта", 
    ph.year_ground as "Год Основания"
FROM 
    library.publishing_house ph
JOIN 
    library.batch_books bb ON ph.idpublishing_house = bb.idpublishing_house
WHERE 
    (bb.date_delivery IS NULL OR bb.date_delivery NOT BETWEEN '$left' AND '$right');
