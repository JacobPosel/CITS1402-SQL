select name 
from scoop 
where costincents in
(select max(costincents) from scoop);