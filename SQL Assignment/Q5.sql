DELIMITER ++

CREATE FUNCTION numFlavours(coneNumber INT)
RETURNS INT DETERMINISTIC 
begin
return (select count(distinct scoopid)
from scoopsincone
where conenumber = coneid
group by coneid);
END ++

DELIMITER;

