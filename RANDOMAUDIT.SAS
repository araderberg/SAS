*******************************************************
***   PROGRAM:    randomaudit.sas                       
***   PROGRAMMER:  Aaliyah Raderberg
***   PROJECT   :                
***   DATE:        2006
***   COPY/MODIFIED :                      
***   DESCRIPTION: Draw a Sample of 10% (maximum 30 subjid) subjid for audit
***   
**********************************************************;

/* Define libname */
Libname in 'Disk$xxxx:[xxxx.database]';
LIBNAME out 'disk$xxxx:[xxxx.programs]';

OPTIONS LS=132 ps=60 missing=' ' nofmterr nocenter sortpgm=sas;

proc sort data=in.random out=random; 
by pid1a;
*where pid1a in ;
run;

data random; set random;    
  if rand = '1';             /*select those randomized patients*/
run; 

%macro audit(dsn);

   data temp(drop=sample) temp1(keep=sample);
      set &dsn(keep=pid1a) end=max;       ** Project specific code **;
     
      rnd=ranuni(0);                   /* assign a random number to each pid1a observation*/
      if max=1 then do;                 /* if last observation ... */
         sample=round(_N_*.1,1);       /* Sample size = Round [ (Number of pid1a *0.10 )]*/
         output temp1;                  /* Output sample size to temp1 */
      end;
      output temp;                      /* Output pid1a list to temp */



      proc sort data=temp;              
          by rnd;
 run;


      data out.audit1;
         set temp;
         if _N_=1 then set temp1;       /* Bring in the sample size */
         if _N_<=sample;                /* Output observations 1 through sample */
 run;




      proc sort data=out.audit1;
         by PID1A;                    ** Project specific code **;
 run;   
      proc print data=out.audit1 noobs;
         title "The 10% randomized pid1as for REG50166 archiving";
      var PID1A ;
 run;                  

 *** COMMENTED OUT AFTER 1ST RUN OF PGM. TO SAVE LIST OF PATS FOR AUDIT ***;
 ***  PROCESSING AUDIT BY SITE ***;
 %mend audit;

%audit(random);


