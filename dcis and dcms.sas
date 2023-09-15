/*This query retrieves DCI Name and the DCMs assigned to it*/
select distinct a.short_name, b.dcm_id, c.dcm_module_sn
from dcis a,
     dcms b,
	 dci_modules c
where c.clinical_study_id=123456
and c.dci_id=a.dci_id
and c.dcm_id=b.dcm_id
order by a.short_name