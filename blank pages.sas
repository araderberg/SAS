proc sql;
  connect to oracle(path=oc04);
  create table blankpg as select * from connection to oracle
(select d.patient pt, d.site site, d.CLIN_PLAN_EVE_NAME cpevent, rdci.document_number, 
	rdci.BLANK_FLAG flag, d.visit_number visit, d.QUALIFYING_VALUE qualifyv, 
	rdci.modification_ts modts, rdci.received_dci_entry_ts createts
from  received_dcms d,
      received_dcis rdci
where d.document_number=rdci.document_number
 and  d.clinical_study_id=xxxx
 order by pt, site 
 );
quit; 

proc sort data=blankpg;
 by pt site visit qualifyv descending createts;
run;     

proc sort data=blankpg out=blankpgs nodupkey;
 by pt site visit qualifyv;
run; 

data blanks;
 set blankpgs;
 where flag='Y';
run; 

PROC EXPORT DATA= WORK.blanks
            OUTFILE= "U:\My Documents\xxxx blank DCIs &sysdate.xls" 
            DBMS=EXCEL2000 REPLACE;
RUN;