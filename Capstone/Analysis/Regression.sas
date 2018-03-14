proc datasets lib=work memtype=data nolist kill; run;

libname finalF15 "T:\Research folders\CCWTG\Data\Fall2015\FINALDATA";
libname finalS16 "T:\Research folders\CCWTG\Data\Spring2016\FINALDATA";
libname CAPSTONE "T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\DATA";



DATA work.F15_master;
	Set Finalf15.MASTER;
RUN;

DATA work.S16_master;
	Set FinalS16.MASTER;
RUN;

DATA work.Master_FINAL;
	SET work.F15_master
		work.S16_master;
RUN;

DATA mentee_age;	
	SET MASTER_Final;
		IF Semester = "F15" THEN AGE = (2015 - Mentee_byear);
		IF Semester = "S16" THEN AGE = (2016 - Mentee_byear);
	KEEP FINAL_ID AGE MENTEE_MALE;
RUN;


Data Mentee_Age;
	LENGTH Final_ID 	$11.;
 	FORMAT Final_ID 	$11.;
   	INFORMAT Final_ID 	$11.;
	SET Mentee_Age;
		Final_ID = CAT('K', Final_ID); 
RUN;





/**/
/**IMPORT ALL FILES;*/
/**/
/*data work.mentorsf15;*/
/*	SET finalF15.Mentors;*/
/*RUN;*/
/**/
/*data work.mentorsS16;*/
/*	SET finalS16.Mentors;*/
/*RUN;*/
/**/
/**/
/*data work.menteesf15;*/
/*	SET finalF15.Mentees;*/
/*RUN;*/
/**/
/*data work.menteesS16;*/
/*	SET finalS16.Mentees;*/
/*RUN;*/

/**/
/*DATA mentor;*/
/*	SET	Mentorsf15*/
/*		MentorsS16;*/
/*RUN;*/
/**/
/*DATA mentee;*/
/*	SET	Menteesf15*/
/*		MenteesS16;*/
/*RUN;*/


proc import datafile="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\DATA\network_data.csv" 
out=Network_data dbms=csv replace; guessingrows=32767; getnames=yes;
run;

proc import datafile="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\DATA\mentor.csv" 
out=Mentor dbms=csv replace; guessingrows=32767; getnames=yes;
run;

proc import datafile="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\DATA\mentee.csv" 
out=Mentee dbms=csv replace; guessingrows=32767; getnames=yes;
run;

proc import datafile="T:\Research folders\CCWTG\Analyses\Data for Stats Dept\FINAL DATA\Mentee_Attributes.csv"
out=MenteeAtt dbms=csv replace; guessingrows=32767; getnames=yes;
run;


/*Sorting datasets*/


Proc Sort Data = Mentor;
	BY Final_ID;
RUN;

Proc Sort Data = Mentee;
	BY Final_ID;
RUN;


Proc Sort Data = Network_data;
	BY Final_ID;
RUN;

Proc Sort Data = Mentee_Age;
	BY Final_ID;
RUN;

/*Create MAtching Final_ID's (Match with relationships FIle 
	Putting an "M" and "K" In front of file*/

Data Mentee;
	LENGTH Final_ID 	$11.;
 	FORMAT Final_ID 	$11.;
   	INFORMAT Final_ID 	$11.;
	SET Mentee;
		Final_ID = CAT('K', Final_ID); 
RUN;

Data Mentee2;
	SET Mentee;
	KEEP Final_ID -- ccblng5 semester mentee_eth;
RUN;



Data Mentor;
	LENGTH Final_ID 	$11.;
 	FORMAT Final_ID 	$11.;
   	INFORMAT Final_ID 	$11.;
	SET Mentor;
		Final_ID = CAT('M', Final_ID); 
RUN;



/*Merge with inbounds with mentors*/


data mentor; 
	SET mentor;
Mentor = FINDC(Final_ID, 'M', "i");

RUN;

data mentor_final; 
	merge Network_data /*in=one)*/ mentor /*(in=two)*/; 
/*		if one; */
	by Final_ID; 
IF Mentor ne 1 THEN DELETE;
run;


data mentee2; 
	SET mentee2;
Mentee = FINDC(Final_ID, 'K', "i");
RUN;

DATA mentee2;
	merge Mentee_Age mentee2;
	By Final_ID;
RUN;

data mentee_final; 
	merge Network_data/*(in=one)*/ mentee2 /*(in=two)*/; 
	/*	if one; */
	by Final_ID; 
IF Mentee ne 1 THEN DELETE;
IF day = "" THEN DELETE;
run;






/*Creating dummy variables*/



/*Variable	Description*/
/*mentee_eth	Mentee’s self-reported race/ethnicity (1=American Indian, 2=Asian, 3=Black, 4=Hispanic, 5=Hawaiian, 6=White, 7=Mixed)*/


DATA Mentee_FInal;
	SET Mentee_Final;
		IF Mentee_eth = 6 THEN eth = 0;
		IF Mentee_eth = 4 THEN eth = 1;
		IF mentee_eth = 1 THEN eth = 2;
		IF mentee_eth = 2 THEN eth = 2;
		IF mentee_eth = 3 THEN eth = 2;
		IF mentee_eth = 5 THEN eth = 2;
		IF mentee_eth = 7 THEN eth = 2;
RUN;

DATA Mentee_FInal;
	SET Mentee_Final;
		IF 			eth=0	 		then do; 		 e2=0; e3=0; end; 
		IF 			eth=1	 		then do; 		 e2=1; e3=0; end; 
		IF 			eth=2	 		then do; 		 e2=0; e3=1; end; 
RUN;


DATA Mentee_Final;
	SET Mentee_Final;
	IF 			day=	"monday" 		then do; 		 d2=0; d3=0; d4=0; end; 
		else IF day=	"tuesday" 		then do; 		 d2=1; d3=0; d4=0; end; 
		else IF day=	"wednesday" 	then do; 		 d2=0; d3=1; d4=0; end; 
		else IF day=	"thursday" 		then do; 		 d2=0; d3=0; d4=1; end; 
RUN;


DATA Mentor_Final;
	SET Mentor_Final;
	IF 			day=	"monday" 		then do; 		 d2=0; d3=0; d4=0; end;  
		else IF day=	"tuesday" 		then do; 		 d2=1; d3=0; d4=0; end;  
		else IF day=	"wednesday" 	then do; 		 d2=0; d3=1; d4=0; end;  
		else IF day=	"thursday" 		then do; 		 d2=0; d3=0; d4=1; end;  
RUN;


Data mentee_final; 
	SET mentee_final;
		IF 		day=	"monday" 	then 		day2=1;  
		else IF day=	"tuesday" 		then 		day2=2;  
		else IF day=	"wednesday" 	then 		day2=3;
		else IF day=	"thursday" 		then 		day2=4; 
RUN;

DATA menteeatt;*_control;
	Set Menteeatt;
	IF mfcond = 1 THEN DELETE;
RUN;

Proc Sort data = Menteeatt;*_control;
	By FINAL_ID;
RUN;

Proc Sort data = Mentee_final;
	By FINAL_ID;
RUN;


DATA mentee_final;
	Merge mentee_final menteeatt; *Menteeatt_control;
	BY Final_ID;
RUN;


proc univariate data = Mentee_Final;
	VAR gs_inbound4_norm gs_outbound4_norm Symmetric_4;
	HISTOGRAM gs_inbound4_norm gs_outbound4_norm Symmetric_4;
RUN;


proc univariate data = Mentee_Final;
	VAR cesd0;
	HISTOGRAM cesd0;
RUN;

proc univariate data = Mentee_Final;
	VAR cesd5;
	HISTOGRAM cesd5;
RUN;

/*gs outbound unevenly distributed*/

DATA mentee_final;
	SET mentee_final;
		plus_inbound4 = gs_inbound4_norm +1;
		log_inbound4 = log(plus_inbound4);


		plus_outbound4 = gs_outbound4_norm +1;
		log_outbound4 = log(plus_outbound4);

		plus_Symmetric_4 = Symmetric_4 +1;
		log_Symmetric_4 = log(plus_Symmetric_4);
	RUN;

	data mentee_final;
		SET mentee_final;
		IF day2 = . THEN DELETE;
	RUN;

proc REG data= mentee_Final;
	model Cesd5	= CESD0 gender d2 d3 e2 e3; 
run; 


proc REG data= mentee_Final;
	model Cesd5	= CESD0 gender d2 d3 e2 e3 gs_inbound4_norm log_outbound4 log_Symmetric_4; 
run; 


/*Creating interaction terms*/

DATA Mentee_Final;
	SET Mentee_FInal;
	inout_int = gs_inbound4_norm*log_outbound4;
	outrec_int = log_outbound4*log_Symmetric_4;
	inrec_int  = log_inbound4*log_Symmetric_4;

RUN;






/*FINAL MODEL*/

proc REG data= mentee_Final;
	model Cesd5	= CESD0 gender d2 d3 e2 e3 AGE log_inbound4 log_outbound4 log_Symmetric_4     			
	/*Interactions*/	 inrec_int; 

	
run; 

data mentee_final;
	SET mentee_final;
if cesd5 = . THEN DELETE;
if cesd0 = . THEN DELETE;
RUN;



proc means data = mentee_final;
	VAR  mentee_male AGE cesd0 cesd5;
RUN;

/*
Mean age = 14.06 Range = 11 - 18
		65% male adolescents
*/





/*/*proc glm data = mentee_Final;*/*/
/*/*model Cesd5	= CESD0 gender d2 d3 e2 e3 gs_inbound4_norm log_outbound4 log_Symmetric_4     			*/*/
/*/*	/*Interactions*/	 inrec_int / ss1 ss2 effectsize alpha = 0.05;*/*/
/*/*model Cesd5	= CESD0 gender d2 d3 e2 e3 / ss1 ss2 effectsize alpha = 0.05 ;*/*/
/*/*run;*/*/
	




/*End-Dep = Bo + [B-baselineDepX1 + B-GenderX2 + B-NightX3 + B-EthnicityX4 + B-AgeX5] 														<--- REDUCED
	FULL-->													+ B-inboundX6 + B-outboundX7 + B-reciprocatedX8 + B-Inboundx6*ReciprocatedX8/;

/*FULL VS REDUCED MODEL Hypothesis Test
	Ho: Full predictive = Reduced Predictive
	Ha: Full predictive ne Reduced Predictive 	
*/

proc means data = mentee_final;
	VAR inrec_int;
RUN;



PROC REG data = mentee_final;
	model CESD5 = CESD0 gender d2 d3 e2 e3 AGE log_inbound4 log_outbound4 log_Symmetric_4    			
	/*Interactions*/	 inrec_int / ss1 ss2 alpha = 0.05 clb /*cli clm*/;
	Reduced: 	test log_inbound4 = log_outbound4 = log_Symmetric_4 = inrec_int = 0;
RUN;
/*Full R2 = 0.62*/
/*Partial F(4,71) = 2.89 p = 0.283*/


/*Reduced Model*/

PROC REG data = mentee_final;
	model CESD5 = CESD0 gender d2 d3 e2 e3 AGE / alpha = 0.05 clb;
	RUN;

/*	R2 = 0.55*/




proc univariate data = mentee_final;
	VAR inrec_int;
RUN;

ODS Graphics ON;
proc corr data = mentee_final plots=matrix;
	var inrec_int CESD5;
RUN;
ODS Graphics OFF;


DATA mentee_FInal;
	SET mentee_FINAL;
	if inrec_int = 0 THEN test = 0;
	if inrec_int > 0 THEN test = 1;
RUN;

proc univariate data = mentee_final;
	VAR test;
RUN;


proc freq data = mentee_final;
	


proc standard data = mentee_final mean=0 std=1
              out=stndtest;
			VAR gs_inbound4_norm log_outbound4 log_Symmetric_4 inrec_int;
run;


PROC REG data = Stndtest;
	model CESD5 = CESD0 gender d2 d3 e2 e3 AGE gs_inbound4_norm log_outbound4 log_Symmetric_4  			
	/*Interactions*/	inrec_int /  ALPHA = 0.05 CLB;
/*	Noint: 		test inrec_int = 0;*/
	Reduced: 	test gs_inbound4_norm = log_outbound4 = log_Symmetric_4 =  inrec_int = 0;
RUN;




DATA mentee_final;
	SET mentee_final;
	plus_ccblng0 = ccblng0 +1;

	log_ccblng0 = log(plus_ccblng0);
run;

/*CCblng*/
proc reg data = mentee_final;
	model CCblng5 = log_ccblng0 gender d2 d3 e2 e3 gs_inbound4_norm log_outbound4 log_Symmetric_4     			
	/*Interactions*/	/* inrec_int */ / ss1 ss2;
/*	Noint: 		test inrec_int = 0;*/
	Reduced: 	test gs_inbound4_norm = log_outbound4 = log_Symmetric_4/* = inrec_int*/ = 0;
RUN;




DATA mentee_final;
	SET mentee_final;
	IF CESD5 = . THEN DELETE;
	IF gs_inbound4_norm = . THEN DELETE;
	IF log_outbound4 = . THEN DELETE;
	IF log_Symmetric_4  = . THEN DELETE;
	IF gender = . THEN DELETE;
	IF d2 = . THEN DELETE;
	IF d3 = . THEN DELETE;
	IF inrec_int = . THEN DELETE;
RUN;



proc univariate data = mentee_final;
	VAR CESD5;
RUN;



DATA Depression;
	SET Mentee_FInal;
	KEEP Final_ID CESD5 CESD0;
RUN;

Proc SOrt data = Menteeatt;
	BY FInal_ID;
RUN;

Proc sort data = Depression;
	BY Final_ID;
RUN;

DATA MenteeAtt;
	merge MenteeAtt Depression;
	BY Final_ID;
	IF CESD5 = . THEN DELETE;
RUN;

DATA MenteeAtt;
	SET MenteeAtt;
IF CESD5  < 2.000001THEN CESD_cat = 1;
ELSE IF CESD5 >2 THEN CESD_cat = 2;
RUN;




PROC EXPORT DATA=menteeatt
   OUTFILE="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\DATA\Dep_Att.xlsx"
   DBMS=xlsx REPLACE;
   PUTNAMES= YES;
RUN;




proc univariate data = Mentee_Final;
	VAR CESD5;
RUN;

proc univariate data = Mentee_Final;
	VAR eth;
RUN;

proc freq data = mentee_FInal;
	TABLE eth;
RUN;

proc univariate data = Mentee_Final;
	VAR gs_inbound4_norm log_outbound4 log_Symmetric_4;
	HISTOGRAM gs_inbound4_norm log_outbound4 log_Symmetric_4;
RUN;


proc univariate data = Mentee_Final;
	VAR ccblng0;
	HISTOGRAM ccblng0;
RUN;

DATA depression;
		SET MENTEE_FINAL;
			KEEP FINAL_ID night CESD0 CESD5;
		RUN;

PROC EXPORT DATA=depression
   OUTFILE="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\Analysis\depression.csv"
   DBMS=CSV REPLACE;
   PUTNAMES= YES;
RUN;
/**/

/*PROC EXPORT DATA=mentee_Final*/
/*   OUTFILE="T:\Research folders\CCWTG\Analyses\Papers\NEIL CAPSTONE\Analysis\mentee_final.csv"*/
/*   DBMS=CSV REPLACE;*/
/*   PUTNAMES= YES;*/
/*RUN;*/
/**/



;
proc REG data= mentee_Final;
	model Cesd5	= CESD0 gender d2 d3; 
run;


proc GLM data= mentee_Final;
	model Cesd5	=	CESD0 gender d2 d3; 
run; 

proc corr; var gs_inbound4_norm gs_outbound4_norm;
Run;

proc reg data= mentee_Final;
	model ccblng5	=	gender d2 d3 room Sym_Out_4 Indeg_4; 
run; 






/**/
/**/
/*data eth; */
/*	SET mentee; */
/*	KEEP Final_ID semester mentee_eth pmentee_eth;*/
/*RUN;*/
/**/
/*proc sort data = eth;*/
/*	BY Final_ID;*/
/*RUN;*/
/**/
/*proc sort data = mentee_Final;*/
/*	BY Final_ID;*/
/*RUN;*/
/**/
/*data mentee_final;*/
/*	merge mentee_final eth;*/
/*/*	IF day = "" THEN DELETE;*/*/
/*RUN;*/
/**/
/**/
/*Proc sort data = menteeatt;*/
/*	BY Final_ID;*/
/*RUN;*/
/**/
/*Data mentee_Final; */
/*	merge mentee_final menteeatt;*/
/*	By Final_ID;*/
/*	IF Day = "" THEN Delete;*/
/*	If role = "" THEN DELETE;*/
/*RUN;*/
/**/
/**/
;

PROC FREQ data = Mentor_final;
	TABLES Final_ID;
RUN;




proc print data = Stndtest;
	VAR gs_inbound4_norm log_outbound4 log_Symmetric_4;
RUN;


ODS Graphics ON;
proc CORR data = Stndtest; *plots=matrix;
	var gs_inbound4_norm CESD5;
RUN;
ODS Graphics OFF;

Proc Univariate data =  Stndtest;
	VAR gs_inbound4_norm log_outbound4 log_Symmetric_4;
	HISTOGRAM gs_inbound4_norm log_outbound4 log_Symmetric_4;
RUN;
