proc datasets lib=work memtype=data nolist kill; run;


/*This file is created to quickly idenitfy siblings from semester to semester using the intake master sheets
	Change the filepath to the desired intake spreadsheet semester and it will filter out mentees with the same parent at intake
		Please be careful... sometimes different parents may be assigned at the intake.*/

/*Import Fall 15*/
proc import datafile="T:\Research folders\CCWTG\Analyses\NEIL\Intake Master Tracking F17.xlsx"
out=Intake dbms=xlsx Replace; Sheet = "Master Spreadsheet"; datarow=3;   getnames=NO;
run;


proc freq data = INTAKE;
	TABLE B / out = freq NOPRINT;
RUN;


PROC PRINT DATA = Freq;
	Where COUNT > 1;
RUN;


PROC SORT DATA = INTAKE;
	BY B;
RUN;

PROC SORT DATA = Freq;
	By B;
RUN;

DATA Freq_In;
	Merge Freq INTAKE;
	BY B;
RUN;



DATA Sibs;
	SET Freq_In;
IF COUNT >1 THEN OUTPUT Sibs;
RUN;


DATA SIBS_2;
	SET Sibs;
KEEP B F G;
RUN;

PROC SORT DATA = Sibs_2; 
	BY G B;
RUN;

/*	
	B = Guardian name
	F = Relationship with mentee
	G = Mentee Name
*/
PROC PRINT DATA = Sibs_2;RUN;
/**/
