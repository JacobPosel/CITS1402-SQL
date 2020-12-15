select date_format(buyDate, '%M') As month , count(*) As numPurchases
from purchase
group by date_format(buyDate, '%M');