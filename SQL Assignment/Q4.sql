select customerid, count(conesinpurchase.purchaseid) As ConesPurchased
from conesinpurchase join customerPurchases
on customerpurchases.purchaseID = conesinpurchase.purchaseid
group by customerid
order by conespurchased desc;