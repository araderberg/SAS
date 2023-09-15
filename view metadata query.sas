PROC SQL;
CONNECT TO ORACLE(PATH=OC04);
CREATE TABLE CP280 AS SELECT * FROM CONNECTION TO ORACLE
(select
table_name              as dcm,
column_name             as variable,
data_type               as type,
data_length             as length,
data_precision          as numl,
data_scale              as adecimal
from all_tab_columns
 where owner='CP280$CURRENT'
 and table_name not in ('RDCMS_VIEW','RESPONSES_VIEW','NORMDATA','NORMLAB'));
QUIT;

