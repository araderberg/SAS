***delete temp macros from the macro catalog;
proc catalog catalog=work.sasmacr; 
delete continuous / et=macro ; *delete the temporary macro %continuous from the work.sasmacr library;
quit;