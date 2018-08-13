libname all "T:\Research folders\CCWTG\Data\MERGEALL";

proc datasets lib=work memtype=data nolist kill; run;

data work.this_data; set all.Allwide;
run;

data no_start; Set this_data; RUN;


proc print data = this_data;
	VAR impnotes;
	where impnotes ne '';
RUN;

/*Remove these obsrervations due to consent: 
		21 - CCF15_1122, 64 - CCF15_1377, 180 - CCF16_3061, 258 - CCF16_3628,  426 - CCS16_2592*/

DATA this_data;
	set this_data; 
IF Final_ID = 'CCF15_1122' THEN DELETE;
IF Final_ID = 'CCF15_1377' THEN DELETE;
IF Final_ID = 'CCF16_3061' THEN DELETE;
IF Final_ID = 'CCF16_3628' THEN DELETE;
IF Final_ID = 'CCS16_2592' THEN DELETE;

IF no_start = 1 THEN DELETE; 
RUN;


	

/*Keeping necessary data*/

DATA this_data; 
	SET this_data;
		KEEP Final_ID semester -- kage1;
RUN;





/*setting individuals that dropped outcome variable = "start_drop"

These are individuals that started the program, but dropped at some point.

*/

DATA this_data;
	SET this_data; 
		IF DATE_Dropped ne . & no_start ne 1 THEN start_drop = 1;
	RUN;

/*"Drop" is a separate data set for the same analyses on no_start individuals */

DATA DROP; 
	SET this_data; 
	IF No_Start = 1 THEN DELETE;
	IF k0start = . THEN DELETE;
RUN;

proc print data = DROP;
	VAR k0start;
	RUN;



/*Setting 0's for logistic regression*/

DATA this_data; set this_data;
	IF start_drop = . THEN Start_Drop = 0;
RUN;
	

/*Composite score for CBCL*/
data this_data; Set this_data;
	cbcl = SUM(of p0cbcl_1 - p0cbcl_13);
RUN;


/*checking descriptivesof cbcl*/
proc Univariate data = this_data;
	VAR cbcl;
	HISTOGRAM;
RUN;

/*Slight positive skew*/



/*night & semester dummy variables*/
/*15 dummies total for 16 nights across 4 semesters. F15 Monday = reference - S17 Thursday (seprartated by night/semester*/

data this_data; set this_data;
/*F15*/
if 		Night='Monday' 		& Semester = 'F15'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end; 

if 		Night='Tuesday' 	& Semester = 'F15'	then do; 
	d1=1; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Wednesday'		 & Semester = 'F15'	then do; 
	d1=0; d2=1; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Thursday' 	& Semester = 'F15'	then do; 
	d1=0; d2=0; d3=1; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

/*S16*/
if 		Night='Monday' 		& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=1; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end; 

if 		Night='Tuesday' 	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=1; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Wednesday'	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=1;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Thursday' 	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=1; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;


/*F16*/
if 		Night='Monday' 		& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=1; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end; 

if 		Night='Tuesday' 	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=1; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Wednesday'	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=1; d11=0; d12=0; d13=0; d14=0; d15=0; end;

if 		Night='Thursday' 	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=1; d12=0; d13=0; d14=0; d15=0; end;



/*S17*/
if 		Night='Monday' 		& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=1; d13=0; d14=0; d15=0; end; 

if 		Night='Tuesday' 	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=1; d14=0; d15=0; end;

if 		Night='Wednesday'	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=1; d15=0; end;

if 		Night='Thursday' 	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=1; end;


/*F17*/
if 		Night='Monday' 		& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=1; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=1; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=1; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Thursday' 	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=1; d20=0; d21=0;  d22=0; d23=0;end;


/*S18*/
if 		Night='Monday' 		& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=1; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=1;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=1; d23=0;end;

if 		Night='Thursday' 	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=1;end;
Run;



/*Dummy coding ethnicity variables*/
/*compact and dummy code ethnicity
	1 = white
	2 = hispanic
	3 = other
		
	0|0 =white
	1|0 =Hispanic
	0|1 = other

*/

DATA This_data;
	SET This_Data;
	If mentee_eth =. THEN mentee_eth = pmentee_eth;
	If mentee_eth = 6 THEN ethnicity = 1;
	Else IF mentee_eth = 4 Then ethnicity =2;
	ELSE IF mentee_eth = . THEN ethnicity =.;
	ELSE Ethnicity = 3;
RUN; 

DATA This_data;
	Set This_data;
	IF ethnicity = 1 then do; e1=0; e2=0; end;
	IF ethnicity = 2 then do; e1=1; e2=0; end;
	IF ethnicity = 3 then do; e1=0; e2=1; end;
RUN;

	

proc freq data = This_data;
	TABLES d1 - d15 ethnicity;
RUN;

/*FOR NO_start individuals*/

data No_start; set No_start;
/*F15*/
if 		Night='Monday' 		& Semester = 'F15'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; 
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0; end; 

if 		Night='Tuesday' 	& Semester = 'F15'	then do; 
	d1=1; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0; end;

if 		Night='Wednesday'		 & Semester = 'F15'	then do; 
	d1=0; d2=1; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; 
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;  end;

if 		Night='Thursday' 	& Semester = 'F15'	then do; 
	d1=0; d2=0; d3=1; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; 
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;  end;

/*S16*/
if 		Night='Monday' 		& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=1; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0; 
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0; end; 

if 		Night='Tuesday' 	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=1; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=1;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Thursday' 	& Semester = 'S16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=1; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;


/*F16*/
if 		Night='Monday' 		& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=1; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=1; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=1; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Thursday' 	& Semester = 'F16'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=1; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;


/*S17*/
if 		Night='Monday' 		& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=1; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=1; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=1; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Thursday' 	& Semester = 'S17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=1;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;


/*F17*/
if 		Night='Monday' 		& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=1; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=1; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=1; d19=0; d20=0; d21=0;  d22=0; d23=0;end;

if 		Night='Thursday' 	& Semester = 'F17'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=1; d20=0; d21=0;  d22=0; d23=0;end;


/*S18*/
if 		Night='Monday' 		& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=1; d21=0;  d22=0; d23=0;end; 

if 		Night='Tuesday' 	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=1;  d22=0; d23=0;end;

if 		Night='Wednesday'	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=1; d23=0;end;

if 		Night='Thursday' 	& Semester = 'S18'	then do; 
	d1=0; d2=0; d3=0; d4=0; d5=0; d6=0;	d7=0; d8=0; d9=0; d10=0; d11=0; d12=0; d13=0; d14=0; d15=0;
	d16=0; d17=0; d18=0; d19=0; d20=0; d21=0;  d22=0; d23=1;end;
run; 



DATA No_start;
	SET No_start;
	If mentee eth =. & pmentee_eth ne . THEN mentee_eth = pmentee_eth;
	If mentee_eth = 6 THEN ethnicity = 1;
	Else IF mentee_eth = 4 Then ethnicity =2;
	ELSE IF mentee_eth = . THEN ethnicity =.;
	ELSE Ethnicity = 3;
RUN; 

DATA No_start;
	Set No_start;
	IF ethnicity = 1 then do; e1=0; e2=0; end;
	IF ethnicity = 2 then do; e1=1; e2=0; end;
	IF ethnicity = 3 then do; e1=0; e2=1; end;
RUN;



proc freq data = this_data; 
	TABLES semester;
RUN;

PROC Freq data = this_data; 
	TABLES start_drop;
RUN;


/*Risk Composite score*/

DATA this_data; set this_data; 
	Risk = mean(of p0risk_1 - p0risk_32);
RUN;

/*For No start*/

DATA No_Start; set No_start; 
	Risk = mean(of p0risk_1 - p0risk_32);
RUN;


/*Some descriptives*/
proc means data = this_data;
	VAR RISK p0income p0marstat p0educ;
RUN;

proc freq data = this_data;
	TABLES p0employ_1 - p0employ_8;
RUN;

proc freq data = this_data;
	TABLES p0educ;
RUN;


proc univariate data=This_data;
   var p0educ p0income;
   histogram;
run;

/*Start program but drop RISK*/
proc logistic descending data = this_data;
	model start_drop = RISK mentee_male kage1 p0income mentee_eth room d1 - d23;
RUN;


/*Quasi complete separation*/
proc print data = this_data; where d3 =1;
	VAR d3 start_drop;
RUN;

proc print data = this_data; where d8 =1;
	VAR d8 start_drop;
RUN;



data no_start; Set No_start;
	IF no_start = . THEN no_start = 0;
RUN;


/*No_start program*/

proc logistic descending data = No_start;
	model No_start = RISK mentee_male kage1 p0income e1 e2 room d1 - d23;
RUN;



/*Understanding increase effect*/

proc logistic descending data = this_data;
	model start_drop = RISK mentee_male kage1 p0income e1 e2 room d1 - d23 / scale=n aggregate lackfit;
	output out=pdat p=pihat;
	contrast '2 pt increase RISK' RISK 2/estimate=exp;
RUN;


/*						
https://www.mdrc.org/sites/default/files/Role%20of%20Risk_Final-web%20PDF.pdf

Internal

creating composite risk scores:

Academic challenges
•  My child is  currently failing or   at   risk    of   failing two    or   more classes/subjects in school. 
•  My child has    a  physical, emotional or   mental condition that interferes with or limits his/her ability to do schoolwork at grade 
level (for example, ADHD, ADD or a learning disability). 
•  My child missed school often this    past school year    (three or more times a month). 
•  My child is  learning English as   a  second language. 

Problem behavior
•  My child has    used or   experimented with    drugs or   alcohol. 
•  My child has    been suspended more than once from school in the last 12 months. 
•  My child has    been sent    to   juvenile hall    or   had    contact with    the police in the last 12 months.
•  My child has    run    away from home in  the    last    12   months.
•  My child belongs to   a  gang or   spends time    with    gang members. 
•  My child often picks fights with    other youth or   bullies them

Mental health concerns

•  My child often says he/she feels alone, sad, upset, cries a  lot or is unhappy.
•  My child has    been diagnosed with    a  mental health issue or is currently under the care of a mental health care provider (a therapist or counselor)

	
*/





/*Hosmer lemeshow Model fit = good (0.29)*/
/*There is Quasi complete separation because there are no instanceds of d3 and d8 that there was a dropout... do we need to worry about this with dummy variables?*/


/*Plot of our pihats*/

axis1 minor=none label=(f=swiss h=2.5 'RISK_Score'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Dropout'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=Pdat; 
plot (start_drop pihat)*RISK/haxis=axis1 vaxis=axis2; 
run; quit;

/*Clear trend as risk score goes up, drop out probability increases*/


/*Assessing scale for potntial fractional Polynomial procedures*/

* Multivariate scale assessment *; 
*___________________________________________________________________*; 
* *; 
* FP METHOD *; 
*___________________________________________________________________*;


** Macro for fp assessment **; 

 /* <- Remove is you want to run fp macro procedure

%macro fp1(dset,y,var,lb,p1); 
%do %until(&p1=7); 
%put ***** &p1 *****; 
ODS output FitStatistics = mfs; 
data fpdat; set &dset; if &var>&lb; pc=&p1/2; 
if pc ne 0 then F1=&var**pc; else if pc = 0 then F1=log(&var); 
run; 
proc logistic descending data=fpdat; 
model &y=F1 mentee_male kage1 p0income mentee_eth room d1 - d15; *-------------------F1 represents the variable being tested for scale (SYS); 
 
run; 
data mfs; set mfs; if criterion='-2 Log L'; drop Criterion InterceptOnly; run; 
proc append data=mfs base=tres; run; 
proc datasets; delete fpdat mfs; run; 
quit; 
%let p1=%eval(&p1+1); 
%end; 
%mend fp1; 
%fp1(This_Data, start_drop, RISK,0,-4); *-----------Enter data set name, outcome variable name and name of variable being tested for scale;

data pvals; do p1=-4 to 6; output; end; run; 
data pvals; set pvals; p1=p1/2; run; 
data tres; merge pvals tres; if p1 in (-1.5, 1.5, 2.5) then delete; run; 
proc sort data=tres; by InterceptAndCovariates; run; 
data tres; set tres; if _N_=1 or p1=1; run; 
%macro fp2(dset,y,var,lb,p1,p2); 
%do %until(&p1=7); 
%do %until(&p2=7); 
%put ***** &p1 &p2 *****; 
ODS output FitStatistics = mfs; 
data fpdat; set &dset; if &var>&lb; pc1=&p1/2; pc2=&p2/2; 
if pc1 ne 0 then F1=&var**pc1; else if pc1 = 0 then F1=log(&var); 
if pc1 ne pc2 then do; if pc2 ne 0 then F2=&var**pc2; 
else if pc2 = 0 then F2=log(&var); end; 
if pc1=pc2 then F2=F1*log(&var); 
run; 
proc logistic descending data=fpdat; 
model &y=F1 F2 mentee_male kage1 p0income mentee_eth room d1 - d15; *------------F1 and F2 represent the variable being tested for scale (height); 
run; 
data mfs; set mfs; if criterion='-2 Log L'; drop Criterion InterceptOnly; run; 
proc append data=mfs base=tres2; run; 
proc datasets; delete fpdat mfs; run; 
quit; 
%let p2=%eval(&p2+1); 
%end; 
%let p2=%eval(-4); 
%let p1=%eval(&p1+1); 
%end; 
%mend fp2; 
%fp2(This_Data, start_drop, RISK,0,-4,-4); *-----------Enter data set name, outcome variable name and name of variable being tested for scale; 
data pvals2; do p1=-4 to 6; do p2=-4 to 6; output;end; end; run; 
data pvals2; set pvals2; p1=p1/2; p2=p2/2; run; 
data tres2; merge pvals2 tres2; 
if p1 in (-1.5, 1.5, 2.5) or p2 in (-1.5, 1.5, 2.5) then delete; run; 
proc sort data=tres2; by InterceptAndCovariates; run; 
data tres2; set tres2; if _N_=1; run; 
data comb; set tres tres2; run; 
data c1; set comb; if p1=1 and p2=.; rename InterceptAndCovariates=Dev_linear; 
drop p1 p2; run; 

data c2; set comb; if p1 ne 1 and p2=.; rename InterceptAndCovariates=Dev_fp1; 
rename p1=e_fp1; drop p2; run; 
data c3; set comb; if p2 ne .; rename InterceptAndCovariates=Dev_fp2; 
rename p1=e1_fp2; rename p2=e2_fp2; run; 
data c; 
merge c1 c2 c3; 
diff_lin_fp1=Dev_linear-Dev_fp1; 
diff_lin_fp2=Dev_linear-Dev_fp2; 
diff_fp1_fp2=Dev_fp1-Dev_fp2; 
p_lin_fp1=1-probchi(diff_lin_fp1,1); 
p_lin_fp2=1-probchi(diff_lin_fp2,3); 
p_fp1_fp2=1-probchi(diff_fp1_fp2,2); 
run; 
proc print noobs data=c; 
var Dev_linear e_fp1 Dev_fp1 e1_fp2 e2_fp2 Dev_fp2 p_lin_fp1 p_lin_fp2 p_fp1_fp2; 
format p_lin_fp1 p_lin_fp2 p_fp1_fp2 6.4; 
run; 
proc datasets; delete tres tres2 pvals pvals2 comb c c1 c2 c3; run; quit;

*/

/*CONCLUSION: Best to assess RISK on a linear scale 07.19.17*/

/*GOF TESTS*/


proc logistic descending data = this_data;
	model start_drop = RISK mentee_male kage1 mfcond d2 d3 d4 s2 s3 s4 / scale=n aggregate lackfit;
RUN;

/*

Setting up Sem_night for proc glimmix class statement Random intercept procedure. Creates own dummy variables.

*/

DATA This_data;
	SET This_data;

		IF  Night='Monday' 		& Semester = 'F15'	then sem_night=1; 
		IF  Night='Tuesday' 	& Semester = 'F15'	then sem_night=2; 
		IF  Night='Wednesday' 	& Semester = 'F15'	then sem_night=3;
		IF  Night='Thursday' 	& Semester = 'F15'	then sem_night=4;

		IF  Night='Monday' 		& Semester = 'S16'	then sem_night=5; 
		IF  Night='Tuesday' 	& Semester = 'S16'	then sem_night=6; 
		IF  Night='Wednesday' 	& Semester = 'S16'	then sem_night=7;
		IF  Night='Thursday' 	& Semester = 'S16'	then sem_night=8;

		IF  Night='Monday' 		& Semester = 'F16'	then sem_night=9; 
		IF  Night='Tuesday' 	& Semester = 'F16'	then sem_night=10; 
		IF  Night='Wednesday' 	& Semester = 'F16'	then sem_night=11;
		IF  Night='Thursday' 	& Semester = 'F16'	then sem_night=12;

		IF  Night='Monday' 		& Semester = 'S17'	then sem_night=13; 
		IF  Night='Tuesday' 	& Semester = 'S17'	then sem_night=14; 
		IF  Night='Wednesday' 	& Semester = 'S17'	then sem_night=15;
		IF  Night='Thursday' 	& Semester = 'S17'	then sem_night=16;

		IF  Night='Monday' 		& Semester = 'F17'	then sem_night=17; 
		IF  Night='Tuesday' 	& Semester = 'F17'	then sem_night=18; 
		IF  Night='Wednesday' 	& Semester = 'F17'	then sem_night=19;
		IF  Night='Thursday' 	& Semester = 'F17'	then sem_night=20;

		IF  Night='Monday' 		& Semester = 'S18'	then sem_night=21; 
		IF  Night='Tuesday' 	& Semester = 'S18'	then sem_night=22; 
		IF  Night='Wednesday' 	& Semester = 'S18'	then sem_night=23;
		IF  Night='Thursday' 	& Semester = 'S18'	then sem_night=24;



	RUN;


 proc glimmix data=this_data;
      class sem_night ethnicity;
      model start_drop = RISK mentee_male kage1 ethnicity room sem_night / solution;
     random intercept;
   run;

proc sort data = this_data;
	BY start_drop;
	RUN;

/*Export results to excel table*/

   ODS TAGSETS.EXCELXP
file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\dropout.xls'
STYLE=minimal
OPTIONS ( Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );

 proc glimmix data=this_data;
      class sem_night ethnicity;
      model start_drop (order = freq ref=first)= RISK mentee_male kage1 ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;

ods tagsets.excelxp close;

/*Proc Gee not found... I guess proc GEE was created fr SAS Base version 9.4, Stat 13.2, we are running on 13.1*/
/**/
/*proc GEE data=This_data descend;*/
/*   class sem_night ethnicity;*/
/*   model model start_drop = RISK mentee_male kage1 p0income ethnicity room sem_night/*/
/*         dist=bin link=logit;*/
/*   repeated corr=exch corrw;*/
/*run;*/
/**/
/*   DATA genmod;*/
/*   	SET This_DATA;*/
/*		IF sem_night = . THEN DELETE;*/
/*	RUN;*/
/**/
/**/
/*   proc genmod DESCENDING data=genmod ;*/
/*   class sem_night ethnicity;*/
/*   model  start_drop = RISK mentee_male kage1 p0income ethnicity room sem_night  /  dist=bin;*/
/*   repeated  subject=sem_night / type=exch covb corrw;*/
/*run;*/

/*Having problems running the proc genmod GEE (indicated by the "repeated" statement. Get an error indicating it is not positive an dparamter estimates are off.*/


/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/ATTENDANCE POISSON*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;
/*POISSON REGRESSION -- Evaluating attendance in relation to RISK. IS there a relation between program attendance and the RISK MEASURE? */
/*PULL IN ATTENDANCE FILE AND SUM THE ATTENDANCE*/

data work.WEEKLY; set all.WEEKLY;
run;


DATA Atten;
	SET WEEKLY;
		KEEP Final_ID week present semester;
RUN;

DATA Atten_sum ;
  SET Atten ;
  BY Final_ID ;
 
  * this resets the running total to 0 at the start of a family ;
 
  IF first.Final_ID THEN
   DO;
    sum_pres = 0;
    cnt   = 0;
   END;
 
  sum_pres + present ;
  cnt + 1 ;
/*Output the last value observation*/
  IF last.Final_ID THEN
  	DO;
		OUTPUT;
	END;
RUN;


DATA Atten_SUM_final;
	SET Atten_SUM;
	KEEP FINAL_ID sum_pres;
RUN;

PROC sort DATA = Atten_sum_final;
	BY Final_ID;
RUN;

PROC SORT DATA = This_Data;
	BY Final_ID;
RUN;

DATA This_Data;
	MERGE This_data Atten_sum_final;
	BY Final_ID;
RUN;

DATA All_present;
	SET This_DATA;
/*	IF sum_pres = 0 THEN DELETE;*/
	IF sum_pres = . THEN DELETE;
RUN;

  proc genmod data=This_data;
      class sem_night ethnicity;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
/*                         																link   = log*/
                         																/*offset = ln*/;
   run;


/*Assessing Negative Binomial distribution*/
   proc genmod data=This_data;
      class sem_night ethnicity;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = negbin
/*                         																link   = log*/
                         																/*offset = ln*/;
   run;
/*NOTE: There was no difference in the numbers, but the negbin distribution had warnings that convergance did not appear*/

/*A NOTE: There was one day in S16 that there was a snow day... SHould this be excluded from the analyses? HENSE the max they could have is 11.*/



/*RISK estimate = - 0.0140 95%CI = [-0.0226 - -0.0054], p=0.0014  
   		INTERPRETATION: As risk decreases, We see a HIGHER chance of attendance (This is what we would expect, lower risk = better attendance)*/


/*   				Parameter   DF Estimate Standard Error Wald 95% Confidence Limits Wald Chi-Square Pr > ChiSq */
/*Intercept   		1 10.3520 5.2805 0.0023 20.7016 3.84 0.0499 */
/*Risk 			  1 -0.0140 0.0044 -0.0226 -0.0054 10.23 0.0014 */
/*mentee_male   1 0.0186 0.0320 -0.0441 0.0814 0.34 0.5610 */
/*kage1   1 -0.0320 0.0104 -0.0524 -0.0116 9.44 0.0021 */
/*p0income   1 0.0079 0.0109 -0.0135 0.0294 0.52 0.4691 */
/*ethnicity 1 1 -0.0511 0.0454 -0.1401 0.0378 1.27 0.2597 */
/*ethnicity 2 1 -0.0617 0.0507 -0.1610 0.0376 1.48 0.2232 */
/*ethnicity 3 0 0.0000 0.0000 0.0000 0.0000 . . */
/*room   1 -0.0523 0.0360 -0.1229 0.0183 2.11 0.1464 */
/*sem_night 1 1 -0.0764 0.0910 -0.2548 0.1020 0.70 0.4013 */
/*sem_night 2 1 0.1028 0.0878 -0.0693 0.2749 1.37 0.2418 */
/*sem_night 3 1 0.1515 0.0863 -0.0177 0.3206 3.08 0.0793 */
/*sem_night 4 1 0.0399 0.0884 -0.1333 0.2131 0.20 0.6514 */
/*sem_night 5 1 -0.1464 0.0894 -0.3216 0.0288 2.68 0.1015 */
/*sem_night 6 1 0.0475 0.0864 -0.1218 0.2168 0.30 0.5825 */
/*sem_night 7 1 -0.1256 0.0888 -0.2996 0.0484 2.00 0.1571 */
/*sem_night 8 1 0.0881 0.0864 -0.0812 0.2573 1.04 0.3079 */
/*sem_night 9 1 -0.0248 0.0948 -0.2107 0.1610 0.07 0.7934 */
/*sem_night 10 1 0.0448 0.0897 -0.1310 0.2207 0.25 0.6171 */
/*sem_night 11 1 0.0468 0.0901 -0.1298 0.2234 0.27 0.6036 */
/*sem_night 12 1 0.0279 0.0888 -0.1461 0.2019 0.10 0.7534 */
/*sem_night 13 1 0.0550 0.0899 -0.1212 0.2311 0.37 0.5408 */
/*sem_night 14 1 0.0574 0.0877 -0.1145 0.2293 0.43 0.5127 */
/*sem_night 15 1 0.1108 0.0894 -0.0645 0.2861 1.53 0.2155 */
/*sem_night 16 0 0.0000 0.0000 0.0000 0.0000 . . */
/*Scale   0 1.0000 0.0000 1.0000 1.0000     */


 DATA kids;
 	SET This_data;
KEEP k0start -- sum_pres;
RUN;

proc univariate data = KIDS;
	VAR  kage1;
RUN;


PROC FREQ data = This_Data;
	TABLES mentee_male ethnicity p0income;
RUN;

/*REmove S16 Wednesday. There was a snow day... Making their max attendance = 11 (Sem_night =7)*/

DATA snow_day;
	SET this_data;
IF sem_night = 7 THEN DELETE;
RUN;


DATA snow_day;
	SET snow_day;
	If sem_night = 8 THEN sem_night =7;
	If sem_night = 9 THEN sem_night =8;
	If sem_night = 10 THEN sem_night =9;
	If sem_night = 11 THEN sem_night =10;
	If sem_night = 12 THEN sem_night =11;
	If sem_night = 13 THEN sem_night =12;
	If sem_night = 14 THEN sem_night =13;
	If sem_night = 15 THEN sem_night =14;
	If sem_night = 16 THEN sem_night =15;
RUN;



proc freq data=snow_day;
tables  sum_pres / plots=freqplot;
run;


   ODS TAGSETS.EXCELXP
file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\attendance.xls'
STYLE=minimal
OPTIONS ( Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );

  proc genmod data=snow_day;
      class sem_night ethnicity;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																link   = log
                         																/*offset = ln*/;
   run;

ods tagsets.excelxp close;

/*RESULTS With removal of the night that had a snow day in it*/

/*   Analysis Of Maximum Likelihood Parameter Estimates */

/*Parameter  		DF 	Estimate 	Standard Error Wald 95% Confidence Limits Wald Chi-Square Pr > ChiSq */
/*/*Intercept   		1 	9.2134 		5.4112 			-1.3925 | 19.8192 				2.90 			0.0886 */  
/*Risk  		 	1 	-0.0145 	0.0045 			-0.0234 | -0.0056 				10.22 			0.0014 */ /*<- Risk score significantly predictive of attendance */
/*mentee_male   1 0.0271 0.0331 -0.0377 0.0919 0.67 0.4129 */
/*kage1   1 -0.0338 0.0107 -0.0547 -0.0129 10.08 0.0015 */
/*p0income   1 0.0076 0.0112 -0.0144 0.0296 0.46 0.4976 */
/*ethnicity 1 1 -0.0611 0.0474 -0.1540 0.0318 1.66 0.1975 */
/*ethnicity 2 1 -0.0788 0.0527 -0.1821 0.0245 2.24 0.1348 */
/*ethnicity 3 0 0.0000 0.0000 0.0000 0.0000 . . */
/*room   1 -0.0442 0.0369 -0.1166 0.0282 1.43 0.2312 */
/*sem_night 1 1 -0.0732 0.0911 -0.2517 0.1053 0.65 0.4216 */
/*sem_night 2 1 0.1029 0.0878 -0.0693 0.2750 1.37 0.2416 */
/*sem_night 3 1 0.1195 0.0864 -0.0498 0.2888 1.91 0.1664 */
/*sem_night 4 1 0.0420 0.0885 -0.1315 0.2154 0.22 0.6354 */
/*sem_night 5 1 -0.1428 0.0895 -0.3181 0.0325 2.55 0.1104 */
/*sem_night 6 1 0.0481 0.0864 -0.1213 0.2174 0.31 0.5781 */
/*sem_night 7 1 0.0906 0.0864 -0.0788 0.2601 1.10 0.2944 */
/*sem_night 8 1 -0.0211 0.0949 -0.2071 0.1648 0.05 0.8239 */
/*sem_night 9 1 0.0489 0.0897 -0.1270 0.2248 0.30 0.5856 */
/*sem_night 10 1 0.0469 0.0901 -0.1297 0.2236 0.27 0.6026 */
/*sem_night 11 1 0.0007 0.0890 -0.1737 0.1751 0.00 0.9936 */
/*sem_night 12 1 0.0603 0.0899 -0.1160 0.2365 0.45 0.5026 */
/*sem_night 13 1 0.0609 0.0878 -0.1111 0.2330 0.48 0.4876 */
/*sem_night 14 1 0.1158 0.0895 -0.0597 0.2912 1.67 0.1960 */
/*sem_night 15 0 0.0000 0.0000 0.0000 0.0000 . . */
/*Scale   	0 1.0000 0.0000 1.0000 1.0000   */

/*In summary, the lower the risk score, the more likely mentees are to attend CC sessions*/





/*NEW: 	MODEL 1 = Overall Risk
		MODEL 2 = internal Risk
		MODEL 3 = external Risk */



/*

Environmental Risk:


Variable	Description

p0risk_1	This child lives in a public housing development.
p0risk_2	This child could be forced to leave or be evicted from his/her home.
p0risk_3	In the last 12 months, there have been times when the child’s family hasn’t been able to pay bills.
p0risk_4	There are gangs or illegal drugs in the neighborhood where the child lives.
p0risk_5	No adult in the child’s household has a full-time job.
p0risk_6	The child’s household income is below $20,000.
p0risk_7	The child’s family receives food stamps.
p0risk_8	This child lives with a foster family.
p0risk_9	One or more members of this child’s family (including the child him or herself) has been in foster care in the past 5 years.
p0risk_10	One or more members of this child’s family struggles with alcohol or drug use.
p0risk_11	One or more members of this child’s family is in jail or prison or is often in trouble with the police.
p0risk_12	This child lives with only one parent, guardian or other adult who takes care of him/her.
p0risk_13	This child has moved or changed where he or she lives two or more times in the last 12 months.
p0risk_14	This child’s parents separated or broke up in the last year (for example, they started living in different places).
p0risk_15	This child has seen or experienced many fights or arguments at home in the last 12 months.
p0risk_16	This child has lost (due to death) or lost contact with an important adult role model in the last 12 months (for example, a parent or other important adult died or moved out of the home).
p0risk_17	This child has experienced homelessness in the last five years.
p0risk_18	One or more of the child’s parents dropped out of high school.
p0risk_19	This child doesn’t have any close friends at school or in the neighborhood.
p0risk_20	This child has been picked on or bullied at school or in the neighborhood in the last 12 months.

*/


/*create composite external risk*/


DATA This_data;
	Set This_data;
	RISK_ext = mean(of 
					p0risk_1 -p0risk_20)
	;
	RUN;

/* Internal Risk

Variable	Description

p0risk_21	In the last 12 months, this child has failed (or is currently at risk of failing) two or more classes/subjects in school.
p0risk_22	This child has a physical, emotional or mental condition that interferes with or limits his/her ability to do schoolwork at grade level (for example, ADHD, ADD or a learning disability).
p0risk_23	This child missed school often this past school year (three or more times a month).
p0risk_24	This child is learning English as a second language.
p0risk_25	This child has used or experimented with drugs or alcohol.
p0risk_26	This child has been suspended from school more than once in the last 12 months.
p0risk_27	This child has been sent to the juvenile hall or had contact with the police in the last 12 months.
p0risk_28	This child has run away from home in the last 12 months.
p0risk_29	This child belongs to a gang or spends time with gang members.
p0risk_30	This child often picks fights with other youth or bullies them.
p0risk_31	This child often says he/she feels alone, sad, upset, cries a lot or is unhappy.
p0risk_32	This child has been diagnosed with a mental health issue or is currently under the care of a mental health care provider (a therapist or counselor).


*/



DATA this_data;
	Set This_data;
	RISK_int = mean(of 
					p0risk_21 -p0risk_32)
	;
	RUN;

/*Histoigrams of RISK External_Risk & Internal_RISK*/
proc univariate data=This_data;
   var RISK RIsk_ext Risk_int;
   histogram;
run;



DATA No_start;
	Set No_start;
		IF p0income = 1 then do; i1=0; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 2 then do; i1=1; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 3 then do; i1=0; i2=1;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 4 then do; i1=0; i2=0;i3=1; i4=0;	i5=0;		 end;
		IF p0income = 5 then do; i1=0; i2=0;i3=0; i4=1;	i5=0;		 end;
		IF p0income = 6 then do; i1=0; i2=0;i3=0; i4=0;	i5=1;	 	 end;
RUN;

DATA This_Data;
	Set This_Data;
		IF p0income = 1 then do; i1=0; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 2 then do; i1=1; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 3 then do; i1=0; i2=1;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 4 then do; i1=0; i2=0;i3=1; i4=0;	i5=0;		 end;
		IF p0income = 5 then do; i1=0; i2=0;i3=0; i4=1;	i5=0;		 end;
		IF p0income = 6 then do; i1=0; i2=0;i3=0; i4=0;	i5=1;	 	 end;
RUN;


/*Final Models for logistic regression model*/

ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\log_RISK.rtf' style=Journal;
 proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;
 ods rtf close;

/*fp procedure results*/
/*   The SAS System */
/**/
/**/
/*Dev_linear e_fp1 Dev_fp1 e1_fp2 e2_fp2 Dev_fp2 p_lin_fp1 p_lin_fp2 p_fp1_fp2 */
/*231.581 0.5 231.139 -2 1 230.852 0.5059 0.8663 0.8663 */

/*CONCLUSION: NO NEED TO change the data*/


ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\log_ext.rtf' style=Journal;
 proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK_ext mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;
 ods rtf close;

   /*fp procedure results*/
/*The SAS System */
/**/
/**/
/*Dev_linear e_fp1 Dev_fp1 e1_fp2 e2_fp2 Dev_fp2 p_lin_fp1 p_lin_fp2 p_fp1_fp2 */
/*220.570 0.5 220.490 3 3 218.219 0.7766 0.5027 0.3212 */
/*CONCLUSION: NO NEED TO change the data*/

ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\log_int.rtf' style=Journal;
 proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK_int mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;
 ods rtf close;

   /*fp procedure results*/
/*The SAS System */
/**/
/**/
/*Dev_linear e_fp1 Dev_fp1 e1_fp2 e2_fp2 Dev_fp2 p_lin_fp1 p_lin_fp2 p_fp1_fp2 */
/*220.199 0.5 220.193 -2 3 218.408 0.9382 0.6170 0.4097 */
/*CONCLUSION: NO NEED TO change the data*/



/*FINAL MODELS FOR POISSON REGRESSION MODEL*/





DATA this_data;
	SET this_data;
		where p0income ne . & ethnicity ne . & mentee_male ne . & p0income ne . & ethnicity ne . & room ne . & sem_night ne .;
	RUN;



ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\descriptives.rtf' style=Journal;
PROC FREQ data = this_data;
	TABLES p0income ethnicity mentee_male;
RUN;
 ods rtf close;


ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\descriptives_age.rtf' style=Journal;
PROC MEANS data = this_data;
	VAR kage1;
RUN;
 ods rtf close;




DATA snow_day;
	Set snow_day;
	RISK_ext = mean(of 
					p0risk_1 -p0risk_20)
	;
	RUN;



DATA snow_day;
	Set snow_day;
	RISK_int = mean(of 
					p0risk_21 -p0risk_32)
	;
	RUN;




	DATA snow_day;
	Set snow;
		IF p0income = 1 then do; i1=0; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 2 then do; i1=1; i2=0;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 3 then do; i1=0; i2=1;i3=0; i4=0;	i5=0;		 end;
		IF p0income = 4 then do; i1=0; i2=0;i3=1; i4=0;	i5=0;		 end;
		IF p0income = 5 then do; i1=0; i2=0;i3=0; i4=1;	i5=0;		 end;
		IF p0income = 6 then do; i1=0; i2=0;i3=0; i4=0;	i5=1;	 	 end;
RUN;

ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\pois_RISK.rtf' style=Journal;
  proc genmod data=snow_day;
      class sem_night ethnicity p0income;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																link   = log
                   																/*offset = ln*/;
   run;
 ods rtf close;

ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\pois_ext.rtf' style=Journal;
  proc genmod data=snow_day;
      class sem_night ethnicity p0income;
      model sum_pres = RISK_ext mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																link   = log
                   																/*offset = ln*/;
   run;
 ods rtf close;


ods rtf file='T:\Research folders\CCWTG\Analyses\Papers\Dropout\Tables\pois_int.rtf' style=Journal;
  proc genmod data=snow_day;
      class sem_night ethnicity p0income;
      model sum_pres = RISK_int mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																link   = log
                   																/*offset = ln*/;
   run;
 ods rtf close;





proc freq data = this_data;
	TABLES start_drop;
RUN;

proc freq data = DROP;
	TABLES start_drop;
RUN;





proc freq data = This_data;
	TABLES start_drop*sum_pres;
RUN;

proc means data = This_data;
/*	where start_drop =1;*/
VAR sum_pres;
RUN;


proc print data = this_data;
where start_drop =0 & sum_pres <6;
VAR FINAL_ID start_drop sum_pres;
run;










































/*Assessing scale for potntial fractional Polynomial procedures*/

* Multivariate scale assessment *; 
*___________________________________________________________________*; 
* *; 
* FP METHOD *; 
*___________________________________________________________________*;


** Macro for fp assessment **; 

 /* <- Remove is you want to run fp macro procedure

%macro fp1(dset,y,var,lb,p1); 
%do %until(&p1=7); 
%put ***** &p1 *****; 
ODS output FitStatistics = mfs; 
data fpdat; set &dset; if &var>&lb; pc=&p1/2; 
if pc ne 0 then F1=&var**pc; else if pc = 0 then F1=log(&var); 
run; 
proc logistic descending data=fpdat; 
model &y=F1 mentee_male kage1 i1 - i5 e1 e2 room d1 - d15; *-------------------F1 represents the variable being tested for scale (SYS); 
 
run; 
data mfs; set mfs; if criterion='-2 Log L'; drop Criterion InterceptOnly; run; 
proc append data=mfs base=tres; run; 
proc datasets; delete fpdat mfs; run; 
quit; 
%let p1=%eval(&p1+1); 
%end; 
%mend fp1; 
%fp1(This_Data, start_drop, RISK_int,0,-4); *-----------Enter data set name, outcome variable name and name of variable being tested for scale;

data pvals; do p1=-4 to 6; output; end; run; 
data pvals; set pvals; p1=p1/2; run; 
data tres; merge pvals tres; if p1 in (-1.5, 1.5, 2.5) then delete; run; 
proc sort data=tres; by InterceptAndCovariates; run; 
data tres; set tres; if _N_=1 or p1=1; run; 
%macro fp2(dset,y,var,lb,p1,p2); 
%do %until(&p1=7); 
%do %until(&p2=7); 
%put ***** &p1 &p2 *****; 
ODS output FitStatistics = mfs; 
data fpdat; set &dset; if &var>&lb; pc1=&p1/2; pc2=&p2/2; 
if pc1 ne 0 then F1=&var**pc1; else if pc1 = 0 then F1=log(&var); 
if pc1 ne pc2 then do; if pc2 ne 0 then F2=&var**pc2; 
else if pc2 = 0 then F2=log(&var); end; 
if pc1=pc2 then F2=F1*log(&var); 
run; 
proc logistic descending data=fpdat; 
model &y=F1 F2 mentee_male kage1 i1 - i5 e1 e2 room d1 - d15; *------------F1 and F2 represent the variable being tested for scale (height); 
run; 
data mfs; set mfs; if criterion='-2 Log L'; drop Criterion InterceptOnly; run; 
proc append data=mfs base=tres2; run; 
proc datasets; delete fpdat mfs; run; 
quit; 
%let p2=%eval(&p2+1); 
%end; 
%let p2=%eval(-4); 
%let p1=%eval(&p1+1); 
%end; 
%mend fp2; 
%fp2(This_Data, start_drop, RISK_int,0,-4,-4); *-----------Enter data set name, outcome variable name and name of variable being tested for scale; 
data pvals2; do p1=-4 to 6; do p2=-4 to 6; output;end; end; run; 
data pvals2; set pvals2; p1=p1/2; p2=p2/2; run; 
data tres2; merge pvals2 tres2; 
if p1 in (-1.5, 1.5, 2.5) or p2 in (-1.5, 1.5, 2.5) then delete; run; 
proc sort data=tres2; by InterceptAndCovariates; run; 
data tres2; set tres2; if _N_=1; run; 
data comb; set tres tres2; run; 
data c1; set comb; if p1=1 and p2=.; rename InterceptAndCovariates=Dev_linear; 
drop p1 p2; run; 

data c2; set comb; if p1 ne 1 and p2=.; rename InterceptAndCovariates=Dev_fp1; 
rename p1=e_fp1; drop p2; run; 
data c3; set comb; if p2 ne .; rename InterceptAndCovariates=Dev_fp2; 
rename p1=e1_fp2; rename p2=e2_fp2; run; 
data c; 
merge c1 c2 c3; 
diff_lin_fp1=Dev_linear-Dev_fp1; 
diff_lin_fp2=Dev_linear-Dev_fp2; 
diff_fp1_fp2=Dev_fp1-Dev_fp2; 
p_lin_fp1=1-probchi(diff_lin_fp1,1); 
p_lin_fp2=1-probchi(diff_lin_fp2,3); 
p_fp1_fp2=1-probchi(diff_fp1_fp2,2); 
run; 
proc print noobs data=c; 
var Dev_linear e_fp1 Dev_fp1 e1_fp2 e2_fp2 Dev_fp2 p_lin_fp1 p_lin_fp2 p_fp1_fp2; 
format p_lin_fp1 p_lin_fp2 p_fp1_fp2 6.4; 
run; 
proc datasets; delete tres tres2 pvals pvals2 comb c c1 c2 c3; run; quit;
*/


/*CONCLUSION: Best to assess RISK on a linear scale 07.19.17*/









