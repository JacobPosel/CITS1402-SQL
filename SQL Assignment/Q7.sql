DELIMITER ++

CREATE FUNCTION isNutFree(coneNumber INT)
RETURNS INT DETERMINISTIC 
BEGIN
declare B INT;

if (select conetype 
	from cone where conenumber = id
    group by id) = 'Waffle'
then set B = 0;

elseif (coneNumber in (select distinct scoopsincone.coneid
from scoop join scoopsincone
on scoopsincone.scoopid = scoop.id
where scoop.id in (select scoop.id from scoop where name = 'Macadamia' or name = 'Coconut')))
then set B = 0;

else set B = 1;
end if;

Return b;
END ++

delimiter;
