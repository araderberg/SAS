%macro VarExist(ds, var);

    %local rc dsid;

    %let dsid = %sysfunc(open(&ds));
 
    %if %sysfunc(varnum(&dsid, &var)) > 0 %then %do;

        %let result = 1;

        %put NOTE: Var &var exists in &ds;

           drop &var;

    %end;

    %else %do;

        %let result = 0;

        %put NOTE: Var &var not exists in &ds;

    %end;

    %let rc = %sysfunc(close(&dsid));

%mend VarExist;

 %VarExist(sashelp.class, name);
