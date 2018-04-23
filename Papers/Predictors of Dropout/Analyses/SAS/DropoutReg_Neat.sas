libname all "T:\Research folders\CCWTG\Data\MERGEALL";

proc datasets lib=work memtype=data nolist kill; run;

data work.this_data; set all.Allwide;
run;

data no_start; Set this_data; RUN;

/*Check Notes*/
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

/*Remove No_starts, Analysis only looking at dropout since program start*/
IF no_start = 1 THEN DELETE; 
RUN;



/*Keeping necessary data*/

DATA this_data; 
	SET this_data;
		KEEP Final_ID semester -- kage1;
RUN;


DATA this_data;
	SET this_data; 
		IF DATE_Dropped ne . & no_start ne 1 THEN start_drop = 1;
		
	RUN;

DATA this_data; set this_data;
	IF start_drop = . THEN Start_Drop = 0;
RUN;


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


/*Frequency by semester*/
proc freq data = this_data; 
	TABLES semester;
RUN;

/*Dummy coding night and semster F15 mon-Fri to S17 mon-Fri (16 sessions, 15 deummy codes)*/

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

Run;



/*frequency of dropped particpants*/
PROC Freq data = this_data; 
	TABLES start_drop;
RUN;


/*Risk Composite score (Mean of items; higher score = more risk*/

DATA this_data; set this_data; 
	Risk = mean(of p0risk_1 - p0risk_32);
	IF RISK =. THEN DELETE;
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

/*Run logistic regression*/

proc logistic descending data = this_data;
	model start_drop = RISK mentee_male kage1 p0income e1 e2 d1 - d15 / scale=n aggregate lackfit;
	output out=pdat p=pihat;
	contrast '2 pt increase RISK' RISK 2/estimate=exp;
RUN;

/*Hosmer lemeshow Model fit = good (0.29)*/
/*There is Quasi complete separation because there are no instanceds of d3 and d8 that there was a dropout... do we need to worry about this with dummy variables?*
Answered by KIM, preceed with PROC GLIMMIX PROCEDURE./


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

/*Appears to be a clear positve trend*/



/*Going to let PROC GLIMMIX procedure to class the categorical predictors for me. 1-16 = the dummy codes from before*/

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

	RUN;


proc sort data = this_data;
	BY start_drop;
	RUN;

/*settign up for Mplus*/

	DATA MPlus_log;
		SET This_Data (KEEP = Final_ID start_drop p0risk_1 - p0risk_32 mentee_male kage1 p0income ethnicity room sem_night);
	RUN;

/*Set up scales*/
DATA MPLUS_log;
	SET Mplus_log;
/*Environemntal Risk*/
Env_risk = sum(of p0risk_1 - p0risk_20);
	/*Economic Adversity*/
	Econ_adv = sum(of p0risk_1 -p0risk_7);
	/*Family stress*/
	Fam_stress = sum(of p0risk_8 - p0risk_18);
	/*Peer difficulties*/
	Peer_Diff = sum(of p0risk_19 - p0risk_20);
/*Individual Risk*/
Ind_Risk = sum(of P0risk_21 - p0risk_32);
	/*Academic Challenges*/
	Acad_chal = sum(of p0risk_21 - p0risk_24);
	/*Problem Behavior*/
	Prob_beh = sum(of p0risk_25 - p0risk_30);
	/*Mental Health Concerns*/
	Men_Health = sum(of p0risk_31 - p0risk_32);
RUN;



proc corr data=MPLUS_log nomiss;
	VAR p0income mentee_male -- Men_health;
run;





DATA MPLUS_log; 
	SET Mplus_log (rename =( 

Final_ID = ID
p0income = income

p0risk_1 = risk_1
p0risk_2 = risk_2
p0risk_3 = risk_3
p0risk_4 = risk_4
p0risk_5 = risk_5
p0risk_6 = risk_6
p0risk_7 = risk_7
p0risk_8 = risk_8
p0risk_9 = risk_9
p0risk_10 = risk_10
p0risk_11 = risk_11
p0risk_12 = risk_12
p0risk_13 = risk_13
p0risk_14 = risk_14
p0risk_15 = risk_15
p0risk_16 = risk_16
p0risk_17 = risk_17
p0risk_18 = risk_18
p0risk_19 = risk_19
p0risk_20 = risk_20
p0risk_21 = risk_21
p0risk_22 = risk_22
p0risk_23 = risk_23
p0risk_24 = risk_24
p0risk_25 = risk_25
p0risk_26 = risk_26
p0risk_27 = risk_27
p0risk_28 = risk_28
p0risk_29 = risk_29
p0risk_30 = risk_30
p0risk_31 = risk_31
p0risk_32 = risk_32

mentee_male = male
kage1 = age
ethnicity = eth
sem_night = sem_n

Env_risk = Env_ri
Econ_adv = Econ_ad
Fam_stress = fam_st
Peer_Diff = Pr_diff

Ind_Risk = In_Ri
Acad_Chal = Ac_cha
Prob_beh = prob_b
Men_Health = M_Hea
));
RUN;

/**/
/*data Mplus_log; */
/*  set Mplus_log;*/
/**/
/*  array allvars _numeric_ ;*/
/**/
/*  do over allvars;*/
/*    if missing(allvars) then allvars = -1234 ;*/
/*  end;*/
/*run;*/

/*proc print;RUN;*/
/**/
/*options nolabel ;*/
/*proc means data=Mplus_log;*/
/*run;*/

proc export data=Mplus_log (keep = ID     
income 
risk_1 
risk_2 
risk_3 
risk_4 
risk_5 
risk_6 
risk_7 
 risk_8
 risk_9
 risk_10 
 risk_11 
 risk_12 
 risk_13 
 risk_14 
 risk_15 
 risk_16 
 risk_17 
 risk_18 
 risk_19 
 risk_20 
 risk_21 
 risk_22 
 risk_23 
 risk_24 
 risk_25 
 risk_26 
 risk_27 
 risk_28 
 risk_29 
 risk_30 
 risk_31 
 risk_32 
 male 
 room 
 age 
 eth 
 sem_n   
 start_drop  
 Env_ri 
 Econ_ad 
 fam_st 
 Pr_diff 
 In_Ri      
 Ac_cha      
 prob_b      
 M_Hea     ) outfile='T:\Research folders\CCWTG\Analyses\Papers\Dropout\MPlus\R_log.csv' dbms=csv replace;
run;


PROC FREQ data = mplus_log;
	TABLES risk_1 - risk_32;
RUN;

DATA mplus_log;
SET MPlus_log;
	IF (Env_ri >0) & (In_Ri >0) & ((Env_ri + In_Ri) > 3) THEN H_risk = 1;
		else H_risk = 0;
	RUN;

proc freq data = mplus_log;
	TABLES H_risk;
RUN;


/* proc glimmix data=Mplus_log;*/
/*      class sem_n eth;*/
/*      model start_drop (order = freq ref=first)= In_ri male age eth sem_n / solution dist=binary oddsratio CL;*/
/*      random intercept;*/
/*   run;*/





proc print data=sample2(obs=10);
run;





 proc glimmix data=this_data ;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;

/*Create internal and external risk scores. Reference to ext and internal are in the very bottom of program code.*/



DATA This_data;
	Set This_data;
	RISK_ext = mean(of 
					p0risk_1 - p0risk_20)
	;
	RUN;



DATA this_data;
	Set This_data;
	RISK_int = mean(of 
					p0risk_21 - p0risk_32)
	;
	RUN;


proc freq data = this_data;
	TABLES p0risk_1 - p0risk_32;
RUN;


/*Histoigrams of RISK External_Risk & Internal_RISK*/
proc univariate data=This_data;
   var RISK RIsk_ext Risk_int;
   histogram;
run;




/*LOGISTIC REGRESSION FINAL MODELS*/

/*Final RISK model*/

proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;

/*Final EXTERNAL RISK model*/
proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK_ext mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;

/*Final INTERNAL RISK model*/
proc glimmix data=this_data;
      class sem_night ethnicity p0income;
      model start_drop (order = freq ref=first)= RISK_int mentee_male kage1 p0income ethnicity room sem_night / solution dist=binary oddsratio CL;
/*      random intercept;*/
   run;


/*NOTE: fp procedure was run on ALL continous variables... Linear scale was assumed best fit for models on all continuous varibales -NY*/




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


proc sort data = Atten;
	BY Final_ID;
	RUN;

/*DO loop to sum attendance*/

DATA Atten_sum ;
  SET Atten ;
  BY Final_ID ;
 
  * first.final resets the count when the final ID changes ;
 
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
	IF sum_pres = 0 THEN DELETE;
	IF sum_pres = . THEN DELETE;
RUN;


DATA Mplus_pois;
	SET All_Present;
	Absent = 12 - sum_pres;
	IF sem_night = . THEN DELETE;
RUN;

DATA MPlus_pois;
		SET	Mplus_pois (KEEP = Final_ID Absent p0risk_1 - p0risk_32 mentee_male kage1 p0income ethnicity room sem_night);
RUN;

/*settign up for Mplus*/

/*Set up scales*/
DATA MPLUS_pois;
	SET Mplus_pois;
/*Environemntal Risk*/
Env_risk = sum(of p0risk_1 - p0risk_20);
	/*Economic Adversity*/
	Econ_adv = sum(of p0risk_1 -p0risk_7);
	/*Family stress*/
	Fam_stress = sum(of p0risk_8 - p0risk_18);
	/*Peer difficulties*/
	Peer_Diff = sum(of p0risk_19 - p0risk_20);
/*Individual Risk*/
Ind_Risk = sum(of P0risk_21 - p0risk_32);
	/*Academic Challenges*/
	Acad_chal = sum(of p0risk_21 - p0risk_24);
	/*Problem Behavior*/
	Prob_beh = sum(of p0risk_25 - p0risk_30);
	/*Mental Health Concerns*/
	Men_Health = sum(of p0risk_31 - p0risk_32);
RUN;


proc corr data=MPLUS_pois nomiss;
	VAR p0income mentee_male -- Men_health;
run;

/**/
/*data Mplus_pois; */
/*  set Mplus_pois;*/
/**/
/*  array allvars _numeric_ ;*/
/**/
/*  do over allvars;*/
/*    if missing(allvars) then allvars = -1234 ;*/
/*  end;*/
/*run;*/
/**/
/*proc print;RUN;*/
/**/
/**/
/*DATA Mplus_Pois;*/
/*	SET MPLUS_Pois;*/
/*	IF sem_night = -1234 THEN DELETE;*/
/*RUN;*/

DATA MPLUS_pois; 
	SET Mplus_pois (rename =( 

Final_ID = ID
p0income = income

p0risk_1 = risk_1
p0risk_2 = risk_2
p0risk_3 = risk_3
p0risk_4 = risk_4
p0risk_5 = risk_5
p0risk_6 = risk_6
p0risk_7 = risk_7
p0risk_8 = risk_8
p0risk_9 = risk_9
p0risk_10 = risk_10
p0risk_11 = risk_11
p0risk_12 = risk_12
p0risk_13 = risk_13
p0risk_14 = risk_14
p0risk_15 = risk_15
p0risk_16 = risk_16
p0risk_17 = risk_17
p0risk_18 = risk_18
p0risk_19 = risk_19
p0risk_20 = risk_20
p0risk_21 = risk_21
p0risk_22 = risk_22
p0risk_23 = risk_23
p0risk_24 = risk_24
p0risk_25 = risk_25
p0risk_26 = risk_26
p0risk_27 = risk_27
p0risk_28 = risk_28
p0risk_29 = risk_29
p0risk_30 = risk_30
p0risk_31 = risk_31
p0risk_32 = risk_32

mentee_male = male
kage1 = age
ethnicity = eth
sem_night = sem_n

Env_risk = Env_ri
Econ_adv = Econ_ad
Fam_stress = fam_st
Peer_Diff = Pr_diff

Ind_Risk = In_Ri
Acad_Chal = Ac_cha
Prob_beh = prob_b
Men_Health = M_Hea
));
RUN;


proc contents order = varnum;run;

options nolabel ;
proc means data=Mplus_pois;
run;


proc export data=Mplus_pois (keep = ID     
income 
risk_1 
risk_2 
risk_3 
risk_4 
risk_5 
risk_6 
risk_7 
 risk_8
 risk_9
 risk_10 
 risk_11 
 risk_12 
 risk_13 
 risk_14 
 risk_15 
 risk_16 
 risk_17 
 risk_18 
 risk_19 
 risk_20 
 risk_21 
 risk_22 
 risk_23 
 risk_24 
 risk_25 
 risk_26 
 risk_27 
 risk_28 
 risk_29 
 risk_30 
 risk_31 
 risk_32 
 male 
 room 
 age 
 eth 
 sem_n   
 Absent  
 Env_ri 
 Econ_ad 
 fam_st 
 Pr_diff 
 In_Ri      
 Ac_cha      
 prob_b      
 M_Hea     ) 
outfile='T:\Research folders\CCWTG\Analyses\Papers\Dropout\MPlus\R_pois.csv' dbms=csv replace;

run;






  proc genmod data=This_data;
      class sem_night ethnicity p0income;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
/*                         																link   = log*/
                         																/*offset = ln*/;
   run;


/*Assessing Negative Binomial distribution as recommended by kim*/
/*   proc genmod data=This_data;*/
/*      class sem_night ethnicity p0income;*/
/*      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = negbin*/
/*                         																link   = log*/
/*                         																offset = ln;*/
/*   run;*/
/*Conclusion: No change. Keep with poisson regression analysis*/


/*Final Poisson regression models*/

/*Final model for RISK*/

 proc genmod data = this_data;
      class sem_night ethnicity p0income;
      model sum_pres = RISK mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																/*link   = log*/
                   																/*offset = ln*/;
   run;

/*Final model for EXTERNAL_RISK*/

 proc genmod data= this_data;
      class sem_night ethnicity p0income;
      model sum_pres = RISK_ext mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																/*link   = log*/
                   																/*offset = ln*/;
   run;


/*Final model for INTERNAL_RISK*/
proc genmod data= this_data;
      class sem_night ethnicity p0income;
      model sum_pres = RISK_int mentee_male kage1 p0income ethnicity room sem_night / 		dist   = poisson
                         																/*link   = log*/
                   																/*offset = ln*/;
   run;




/*GRAPHS + Tables FOR KIM*/

/*
   Hi Neil,
Do you have time before we meet to create some plots? 
  1.)  A line graph that shows the number of risk factors on x and the proportion of kids who dropped out on y would be helpful. 
  2.)  Also, a scatter plot of number of risk factors on x and days attended on y. 
  3.)  Last, cross tabs of each individual risk factor and the proportion of kids who dropped out would be informative. 

  These are just for me to get a sense of the data, so no need to make them fancy.

Also, 
   for the logistic regression model, are the estimates log odds? You interpret the effects in terms of probability, so I wasn’t sure how you had specified the model. Could you double check the way that you are interpreting those coefficients?
*/


/*Plot 1*/


 DATA this_data;
	Set this_data;
	RISK_sum = sum(of 
					p0risk_1 - p0risk_32)
	;
	RUN;


 DATA this_data;
 Set this_data;
	RISKsum_ext = sum(of 
					p0risk_1 - p0risk_20)
	;
RUN;

 DATA this_data;
 Set this_data;
	RISKsum_int = sum(of 
					p0risk_21 - p0risk_32)
	;
RUN;




proc logistic descending data = this_data;
	model start_drop = RISKsum_ext / scale=n aggregate lackfit;
	output out=pdat3 p=pihat;
	/*contrast '2 pt increase RISK' RISK 2/estimate=exp;*/
RUN;

proc logistic descending data = this_data;
	model start_drop = RISK_Sum / scale=n aggregate lackfit;
	output out=pdat2 p=pihat;
	/*contrast '2 pt increase RISK' RISK 2/estimate=exp;*/
RUN;

proc logistic descending data = this_data;
	model start_drop = RISKsum_int / scale=n aggregate lackfit;
	output out=pdat4 p=pihat;
	/*contrast '2 pt increase RISK' RISK 2/estimate=exp;*/
RUN;



axis1 minor=none label=(f=swiss h=2.5 'RISK_SUM'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Dropout probability'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=pdat2; 
plot (/*start_drop*/ pihat)*RISK_sum/ haxis=axis1 vaxis=axis2;
run; quit;



/*External*/
axis1 minor=none label=(f=swiss h=2.5 'RISK external sum'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Dropout probability'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=pdat3; 
plot (/*start_drop*/ pihat)*RISKsum_ext/ haxis=axis1 vaxis=axis2;
run; quit;



/*Internal*/
axis1 minor=none label=(f=swiss h=2.5 'RISK Internal sum'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Dropout probability'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=pdat4; 
plot (/*start_drop*/ pihat)*RISKsum_int/ haxis=axis1 vaxis=axis2;
run; quit;



/*Plot 2*/

axis1 minor=none label=(f=swiss h=2.5 'RISK sum'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Days Attended'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=this_data; 
plot sum_pres*RISK_sum/ haxis=axis1 vaxis=axis2;
run; quit;


axis1 minor=none label=(f=swiss h=2.5 'RISK external sum'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Days Attended'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=this_data; 
plot sum_pres*RISKsum_ext/ haxis=axis1 vaxis=axis2;
run; quit;


axis1 minor=none label=(f=swiss h=2.5 'RISK internal sum'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Days Attended'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=this_data; 
plot sum_pres*RISKsum_int/ haxis=axis1 vaxis=axis2;
run; quit;



/*Plot 3*/

options NOLABEL;
/*Proc freq data = pdat2  ;*/
/*	TABLES 	(p0risk_1 - p0risk_32)*start_drop / norow nocol;*/
/*	run;*/

DATA This_data;
	SET THIS_Data;
	IF start_drop = . THEN DELETE;
RUN;


proc sort data = this_data;
	BY start_drop;
RUN;

PROC MEANS data = THIS_DATA maxdec = 2;
	VAR p0risk_1 - P0risk_32;
		Class Start_drop;
RUN;
options LABEL;


/*RISK SUBSCALES*/
   
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
