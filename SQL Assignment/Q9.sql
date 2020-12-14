DELIMITER ++

CREATE FUNCTION numScoops(coneNumber INT)
RETURNS INT DETERMINISTIC 
begin
return (select count(scoopid)
from scoopsincone
where conenumber = coneid
group by coneid);
END;



CREATE PROCEDURE purchaseSummary(purchaseNum INT,
                  OUT oneScoop INT,
                  OUT twoScoop INT,
				  OUT threeScoop INT)
BEGIN

set onescoop = 0;
set twoscoop = 0;
set threescoop = 0;

Drop table if exists TEMPtable;
CREATE TABLE TEMPtable as
SELECT 
numscoops(conesinpurchase.coneid) as NumScoops ,  
count(distinct conesinpurchase.coneid) as NumCones 
FROM scoopsincone JOIN conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
WHERE purchaseID = purchaseNum
group by numscoops(conesinpurchase.coneid);

if (select exists(select numscoops from temptable where numscoops = 1)= 1)
then set onescoop = (select numcones from temptable where numscoops = 1);
end if;

if (select exists(select numscoops from temptable where numscoops = 2)= 1)
then set twoscoop = (select numcones from temptable where numscoops = 2);
end if;

if (select exists(select numscoops from temptable where numscoops = 3)= 1)
then set threescoop = (select numcones from temptable where numscoops = 3);
end if;


END++

delimiter;
