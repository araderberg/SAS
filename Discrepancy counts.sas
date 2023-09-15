****************************************************************;
*** Program to count number of discrepancies per procedure   ***;
****************************************************************;

/* read in discrepancy data, procedure name and dcf data */
proc sql;
  connect to oracle(path=oc01);
  create table discr as select * from connection to oracle
  (Select  p.name, pd.test_order_sn detail, count(pd.test_order_sn) count, p.procedure_id procid 
  from discrepancy_management dm, 
       procedures p, 
       procedure_details pd  
  where dm.clinical_study_id=123456
  and dm.procedure_id = p.procedure_id  
  and dm.procedure_detail_id=pd.procedure_detail_id  
  and p.PROCEDURE_VER_SN=pd.PROCEDURE_DETAIL_PROC_VER_SN 
  and dm.PROCEDURE_VER_SN=p.PROCEDURE_VER_SN
  and dm.de_sub_TYPE_CODE='MULTIVARIATE'
group by p.name, pd.test_order_sn, p.procedure_id
order by count(p.name)desc
);

proc sql;
  connect to oracle(path=oc01);
  create table name as select * from connection to oracle
  (select distinct p.procedure_id procid, p.name, pd.TEST_ORDER_SN detail
  from  procedures p,
  	    procedure_details pd
  where p.clinical_study_id= 123456
  and p.procedure_status_code !='R'
  and p.procedure_id=pd.procedure_id
  order by procid
);
quit; 

/* merge # of discrepancies with name */  
proc sort data=discr;
 by procid;
run;
 
proc sort data=name;
 by procid;
run;
 
data discname;
 merge discr (in=d) name (in=n);
  by procid;
 if n;
run;  

proc sort data=discname ;
 by descending count ;
run;

/* either print out or export to excel */  
proc print data=discname label;
 var name numdisc percent numdcf;
  label numdisc = 'Number of discrepancies'
        numdcf = 'Number of DCFs';
 title "Number of discrepancies per Procedure"; 
 title2 "Client";
run; 
     
PROC EXPORT DATA= WORK.discname 
            OUTFILE= "U:\My Documents\Client\Client validation review.xls" 
            DBMS=EXCEL2000 REPLACE;
RUN;     
