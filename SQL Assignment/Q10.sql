DELIMITER ++
CREATE PROCEDURE createMonthlyWinners()
BEGIN
DROP TABLE IF EXISTS FIRSTMTABLE;
CREATE TABLE FIRSTMTABLE AS
select date_format(buyDate, '%M %Y') As month , store, count(id) as NumPurchases
from purchase 
group by month, store;

DROP TABLE IF EXISTS MonthlyWinners;
CREATE TABLE MonthlyWinners As
select M.month, M.store, M.numpurchases from firstmtable M
inner join
(select month, max(numpurchases) NumPurchases
from firstmtable FM
group by month) As T
on T.Numpurchases = M.numpurchases
and M.month = T.month;
END ++

DELIMITER;
