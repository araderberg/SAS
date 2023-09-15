options validvarname=v7 ls=175 ps=50 missing = ' ';

proc sql ; 

 connect to oracle(path=oc04);
 create table notebook as 
 select *  from connection to oracle 
 (SELECT DCI_BOOKS.NAME "dci_book", DCI_BOOK_PAGESV.DISPLAY_SN, DCI_BOOK_PAGESV.DCI_NAME, 
DCI_BOOK_PAGESV.CPE_NAME, DCIS.NAME "dcis", DCI_MODULES.QUAL_QUESTION_VALUE_TEXT "page",
DCI_MODULES.DCM_MODULE_SN "sn", CLINICAL_STUDIES.STUDY, CLINICAL_STUDIES.SHORT_TITLE, 
DCMS.DCM_SUBSET_SN, DCMS.DCM_LAYOUT_SN, DCMS.NAME "dcms", DCMS.SUBSET_NAME, DCMS.DCM_STATUS_CODE, 
DCMS.SHORT_NAME, DCMS.DESCRIPTION, DCM_QUESTION_GROUPS.NAME "dcm_qg_nm", 
DCM_QUESTION_GROUPS.COLLECTED_FLAG, DCM_QUESTION_GROUPS.REPEATING_FLAG, DCM_QUESTIONS.MANDATORY_FLAG, 
DCM_QUESTIONS.QUESTION_NAME, DCM_QUESTIONS.OCCURRENCE_SN, DCM_QUESTIONS.QUESTION_DATA_TYPE_CODE, DCM_QUESTIONS.SIGHT_VERIFICATION_FLAG, 
DCM_QUESTIONS.ENTERABLE_FLAG, DCM_QUESTIONS.DISPLAYED_FLAG, DCM_QUESTIONS.COLLECTED_FLAG, 
DCM_QUESTIONS.DERIVED_FLAG, DCM_QUESTIONS.COLLECTED_IN_SUBSET_FLAG, DCM_QUESTIONS.LENGTH, 
DCM_QUESTIONS.DECIMAL_PLACES, DCM_QUESTIONS.DEFAULT_RESPONSE_TEXT, DCM_QUESTIONS.HAS_REPEAT_DEFAULTS_FLAG, 
DISCRETE_VALUE_GROUPS.DISCRETE_VAL_GRP_SUBSET_NUM, DISCRETE_VALUE_GROUPS.NAME "dvg_name"
FROM  RXC.DCI_BOOKS DCI_BOOKS, RXC.DCI_BOOK_PAGESV DCI_BOOK_PAGESV, RXC.DCIS DCIS,
RXC.DCI_MODULES DCI_MODULES, RXA_DES.CLINICAL_STUDIES CLINICAL_STUDIES, RXC.DCMS DCMS,
RXC.DCM_QUESTION_GROUPS DCM_QUESTION_GROUPS, RXC.DCM_QUESTIONS DCM_QUESTIONS,
RXC.DISCRETE_VALUE_GROUPS DISCRETE_VALUE_GROUPS
WHERE DCI_BOOKS.CLINICAL_STUDY_ID = DCI_BOOK_PAGESV.CLINICAL_STUDY_ID AND
DCI_BOOKS.DCI_BOOK_ID = DCI_BOOK_PAGESV.DCI_BOOK_ID AND
DCI_BOOK_PAGESV.DCI_ID = DCIS.DCI_ID AND
DCI_BOOK_PAGESV.DCI_NAME = DCIS.NAME AND
DCI_BOOK_PAGESV.DCI_SHORT_NAME = DCIS.SHORT_NAME AND
DCI_BOOK_PAGESV.CLINICAL_STUDY_ID = DCIS.CLINICAL_STUDY_ID AND
DCIS.DCI_ID = DCI_MODULES.DCI_ID AND
DCIS.CLINICAL_STUDY_ID = DCI_MODULES.CLINICAL_STUDY_ID AND
DCIS.CLINICAL_STUDY_ID = CLINICAL_STUDIES.CLINICAL_STUDY_ID AND
DCI_MODULES.DCM_ID = DCMS.DCM_ID AND
DCI_MODULES.DCM_SUBSET_SN = DCMS.DCM_SUBSET_SN AND
DCI_MODULES.DCM_LAYOUT_SN = DCMS.DCM_LAYOUT_SN AND
DCI_MODULES.CLINICAL_STUDY_ID = DCMS.CLINICAL_STUDY_ID AND
DCMS.DCM_SUBSET_SN = DCM_QUESTION_GROUPS.DCM_QUE_GRP_DCM_SUBSET_SN AND
DCMS.DCM_LAYOUT_SN = DCM_QUESTION_GROUPS.DCM_QUE_GRP_DCM_LAYOUT_SN AND
DCMS.DCM_ID = DCM_QUESTION_GROUPS.DCM_ID AND
DCMS.CLINICAL_STUDY_ID = DCM_QUESTION_GROUPS.CLINICAL_STUDY_ID AND
DCM_QUESTION_GROUPS.DCM_QUE_GRP_DCM_SUBSET_SN = DCM_QUESTIONS.DCM_QUE_DCM_SUBSET_SN AND
DCM_QUESTION_GROUPS.DCM_QUE_GRP_DCM_LAYOUT_SN = DCM_QUESTIONS.DCM_QUE_DCM_LAYOUT_SN AND
DCM_QUESTION_GROUPS.DCM_ID = DCM_QUESTIONS.DCM_ID AND
DCM_QUESTION_GROUPS.DCM_QUESTION_GRP_ID = DCM_QUESTIONS.DCM_QUESTION_GROUP_ID AND
DCM_QUESTION_GROUPS.CLINICAL_STUDY_ID = DCM_QUESTIONS.CLINICAL_STUDY_ID AND
DCM_QUESTIONS.DISCRETE_VAL_GRP_ID = DISCRETE_VALUE_GROUPS.DISCRETE_VALUE_GRP_ID(+) AND
DCM_QUESTIONS.DISCRETE_VAL_GRP_SUBSET_NM = DISCRETE_VALUE_GROUPS.DISCRETE_VAL_GRP_SUBSET_NUM(+) AND
DCM_QUESTIONS.DVG_SUB_TYPE_CODE = DISCRETE_VALUE_GROUPS.DVG_SUB_TYPE_CODE(+) AND
CLINICAL_STUDIES.STUDY = '89187' AND
DCM_QUESTIONS.COLLECTED_IN_SUBSET_FLAG = 'Y' AND
DCM_QUESTION_GROUPS.COLLECTED_FLAG = 'Y' AND
DCM_QUESTIONS.COLLECTED_FLAG = 'Y' AND
DCMS.DCM_STATUS_CODE = 'P' AND
DCMS.SHORT_NAME < 'Z'
ORDER BY
DCI_BOOKS.NAME ASC,
DCI_BOOK_PAGESV.DISPLAY_SN ASC,
DCI_MODULES.DCM_MODULE_SN ASC,
DCIS.NAME ASC,
DCMS.NAME ASC);
quit ; 

/*
proc contents data=notebook position;
run;
*/

/* Print out report */

title "DCM/DCI report";
title2 "Client: Raderberg";
title3 "Study: xxxx";

proc report data=notebook nowd missing headline headskip spacing=2 split='$'; 
  column dci_name cpe_name display_sn sn dcms subset_name dcm_qg_nm
         collected_flag repeating_flag mandatory_flag question_name occurrence_sn 
         question_data_type_code enterable_flag displayed_flag collected_flag0 
         derived_flag length collected_in_subset_flag decimal_places has_repeat_defaults_flag 
         dvg_name discrete_val_grp_subset_num; 

  define dci_name /   order width=10 left; 
  define cpe_name /   order width=15 left; 
  define display_sn / order   width=4 left 'disp'; 
  define sn /      order      width=2 left 'sn';
  define dcms  /                       width=10 left 'Dcm';
  define subset_name /                 width=10 left 'Dcm_sub'; 
  define dcm_qg_nm        /            width=10 left 'qg_nam';  
  define collected_flag /              width=1  left 'qg_c'; 
  define repeating_flag /              width=1  left 'R';
  define mandatory_flag /              width=1  left 'M';
  define question_name /               width=8  left 'Quest';
  define occurrence_sn /               width=2  left 'ocur';
  define question_data_type_code /     width=6 left 'Type';
  define enterable_flag /              width=1  left 'E';
  define displayed_flag /              width=1  left 'W';
  define collected_flag0 /             width=1  left 'dcm_q';
  define derived_flag /                width=1  left 'Derv';
  define length /                      width=3  left 'Len';
  define collected_in_subset_flag /    width=1 left 'Col_sub';
  define decimal_places  /             width=3  left 'Dec';
  define has_repeat_defaults_flag /    width=1 left 'def_rep';
  define dvg_name /                    width=10 left 'dvg';
  define discrete_val_grp_subset_num / width=4 left 'dvg_num'; 
  footnote "R=repeating  M=Mandatory  E=Enterable  W=Displayed";
run; 

/* or export to Excel */

PROC EXPORT DATA= WORK.notebook 
            OUTFILE= "O:\My Documents\PROTO9999 dci dcm setup.xls" 
            DBMS=EXCEL2000 REPLACE;
RUN;




