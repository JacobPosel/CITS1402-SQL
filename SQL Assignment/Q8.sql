select customer.email, purchase.store, count(purchaseid)
from customer, purchase, customerpurchases
where customer.id = customerpurchases.customerid
and customerpurchases.purchaseid = purchase.id
group by customer.email, purchase.store with rollup;