DELIMITER ++
CREATE FUNCTION costOfPurchase(purchaseNumber INT)
RETURNS INT DETERMINISTIC 
BEGIN
DECLARE A INT;
DECLARE  cone INT;
DECLARE scoopCost INT;
DECLARE multiScoop INT;
DECLARE finCost DECIMAL(10,2);
DECLARE discount DECIMAL(5,2);
set multiScoop = 0;

if(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Mon'
then set A = 50;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Tue'
then set A = 50;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Wed'
then set A = 50;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Thu'
then set A = 50;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Fri'
then set A = 50;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Sat'
then set A = 100;
elseif(select date_format(buydate, '%a')
from purchase 
where purchaseNumber = id ) = 'Sun'
then set A = 150;
END if;


set cone = (select sum(conecost)
from cone join conesinpurchase 
on cone.id = conesinpurchase.coneid
where conesinpurchase.purchaseid = purchaseNumber);



set scoopCost = (select sum(scoop.costincents)
from scoop join scoopsincone on scoopsincone.scoopid = scoop.id
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where conesinpurchase.purchaseid = purchaseNumber
group by conesinpurchase.purchaseID);

if(select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 3) = 3
then set multiScoop = multiScoop + 450;

elseif (select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 3) = 2
then set multiScoop = multiScoop + 300;

elseif (select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 3) = 1
then set multiScoop = multiScoop + 150;
end if;

if (select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 2) = 3
then set multiScoop = multiScoop + 150;

elseif (select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 2) = 2
then set multiScoop = multiScoop + 100;

elseif (select count(*) from(
select count(scoopid) as scoops from scoopsincone
join conesinpurchase on scoopsincone.coneid = conesinpurchase.coneid
where purchaseID = purchaseNumber
group by scoopsincone.coneid) as B where scoops = 2) = 1
then set multiScoop = multiScoop + 50;
end if;



set discount = (select discountApplied from customerpurchases where purchaseid = purchaseNumber);


set fincost = (((A + cone + scoopCost - multiscoop)*(100-discount))/100);

RETURN round(fincost,0);

END++

delimiter;



