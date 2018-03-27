libname F17 "T:\Research folders\CCWTG\Data\Fall2017\FINALDATA\STACY_FILES";
libname finalF17 "T:\Research folders\CCWTG\Data\Fall2017\FINALDATA";
libname other 'T:\Research folders\CCWTG\Data\Fall2017\FINALDATA\OTHER_FILES';

proc datasets lib=work memtype=data nolist kill; run;

/***************************************************************************************************/
/*MASTER RECORDS																				    /
/***************************************************************************************************/
proc import datafile="T:\Research folders\CCWTG\Data\Fall2017\FINALDATA\INITIAL_FIDELITY_FILES\F17_TXASSIGN.csv" 
out=txassign dbms=csv replace; guessingrows=32767; getnames=yes;
run;


data txassign2; set txassiGn; in_gereon=1; run;



*******JUST FOR FALL2016 -NEIL KEEPING FOR S17 as well...*****************************************************************************;
proc import datafile="T:\Research folders\CCWTG\Data\Fall2017\GEREON_CHECKS\INTAKEF17.csv" 
out=extras dbms=csv replace; guessingrows=32767; getnames=yes;
run;

data extras; set extras; in_intake=1; drop mentee_id; run;

proc sort data=extras; by mentee_name; run;
proc sort data=txassign; by mentee_name; run;
data txassign; merge extras txassign; by mentee_name; run;
data txassign; set txassign; if in_gereon ne 1 and in_intake=1 then no_start=1; run;


*****************************************************************************************************;


proc import datafile="T:\Research folders\CCWTG\Data\Fall2017\FINALDATA\tempdelete.csv" 
out=id dbms=csv replace; guessingrows=32767; getnames=yes;
run;


data id; set id;
if mentee_name ne '' and mentor_name eq = '' then type='no_mentor';
if mentee_name eq '' and mentor_name ne '' then type='no_mentee';
if mentee_name ne '' and mentor_name ne '' then type='pair';

in_stacy=1;
run;



data id_pair; set id; where mentee_name ne ''; run;
data id_staff; set id; where mentee_name eq '' /*and mentor_name ne ''*/; run;

proc sort data=txassign; by mentee_name; run; proc sort data=id_pair; by mentee_name; run;
data txassign; merge txassign id_pair (keep=mentee_name type Final_ID); by mentee_name; run;
proc freq; tables mentee_name Final_ID/missing; run; /*<- NEIL NOTE: "/Missing" puts % missing in the proc freq procedure*/


proc print data =Txassign; where Final_ID = ""; RUN;





data txassign; set txassign id_staff (keep=Final_ID type mentor_name);
if Final_ID="" then delete;

length ImpNotes $150;




drop notes;
run;

/*N= 173*/

proc freq; tables Final_ID/missing; run;

/*NO MISSING 07/14/17*/

/***************************************************************************************************/
/*Fidelity Files																				   */
/***************************************************************************************************/
proc import datafile="T:\Research folders\CCWTG\Data\Fall2017\FINALDATA\INITIAL_FIDELITY_FILES\F17_WEEKLY.csv" 
out=weekly dbms=csv replace; guessingrows=32767; getnames=yes;
run;

/*N = 1572 (Note it is the number of Px *12*/

proc sort data=weekly out=weekly_agg nodupkey; by mentee_name; run;

data staff; set id_staff; staff_nomentee=1; 
keep Final_ID staff_nomentee; run;

/*N = 132  - May need to delete Webb Julianna up here again*/


/***************************************************************************************************/
/*MENTOR SURVEY DATA                    														   */
/***************************************************************************************************/
data mentors; set F17.F17_Final_Mentor; run;

/*N = 152 Matches */
data mentors; set mentors; 
format _all_;
informat _all_;
run;

proc sort data=mentors; by Final_ID; run;
proc sort data=staff; by Final_ID; run;

data mentors1; merge mentors staff; by Final_ID; run;

data mentors1; set mentors1;

format m0start m0end 
m1start m1end 
m2start m2end 
m3start m3end 
m4start m4end 
m5start m5end datetime.;

keep 
Final_ID staff_nomentee
m0start m0end 
m1start m1end 
m2start m2end 
m3start m3end 
m4start m4end 
m5start m5end
m0gender 
m0yrborn
m0year
m0major_1-m0major_15 
m0ft
m0mom m0momed m0momjob 
m0dad m0daded m0dadjob 
m0famses
m0delexp_1-m0delexp_8
m0hxA_1-m0hxA_12 m0hxB_1-m0hxB_12 m0hxC_1-m0hxC_12 m0hxD_1-m0hxD_12 m0hxE_1-m0hxE_12
m0flour_1-m0flour_8 m5flour_1-m5flour_8
m0slfe_1-m0slfe_6 m2slfe_1-m2slfe_6 m3slfe_1-m3slfe_6 m4slfe_1-m4slfe_6 m5slfe_1-m5slfe_6
m0jsat_1-m0jsat_4 m2jsat_1-m2jsat_4 m3jsat_1-m3jsat_4 m4jsat_1-m4jsat_4 m5jsat_1-m5jsat_4
m0socs_1-m0socs_3 m2socs_1-m2socs_3 m3socs_1-m3socs_3 m4socs_1-m4socs_3 m5socs_1-m5socs_3
m0mil_1-m0mil_3 m2mil_1-m2mil_3 m3mil_1-m3mil_3 m4mil_1-m4mil_3 m5mil_1-m5mil_3
m0panas_1-m0panas_10 m2panas_1-m2panas_10 m3panas_1-m3panas_10 m4panas_1-m4panas_10 m5panas_1-m5panas_10
m2posp_1-m2posp_24 m5posp_1-m5posp_24
m3sdemp_1-m3sdemp_9 m5sdemp_1-m5sdemp_9
m3rqpos_1-m3rqpos_8 m5rqpos_1-m5rqpos_8
m3rqneg_1-m3rqneg_8 m5rqneg_1-m5rqneg_8
m3mas_1-m3mas_14 m5mas_1-m5mas_14
m3cs1_1-m3cs1_9 m5cs1_1-m5cs1_9
m3cs2_1-m3cs2_9 m5cs2_1-m5cs2_9
m4nyaps_1-m4nyaps_13 m4nyaps_17-m4nyaps_39;
run;

data mentors1;
retain
Final_ID staff_nomentee
m0start m0end 
m1start m1end 
m2start m2end 
m3start m3end 
m4start m4end 
m5start m5end
m0gender 
m0yrborn
m0year
m0major_1-m0major_15 
m0ft
m0mom m0momed m0momjob 
m0dad m0daded m0dadjob 
m0famses
m0delexp_1-m0delexp_8
m0hxA_1-m0hxA_12 m0hxB_1-m0hxB_12 m0hxC_1-m0hxC_12 m0hxD_1-m0hxD_12 m0hxE_1-m0hxE_12
m0flour_1-m0flour_8 m5flour_1-m5flour_8
m0slfe_1-m0slfe_6 m2slfe_1-m2slfe_6 m3slfe_1-m3slfe_6 m4slfe_1-m4slfe_6 m5slfe_1-m5slfe_6
m0jsat_1-m0jsat_4 m2jsat_1-m2jsat_4 m3jsat_1-m3jsat_4 m4jsat_1-m4jsat_4 m5jsat_1-m5jsat_4
m0socs_1-m0socs_3 m2socs_1-m2socs_3 m3socs_1-m3socs_3 m4socs_1-m4socs_3 m5socs_1-m5socs_3
m0mil_1-m0mil_3 m2mil_1-m2mil_3 m3mil_1-m3mil_3 m4mil_1-m4mil_3 m5mil_1-m5mil_3
m0panas_1-m0panas_10 m2panas_1-m2panas_10 m3panas_1-m3panas_10 m4panas_1-m4panas_10 m5panas_1-m5panas_10
m2posp_1-m2posp_24 m5posp_1-m5posp_24
m3sdemp_1-m3sdemp_9 m5sdemp_1-m5sdemp_9
m3rqpos_1-m3rqpos_8 m5rqpos_1-m5rqpos_8
m3rqneg_1-m3rqneg_8 m5rqneg_1-m5rqneg_8
m3mas_1-m3mas_14 m5mas_1-m5mas_14
m3cs1_1-m3cs1_9 m5cs1_1-m5cs1_9
m3cs2_1-m3cs2_9 m5cs2_1-m5cs2_9
m4nyaps_1-m4nyaps_13 m4nyaps_17-m4nyaps_39;
set mentors1;
run;

/*??? N = 152 ???
		CONSISTENT IN MENTEE & MENTEE1 */

/***************************************************************************************************/
/*MENTEE SURVEY DATA 																			   */
/***************************************************************************************************/
data mentees; set F17.F17_Final_Mentee; run;

data mentees; set mentees;

format _all_;
informat _all_;

k0yrborn=k0byear;
k1yrborn=k1byear;
k2yrborn=k2byear;
k3yrborn=k3byear;
k4yrborn=k4byear;
k5yrborn=k5byear;

IF FINAL_ID = '' THEN DELETE;

run;




data kflag; set mentees; where kflag=1; keep Final_ID kflag_text; run; 
proc print noobs; run;	/*<- NEIL NOTE: These are notes READ THEM AND DETERMINE WHAT IS IMPORTANT!*/

data mentees1; set mentees;

format k0start k0end 
k1start k1end 
k2start k2end 
k3start k3end 
k4start k4end 
k5start k5end
datetime.;

keep 
Final_ID
k0start k0end 
k1start k1end 
k2start k2end 
k3start k3end 
k4start k4end 
k5start k5end
k0grades k5grades
k0anx_1-k0anx_10 k5anx_1-k5anx_10
k0cesd_1-k0cesd_6 k0cesd_8-k0cesd_10 k5cesd_1-k5cesd_6 k5cesd_8-k5cesd_10
k0ippa_1-k0ippa_13 k0ippa_15 
k0pss_1-k0pss_5 k0ars_1-k0ars_6
k0anger_1-k0anger_3 k5anger_1-k5anger_3
k0mil_1-k0mil_3 k5mil_1-k5mil_3
k0slfeff_1-k0slfeff_10 k5slfeff_1-k5slfeff_10
k0dlq_1-k0dlq_10 k5dlq_1-k5dlq_10
k1bhvscl_1-k1bhvscl_10 k5bhvscl_1-k5bhvscl_10
k0consc_1-k0consc_9 k5consc_1-k5consc_9
k0ethid_1-k0ethid_6 k5ethid_1-k5ethid_6
k0fut_1-k0fut_5 k5fut_1-k5fut_5
k0asp_1-k0asp_3 k5asp_1-k5asp_3
k0gmat_1-k0gmat_6 
k0dapsp1_1-k0dapsp1_25 k0dapsp2_1-k0dapsp2_17 k0dapsp3_1-k0dapsp3_16
k5dapsp1_1-k5dapsp1_25 k5dapsp2_1-k5dapsp2_17 k5dapsp3_1-k5dapsp3_16
k0blng_1-k0blng_5 k2blng_1-k2blng_5 k3blng_1-k3blng_5 k4blng_1-k4blng_5 k5blng_1-k5blng_5
k2ccmat_1-k2ccmat_6 k3ccmat_1-k3ccmat_6 k4ccmat_1-k4ccmat_6 k5ccmat_1-k5ccmat_6
k0panas_1-k0panas_10 k2panas_1-k2panas_10 k3panas_1-k3panas_10 k4panas_1-k4panas_10 k5panas_1-k5panas_10
k3mas_1-k3mas_16 k5mas_1-k5mas_16
k3cs_1-k3cs_9 k5cs_1-k5cs_9
k4nyaps_1-k4nyaps_29 k4nyaps_31-k4nyaps_34 k4nyaps_37-k4nyaps_40;
run;

data mentees1;
retain
Final_ID
k0start k0end 
k1start k1end 
k2start k2end 
k3start k3end 
k4start k4end 
k5start k5end
k0grades k5grades
k0anx_1-k0anx_10 k5anx_1-k5anx_10
k0cesd_1-k0cesd_6 k0cesd_8-k0cesd_10 k5cesd_1-k5cesd_6 k5cesd_8-k5cesd_10
k0ippa_1-k0ippa_13 k0ippa_15 
k0pss_1-k0pss_5 k0ars_1-k0ars_6
k0anger_1-k0anger_3 k5anger_1-k5anger_3
k0mil_1-k0mil_3 k5mil_1-k5mil_3
k0slfeff_1-k0slfeff_10 k5slfeff_1-k5slfeff_10
k0dlq_1-k0dlq_10 k5dlq_1-k5dlq_10
k1bhvscl_1-k1bhvscl_10 k5bhvscl_1-k5bhvscl_10
k0consc_1-k0consc_9 k5consc_1-k5consc_9
k0ethid_1-k0ethid_6 k5ethid_1-k5ethid_6
k0fut_1-k0fut_5 k5fut_1-k5fut_5
k0asp_1-k0asp_3 k5asp_1-k5asp_3
k0gmat_1-k0gmat_6 
k0dapsp1_1-k0dapsp1_25 k0dapsp2_1-k0dapsp2_17 k0dapsp3_1-k0dapsp3_16
k5dapsp1_1-k5dapsp1_25 k5dapsp2_1-k5dapsp2_17 k5dapsp3_1-k5dapsp3_16
k0blng_1-k0blng_5 k2blng_1-k2blng_5 k3blng_1-k3blng_5 k4blng_1-k4blng_5 k5blng_1-k5blng_5
k2ccmat_1-k2ccmat_6 k3ccmat_1-k3ccmat_6 k4ccmat_1-k4ccmat_6 k5ccmat_1-k5ccmat_6
k0panas_1-k0panas_10 k2panas_1-k2panas_10 k3panas_1-k3panas_10 k4panas_1-k4panas_10 k5panas_1-k5panas_10
k3mas_1-k3mas_16 k5mas_1-k5mas_16
k3cs_1-k3cs_9 k5cs_1-k5cs_9
k4nyaps_1-k4nyaps_29 k4nyaps_31-k4nyaps_34 k4nyaps_37-k4nyaps_40;
set mentees1;
run;

/*N = 130  
		CONSISTENT ACROSS MENTEE & MENTEE1*/



/***************************************************************************************************/
/*PARENT SURVEY DATA                                                                               */
/***************************************************************************************************/
data parents; set F17.F17_Final_Parent; run;

data parents; set parents;

format _all_;
informat _all_;

p0kyrborn=p0kbyear;
p1kyrborn=p1kbyear;

drop p0occ_TEXT;
run;

/*N = 130*/

data parents1; set parents;

format p0start p0end 
p1start p1end datetime.;

run;
/*NEIL CREATED: LOOKING AT pflag_text Notes on parents)*/
proc print data = parents;
	where p0yrborn ne p1yrborn & pflag_text ne '';
	VAR Final_ID p0yrborn p1yrborn p0kbyear p1kbyear p0kbyear p0kidgen p1kidgen  pflag_text;
RUN;
/*Neil Created ending*/

data parents1; set parents1; 

keep 
Final_ID 
p0start p0end 
p1start p1end 
p0gender 
p0yrborn p0numhome p0marstat p0income p0educ p0employ_1-p0employ_8 p0occ
p0rural p0zip 
p0rel p0rel_TEXT
p0risk_1-p0risk_32
p0pss_1-p0pss_5 p0ars_1-p0ars_6 p1pss_1-p1pss_5 p1ars_1-p1ars_6 /*p2pss_1-p2pss_5 p2ars_1-p2ars_6*/
p0dessa_1-p0dessa_76 p1dessa_1-p1dessa_76
p0sdq_1-p0sdq_25 p1sdq_1-p1sdq_25
p0cbcl_1-p0cbcl_13 p1cbcl_1-p1cbcl_13;
run;

data parents1;
retain
Final_ID  
p0start p0end 
p1start p1end 
p0gender 
p0yrborn p0numhome p0marstat p0income p0educ p0employ_1-p0employ_8 p0occ
p0rural p0zip 
p0rel p0rel_TEXT
p0risk_1-p0risk_32
p0pss_1-p0pss_5 p0ars_1-p0ars_6 p1pss_1-p1pss_5 p1ars_1-p1ars_6
/*p2pss_1-p2pss_5 p2ars_1-p2ars_6*/
p0dessa_1-p0dessa_76 p1dessa_1-p1dessa_76
p0sdq_1-p0sdq_25 p1sdq_1-p1sdq_25
p0cbcl_1-p0cbcl_13 p1cbcl_1-p1cbcl_13;
set parents1;
run;


/*N = 130
		Consistent Across Parents & Parents 1*/

/***************************************************************************************************/
/*cross check and create consistent gender and dob for mentee file                                 */
/***************************************************************************************************/

proc sort data=parents; by Final_ID; run;
proc sort data=txassign; by Final_ID; run;
proc sort data=mentees; by Final_ID; run;

data check1; merge 
   parents (keep=Final_ID p0kyrborn p1kyrborn p0kbmonth p1kbmonth p0kidgen p1kidgen) 
   mentees (keep=Final_ID k0gender k1gender k2gender k3gender k4gender k5gender 
       k0bmonth k1bmonth k2bmonth k3bmonth k4bmonth k5bmonth
       k0yrborn k1yrborn k2yrborn k3yrborn k4yrborn k5yrborn) 
   txassign; 
by Final_ID;  
run;


data check1; set check1;

intake_year=year(mentee_birthdate);
intake_month=month(mentee_birthdate);

if mentee_name='' then delete;
monthmin=min (of intake_month k0bmonth k1bmonth k2bmonth k3bmonth k4bmonth k5bmonth p0kbmonth p1kbmonth);
yearmin=min (of intake_year k0yrborn k1yrborn k2yrborn k3yrborn k4yrborn k5yrborn p0kyrborn p1kyrborn); 
monthmax=max (of intake_month k0bmonth k1bmonth k2bmonth k3bmonth k4bmonth k5bmonth p0kbmonth p1kbmonth);
yearmax=max (of intake_year k0yrborn k1yrborn k2yrborn k3yrborn k4yrborn k5yrborn p0kyrborn p1kyrborn);

if monthmin ne monthmax or yearmin ne yearmax then miss=1;

if p0kidgen gt 2 then p0kidgen=.; if p1kidgen gt 2 then p1kidgen=.;

if mentee_gender='M' then intake_gender=1;
else if mentee_gender='F' then intake_gender=2;

gendermin=min (of intake_gender k0gender k1gender k2gender k3gender k4gender k5gender p0kidgen p1kidgen);
gendermax=max (of intake_gender k0gender k1gender k2gender k3gender k4gender k5gender p0kidgen p1kidgen);
if gendermin ne gendermax then miss1=1;
run;

proc print; where miss=1; var Final_ID
intake_month k0bmonth k1bmonth k2bmonth k3bmonth k4bmonth k5bmonth p0kbmonth p1kbmonth
intake_year k0yrborn k1yrborn k2yrborn k3yrborn k4yrborn k5yrborn p0kyrborn p1kyrborn;
run;



proc print; where miss1=1; var Final_ID 
intake_gender k0gender k1gender k2gender k3gender k4gender k5gender p0kidgen p1kidgen ; run;

proc sort data=check1; by p0kidgen; run;
proc print; var Final_ID p0kidgen p1kidgen k0gender k1gender k2gender k3gender k4gender k5gender; run;

proc print data = mentees;
	where gflag = 1;
	VAR Final_ID gflag gflag_text;
RUN;


/*Check specific id's using the commented out section below (Just change the final ID*/
/*proc print data = check1;*/
/*	where FInal_ID = "CCS17_4823";*/
/*RUN;*/

data mentee_demo; set check1;

/*define gender
		s17 = First year for "Other" gender option in mentee
	Male = 1 Female =0 Other = -1*/
if intake_gender=1 then mentee_male=1;
else if intake_gender=2 then mentee_male=0;
else if intake_gender=3 then mentee_male = -1;

/*define age*/
mentee_bmonth=intake_month;
mentee_byear=intake_year;

/**fix cases**/

/*NO changes in bmonth or year. Inatke month always seemed to be the best*/





keep Final_ID mentee_male mentee_bmonth mentee_byear; 
run;

proc freq; tables Final_ID; run;

/*N = 130 */
/***************************************************************************************************/
/*Create MASTER FILE                                                                               */
/***************************************************************************************************/

proc sort data=mentee_demo; by Final_ID; proc sort data=txassign; by Final_ID; run;
data master; merge 
mentee_demo
txassign (keep=Final_ID type mentee_name room night menfam sibs no_start date_dropped ImpNotes);
by Final_ID;
run;

data master1; set master;
if mentee_name='' then delete;

/*SET CONDITION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
/*NEIL CHECK: SET CORRECT CONDITION on 03/26/2018*/
if night='Monday' or night='Thursday' then mfcond=1; 
else if night='Tuesday' or night='Wednesday' then mfcond=0; 

if night='Monday' and menfam='A' then menfamID='F17MF_MONA';
if night='Monday' and menfam='B' then menfamID='F17MF_MONB';
if night='Monday' and menfam='C' then menfamID='F17MF_MONC';
if night='Monday' and menfam='D' then menfamID='F17MF_MOND';
if night='Monday' and menfam='E' then menfamID='F17MF_MONE';
if night='Monday' and menfam='F' then menfamID='F17MF_MONF';
if night='Monday' and menfam='G' then menfamID='F17MF_MONG';
if night='Monday' and menfam='H' then menfamID='F17MF_MONH';
if night='Monday' and menfam='I' then menfamID='F17MF_MONI';

if night='Tuesday' and menfam='A' then menfamID='F17MF_TUEA';
if night='Tuesday' and menfam='B' then menfamID='F17MF_TUEB';
if night='Tuesday' and menfam='C' then menfamID='F17MF_TUEC';
if night='Tuesday' and menfam='D' then menfamID='F17MF_TUED';
if night='Tuesday' and menfam='E' then menfamID='F17MF_TUEE';
if night='Tuesday' and menfam='F' then menfamID='F17MF_TUEF';
if night='Tuesday' and menfam='G' then menfamID='F17MF_TUEG';
if night='Tuesday' and menfam='H' then menfamID='F17MF_TUEH';
if night='Tuesday' and menfam='I' then menfamID='F17MF_TUEI';

if night='Wednesday' and menfam='A' then menfamID='F17MF_WEDA';
if night='Wednesday' and menfam='B' then menfamID='F17MF_WEDB';
if night='Wednesday' and menfam='C' then menfamID='F17MF_WEDC';
if night='Wednesday' and menfam='D' then menfamID='F17MF_WEDD';
if night='Wednesday' and menfam='E' then menfamID='F17MF_WEDE';
if night='Wednesday' and menfam='F' then menfamID='F17MF_WEDF';
if night='Wednesday' and menfam='G' then menfamID='F17MF_WEDG';
if night='Wednesday' and menfam='H' then menfamID='F17MF_WEDH';
if night='Wednesday' and menfam='I' then menfamID='F17MF_WEDI';

if night='Thursday' and menfam='A' then menfamID='F17MF_THUA';
if night='Thursday' and menfam='B' then menfamID='F17MF_THUB';
if night='Thursday' and menfam='C' then menfamID='F17MF_THUC';
if night='Thursday' and menfam='D' then menfamID='F17MF_THUD';
if night='Thursday' and menfam='E' then menfamID='F17MF_THUE';
if night='Thursday' and menfam='F' then menfamID='F17MF_THUF';
if night='Thursday' and menfam='G' then menfamID='F17MF_THUG';
if night='Thursday' and menfam='H' then menfamID='F17MF_THUH';
if night='Thursday' and menfam='I' then menfamID='F17MF_THUI';


run;

data master1; set master1;
keep Final_ID type sibs mentee_male mentee_bmonth mentee_byear night mfcond menfamID room 
no_start date_dropped impnotes;
run;

data master1;
retain
Final_ID type sibs mentee_male mentee_bmonth mentee_byear night mfcond menfamID room 
no_start date_dropped impnotes;
set master1;
run;

proc freq; tables Final_ID; run;

/*N = 130*/


/***************************************************************************************************/
/*create ethnicity variables for all respondents                                                   */
/***************************************************************************************************/
proc sort data=parents; by Final_ID; 
proc sort data=mentees; by Final_ID; 
proc sort data=mentors; by Final_ID;
proc sort data=mentors1; by Final_ID;
run;

data eth; merge
parents (keep=Final_ID p0race_1--p0asian_17_text p0krace_1--p0kasian_17_text)
mentees (keep=Final_ID k0race_1--k0asian_17_text)
mentors (keep=Final_ID m0race_1--m0asian_17_text)
mentors1 (keep=Final_ID staff_nomentee);
by Final_ID;
run;



data eth; set eth;
/*new variable - eth
1=american indian
2=asian
3=black
4=hispanic
5=hawaiian
6=white
7=mixed*/


/*KID'S SELF-REPORT*/
kethtotal=sum (of k0race_1-k0race_7);
if kethtotal ge 1 then do;
if k0race_6=1 and kethtotal=1 then mentee_eth=6;
else if k0race_5=1 and kethtotal=1 then mentee_eth=5;
else if k0race_4=1 and kethtotal=1 then mentee_eth=4;
else if k0race_4=1 and k0race_6=1 and kethtotal=2 then mentee_eth=4;
else if k0race_3=1 and kethtotal=1 then mentee_eth=3;
else if k0race_2=1 and kethtotal=1 then mentee_eth=2;
else if k0race_1=1 and kethtotal=1 then mentee_eth=1;
else if sum(of k0race_1-k0race_6) gt 1 then mentee_eth=7;
end;

/*if Final_ID='CCF16_3177' then mentee_eth=4; */

/*PARENT REPORT OF KIDS*/
pkethtotal=sum (of p0krace_1-p0krace_7);
if pkethtotal ge 1 then do;
if p0krace_6=1 and pkethtotal=1 then pmentee_eth=6;
else if p0krace_5=1 and pkethtotal=1 then pmentee_eth=5;
else if p0krace_4=1 and pkethtotal=1 then pmentee_eth=4;
else if p0krace_4=1 and p0krace_6=1 and pkethtotal=2 then pmentee_eth=4;
else if p0krace_3=1 and pkethtotal=1 then pmentee_eth=3;
else if p0krace_2=1 and pkethtotal=1 then pmentee_eth=2;
else if p0krace_1=1 and pkethtotal=1 then pmentee_eth=1;
else if sum(of p0krace_1-p0krace_6) gt 1 then pmentee_eth=7;
end;

if mentee_eth=. and pmentee_eth ne . then mentee_eth=pmentee_eth;

/*make pmentee_eth missing if it doesn't conflict with mentee_eth;*/
if mentee_eth ne . and pmentee_eth ne . then do;
if mentee_eth eq pmentee_eth then pmentee_eth=.;
end;

/*PARENT'S SELF REPORT*/
pethtotal=sum (of p0race_1-p0race_7);
if pethtotal ge 1 then do;
if p0race_6=1 and pethtotal=1 then parent_eth=6;
else if p0race_5=1 and pethtotal=1 then parent_eth=5;
else if p0race_4=1 and pethtotal=1 then parent_eth=4;
else if p0race_4=1 and p0race_6=1 and pethtotal=2 then parent_eth=4;
else if p0race_3=1 and pethtotal=1 then parent_eth=3;
else if p0race_2=1 and pethtotal=1 then parent_eth=2;
else if p0race_1=1 and pethtotal=1 then parent_eth=1;
else if sum(of p0race_1-p0race_6) gt 1 then parent_eth=7;
end;

/*MENTOR'S SELF REPORT*/
methtotal=sum (of m0race_1-m0race_7);
if methtotal ge 1 then do;
if m0race_6=1 and methtotal=1 then mentor_eth=6;
else if m0race_5=1 and methtotal=1 then mentor_eth=5;
else if m0race_4=1 and methtotal=1 then mentor_eth=4;
else if m0race_4=1 and m0race_6=1 and methtotal=2 then mentor_eth=4;
else if m0race_3=1 and methtotal=1 then mentor_eth=3;
else if m0race_2=1 and methtotal=1 then mentor_eth=2;
else if m0race_1=1 and methtotal=1 then mentor_eth=1;
else if sum(of m0race_1-m0race_6) gt 1 then mentor_eth=7;

end;
run;


proc freq; where staff_nomentee ne 1; tables mentee_eth pmentee_eth; run; /*Neil Check: 6 = white... majority white, seems right. expect many to be missing in pmentee... Good*/
/*Additionally N = 131 1 missing (130, 1 missing eth's)*/
proc print; where mentee_eth=. and staff_nomentee ne 1; var Final_ID k0race_1-k0race_7 k0race_7_text; run; /*This is the missing mentor id*/
proc print; where staff_nomentee ne 1 and mentee_eth ne pmentee_eth and pmentee_eth ne .; var Final_ID mentee_eth pmentee_eth; run; /*Areas of diasagreement*/

proc print; where mentor_eth=.; var Final_ID m0race_1-m0race_7 m0race_7_text; run; /*All the missing mentor races*/
proc print; where parent_eth=. and staff_nomentee ne 1; var Final_ID p0race_1-p0race_7 p0race_7_text; run;

data eth; set eth;

*This parent particpant wrote "other" and "hispanic" - but text says "White & Hispanic... Changing to race = 4;
if Final_ID='CCS17_4222' then parent_eth=4;

keep Final_ID mentee_eth pmentee_eth parent_eth mentor_eth;
run;

/*MERGE ETHNICITY BACK INTO MAIN DATAFILES*/
proc sort data=parents1; by Final_ID; run;
proc sort data=mentees1; by Final_ID; run;
proc sort data=mentors1; by Final_ID; run;
proc sort data=eth; by Final_ID; run;

data parents1; merge parents1 (in=p) eth (keep=Final_ID parent_eth) master1 (keep=Final_ID sibs); if p; by Final_ID; run;
data mentees1; merge mentees1 (in=k) eth (keep=Final_ID mentee_eth pmentee_eth); if k; by Final_ID; run;
data mentors1; merge mentors1 (in=m) eth (keep=Final_ID mentor_eth); if m; by Final_ID; run;

/***************************************************************************************************/
/*Carry forward first reports for parent survey   												   */
/***************************************************************************************************/
data famlev; set parents1; where sibs ne ""; 
keep Final_ID p0start p1start /*p2start*/ sibs p0gender 
parent_eth p0yrborn p0numhome p0marstat p0income p0educ 
p0employ_1-p0employ_8 p0occ p0rural p0zip 
p0pss_1-p0pss_5 p0ars_1-p0ars_6 p1pss_1-p1pss_5 p1ars_1-p1ars_6 /*p2pss_1-p2pss_5 p2ars_1-p2ars_6*/;
run;

data famlev0; set famlev; 
keep Final_ID sibs p0start p0gender parent_eth p0yrborn p0numhome 
p0marstat p0income p0educ p0employ_1-p0employ_8 p0occ p0rural p0zip 
p0pss_1-p0pss_5 p0ars_1-p0ars_6; 
run;



proc sort data=famlev0; by sibs p0start; run;
data famlev0; set famlev0; by sibs; first=first.sibs; if first ne 1 then delete; run;

data famlev1; set famlev; 
keep Final_ID sibs p1start p1pss_1-p1pss_5 p1ars_1-p1ars_6; 
run;

proc sort data=famlev1; by sibs p1start; run;
data famlev1; set famlev1; by sibs; first=first.sibs; if first ne 1 then delete; run;

/*
data famlev2; set famlev; 
keep Final_ID sibs p2start p2pss_1-p2pss_5 p2ars_1-p2ars_6; 
run;

proc sort data=famlev2; by sibs p2start; run;
data famlev2; set famlev2; by sibs; first=first.sibs; if first ne 1 then delete; run;
*/

data newfamlev; merge famlev0 famlev1 /*famlev2*/; by sibs; run;

data newfamlev; set newfamlev;
keep sibs p0gender parent_eth p0yrborn p0numhome p0marstat p0income p0educ 
p0employ_1-p0employ_8 p0occ p0rural p0zip 
p0pss_1-p0pss_5 p0ars_1-p0ars_6 p1pss_1-p1pss_5 p1ars_1-p1ars_6 /*p2pss_1-p2pss_5 p2ars_1-p2ars_6*/; run;

data dups; set parents1; where sibs ne ''; run;
data dups; set dups; 
drop p0gender parent_eth p0yrborn p0numhome p0marstat p0income p0educ 
p0employ_1-p0employ_8 p0occ p0rural p0zip 
p0pss_1-p0pss_5 p0ars_1-p0ars_6 p1pss_1-p1pss_5 p1ars_1-p1ars_6 /*p2pss_1-p2pss_5 p2ars_1-p2ars_6*/;
run;

proc sort data=newfamlev; by sibs; run; proc sort data=dups; by sibs; run;
data dups; merge dups newfamlev; by sibs; run;

data single; set parents1; where sibs = ''; run;

data parents1; set single dups; run;

/*NEIL: New N = 117, duplicated responses for families with siblings*/

/*create final survey files*/
proc sort data=mentees1; by Final_ID; run;
proc sort data=mentors1; by Final_ID; run;
proc sort data=parents1; by Final_ID; run;
proc sort data=master1; by Final_ID; run;

/*For some reason "No_start" is a character variable in the master. Changing to numeric below for S17 only*/

data Master1; Set Master1;
   temp = input(No_Start, 1.);
   DROP No_start;
run;


DATA Master1;
	RETAIN Final_ID type sibs mentee_male mentee_bmonth mentee_byear night mfcond menfamID room no_start date_dropped impnotes;
SET Master1;
	no_start = temp;
DROP temp;
RUN;
	

/*Neil Adding in night variable for mentors*/


proc import datafile="T:\Research folders\CCWTG\Analyses\NEIL\Staff_Master\Staff_Master_Final.csv"
out=staff_master dbms=csv replace; guessingrows=32767; getnames=yes;
run;

data Day; SET staff_master;
	IF Semester ne "S17" THEN DELETE;
	KEEP FINAL_ID Night_1 Night_2;
RUN;

proc sort data = staff_master; by Final_ID; RUN;

DATA Mentors1;
	MERGE Mentors1 Day;
	BY FInal_ID;
RUN;

DATA Mentors1; SET MENTORS1;
	IF night_1 = "monday" 		THEN m1night_1 = 1;
	IF night_2 = "monday" 		THEN m1night_1 = 1;
	IF night_1 = "tuesday" 		THEN m1night_2 = 1;
	IF night_2 = "tuesday" 		THEN m1night_2 = 1;
	IF night_1 = "wednesday" 	THEN m1night_3 = 1;
	IF night_2 = "wednesday" 	THEN m1night_3 = 1;
	IF night_1 = "thursday" 	THEN m1night_4 = 1;
	IF night_2 = "thursday" 	THEN m1night_4 = 1;

	IF night_1 = "monday" 		THEN m2night_1 = 1;
	IF night_2 = "monday" 		THEN m2night_1 = 1;
	IF night_1 = "tuesday" 		THEN m2night_2 = 1;
	IF night_2 = "tuesday" 		THEN m2night_2 = 1;
	IF night_1 = "wednesday" 	THEN m2night_3 = 1;
	IF night_2 = "wednesday" 	THEN m2night_3 = 1;
	IF night_1 = "thursday" 	THEN m2night_4 = 1;
	IF night_2 = "thursday" 	THEN m2night_4 = 1;

	IF night_1 = "monday" 		THEN m3night_1 = 1;
	IF night_2 = "monday" 		THEN m3night_1 = 1;
	IF night_1 = "tuesday" 		THEN m3night_2 = 1;
	IF night_2 = "tuesday" 		THEN m3night_2 = 1;
	IF night_1 = "wednesday" 	THEN m3night_3 = 1;
	IF night_2 = "wednesday" 	THEN m3night_3 = 1;
	IF night_1 = "thursday" 	THEN m3night_4 = 1;
	IF night_2 = "thursday" 	THEN m3night_4 = 1;

	IF night_1 = "monday" 		THEN m4night_1 = 1;
	IF night_2 = "monday" 		THEN m4night_1 = 1;
	IF night_1 = "tuesday" 		THEN m4night_2 = 1;
	IF night_2 = "tuesday" 		THEN m4night_2 = 1;
	IF night_1 = "wednesday" 	THEN m4night_3 = 1;
	IF night_2 = "wednesday" 	THEN m4night_3 = 1;
	IF night_1 = "thursday" 	THEN m4night_4 = 1;
	IF night_2 = "thursday" 	THEN m4night_4 = 1;

	IF night_1 = "monday" 		THEN m5night_1 = 1;
	IF night_2 = "monday" 		THEN m5night_1 = 1;
	IF night_1 = "tuesday" 		THEN m5night_2 = 1;
	IF night_2 = "tuesday" 		THEN m5night_2 = 1;
	IF night_1 = "wednesday" 	THEN m5night_3 = 1;
	IF night_2 = "wednesday" 	THEN m5night_3 = 1;
	IF night_1 = "thursday" 	THEN m5night_4 = 1;
	IF night_2 = "thursday" 	THEN m5night_4 = 1;

DROP NIGHT_1 NIGHT_2;
RUN;

DATA MENTORS1; 
	RETAIN Final_ID	staff_nomentee	m0start	m0end	m1start	m1end	m2start	m2end	m3start	m3end	m4start	m4end	m5start	m5end	m1night_1	m1night_2	m1night_3	m1night_4	m2night_1	m2night_2	m2night_3	m2night_4	m3night_1	m3night_2	m3night_3	m3night_4	m4night_1	m4night_2	m4night_3	m4night_4	m5night_1	m5night_2	m5night_3	m5night_4;
	SET MENTORS1;
RUN;
/*DONE ADDING NIGHT VARIABLES FOR MENTORS*/




data finalS17.ALLS17; merge mentees1 mentors1 parents1 master1; by Final_ID; run;
data finalS17.mentees; set mentees1; semester='S17'; run;
data finalS17.mentors; set mentors1; semester='S17'; run;
data finalS17.parents; set parents1; semester='S17'; run;
data finalS17.master; set master1; semester='S17'; run;


/************************************************************************************************/
/*WEEKLY FILES                                                                                  */
/************************************************************************************************/

/*attendance and fidelity data*/
proc sort data=weekly; by mentee_name; run;

/*N = 1572*/

proc sort data=txassign; by mentee_name; run;
data weekly1; merge txassign (keep=Final_ID mentee_name) weekly (in=one); if one; by mentee_name; run;

/*N = 173*/

proc freq; tables Final_ID; run;

/*N = 1572: 13 missing*/


proc print data = weekly1;
	VAR tonight_mentee_name;
RUN;

data weekly1; set weekly1;

array timevar arrival leave; do over timevar;
if timevar='Youth was absent' or timevar='NA' then timevar=''; end;

if arrival ne '' or leave ne '' then present_fid=1;
else if arrival='' and leave='' then present_fid=0;

if tonight_mentee_name = 'NA' then present=0;
else if tonight_mentee_name ne 'NA' then present=1;

array recode wt_engage sss_engage dnr_engage a1_eng_act a1_eng_oy a1_eng_men a1_eng_om
a2_eng_act a2_eng_oy a2_eng_men a2_eng_om; do over recode;
if recode='High' then recode=3;
else if recode='Medium' then recode=2;
else if recode='Low' then recode=1;
else if recode='NA' then recode='';
else if recode='Youth was absent' then recode='';
end;

array recodedur wt_dur sss_dur dnr_dur a1_dur a2_dur;
do over recodedur;
if recodedur='NA' then recodedur=''; end;

new1 = input(wt_engage, 8.); drop wt_engage; rename new1=wt_engage;
new2 = input(sss_engage, 8.); drop sss_engage; rename new2=sss_engage;
new3 = input(dnr_engage, 8.); drop dnr_engage; rename new3=dnr_engage;
new4 = input(a1_eng_act, 8.); drop a1_eng_act; rename new4=a1_eng_act;
new5 = input(a1_eng_oy, 8.); drop a1_eng_oy; rename new5=a1_eng_oy;
new6 = input(a1_eng_men, 8.); drop a1_eng_men; rename new6=a1_eng_men;
new7 = input(a1_eng_om, 8.); drop a1_eng_om; rename new7=a1_eng_om;
new8 = input(a2_eng_act, 8.); drop a2_eng_act; rename new8=a2_eng_act;
new9 = input(a2_eng_oy, 8.); drop a2_eng_oy; rename new9=a2_eng_oy;
new10 = input(a2_eng_men, 8.); drop a2_eng_men; rename new10=a2_eng_men;
new11 = input(a2_eng_om, 8.); drop a2_eng_om; rename new11=a2_eng_om;
run;

Data weekly1; Set weekly1;
	if present_fid = 1 THEN present = 1;
RUN;

/*N = 1572*/

data weekly1; set weekly1;
keep Final_ID week present regmentor_name mentee_name mentor_name reg_m 
wt_engage sss_engage dnr_engage a1_eng_act a1_eng_oy a1_eng_men a1_eng_om
a2_eng_act a2_eng_oy a2_eng_men a2_eng_om
wt_dur sss_dur dnr_dur a1_dur a2_dur arrival leave;
run;

/*N = 1572*/

proc sort data=weekly1; by mentor_name; run;

data mentorid; set id; submentor_id=Final_ID; keep submentor_id mentor_name; run;
proc sort data=mentorid; by mentor_name; run;

data weekly2; merge weekly1 (in=one) mentorid; if one; by mentor_name;  run;

proc print data=weekly2; where Final_ID=""; run;

proc print; where reg_m="No";var Final_ID mentee_name mentor_name submentor_ID; run; /*Nothing seems too crazy, a few times that a mentor subbed?*/

data weekly3; set weekly2;
if reg_m ne 'No' then submentor_ID='';

if Final_ID="" then delete;

keep Final_ID week present submentor_ID 
wt_engage sss_engage dnr_engage a1_eng_act a1_eng_oy a1_eng_men a1_eng_om
a2_eng_act a2_eng_oy a2_eng_men a2_eng_om
wt_dur sss_dur dnr_dur a1_dur a2_dur arrival leave;
run;

/*N = 1572*/

data weekly3;
retain
Final_ID week present submentor_ID 
wt_engage sss_engage dnr_engage a1_eng_act a1_eng_oy a1_eng_men a1_eng_om
a2_eng_act a2_eng_oy a2_eng_men a2_eng_om
wt_dur sss_dur dnr_dur a1_dur a2_dur arrival leave;
set weekly3;
run;
proc sort data=weekly3; by Final_ID week; run;
data finalS17.weekly; set weekly3; semester='S17'; run;


/*There are some errors in this dataset*/

proc means; class present; run;

/*proc print data = weekly;*/
/*	where present = 0;*/
/*	RUN;*/

/*MIN MAXES SEEM FINE - All means 0 when present = 0 (This is good)*/

proc print data = Weekly3; where present=0 and wt_engage ne . or sss_engage ne . or dnr_engage ne .; var Final_ID week present sss_engage; run; /*NOT RUNNING I THINK THIS IS GOOD
			Where clauses won't run because it runs before the pdv*/
 proc print data = weekly3; where present = 0 & wt_engage ne .; run;


/*********************************************************************************************/
/*DINNER OBS                                                                                 */
/*********************************************************************************************/
/*FOR BOTH RAW FILES, CHANGE NA to BLANK BEFORE READING IN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

/*****DYAD DATA*****/
proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\FINALDATA\OTHER_FILES\S17_obsdyads.csv" 
out=obsdyads dbms=csv replace; guessingrows=30000; getnames=yes; 
run;
/*N = 873*/

data obsdyads; set obsdyads;
LENGTH nightname $10;

If night='M' then nightname='Monday';
If night='T' then nightname='Tuesday';
If night='W' then nightname='Wednesday';
If night='R' then nightname='Thursday';

DROP night;
run;

data obsdyads; set obsdyads;
rename nightname=night;
run;

data obsdyads; set obsdyads;
LENGTH menfamID $12;
if night='Monday' and family='A' and semester='S17' then menfamID='S17MF_MONA';
if night='Monday' and family='B' and semester='S17' then menfamID='S17MF_MONB';
if night='Monday' and family='C' and semester='S17' then menfamID='S17MF_MONC';
if night='Monday' and family='D' and semester='S17' then menfamID='S17MF_MOND';
if night='Monday' and family='E' and semester='S17' then menfamID='S17MF_MONE';
if night='Monday' and family='F' and semester='S17' then menfamID='S17MF_MONF';
if night='Monday' and family='G' and semester='S17' then menfamID='S17MF_MONG';
if night='Monday' and family='H' and semester='S17' then menfamID='S17MF_MONH';
if night='Monday' and family='I' and semester='S17' then menfamID='S17MF_MONI';

if night='Tuesday' and family='A' and semester='S17' then menfamID='S17MF_TUEA';
if night='Tuesday' and family='B' and semester='S17' then menfamID='S17MF_TUEB';
if night='Tuesday' and family='C' and semester='S17' then menfamID='S17MF_TUEC';
if night='Tuesday' and family='D' and semester='S17' then menfamID='S17MF_TUED';
if night='Tuesday' and family='E' and semester='S17' then menfamID='S17MF_TUEE';
if night='Tuesday' and family='F' and semester='S17' then menfamID='S17MF_TUEF';
if night='Tuesday' and family='G' and semester='S17' then menfamID='S17MF_TUEG';
if night='Tuesday' and family='H' and semester='S17' then menfamID='S17MF_TUEH';
if night='Tuesday' and family='I' and semester='S17' then menfamID='S17MF_TUEI';

if night='Wednesday' and family='A' and semester='S17' then menfamID='S17MF_WEDA';
if night='Wednesday' and family='B' and semester='S17' then menfamID='S17MF_WEDB';
if night='Wednesday' and family='C' and semester='S17' then menfamID='S17MF_WEDC';
if night='Wednesday' and family='D' and semester='S17' then menfamID='S17MF_WEDD';
if night='Wednesday' and family='E' and semester='S17' then menfamID='S17MF_WEDE';
if night='Wednesday' and family='F' and semester='S17' then menfamID='S17MF_WEDF';
if night='Wednesday' and family='G' and semester='S17' then menfamID='S17MF_WEDG';
if night='Wednesday' and family='H' and semester='S17' then menfamID='S17MF_WEDH';
if night='Wednesday' and family='I' and semester='S17' then menfamID='S17MF_WEDI';

if night='Thursday' and family='A' and semester='S17' then menfamID='S17MF_THUA';
if night='Thursday' and family='B' and semester='S17' then menfamID='S17MF_THUB';
if night='Thursday' and family='C' and semester='S17' then menfamID='S17MF_THUC';
if night='Thursday' and family='D' and semester='S17' then menfamID='S17MF_THUD';
if night='Thursday' and family='E' and semester='S17' then menfamID='S17MF_THUE';
if night='Thursday' and family='F' and semester='S17' then menfamID='S17MF_THUF';
if night='Thursday' and family='G' and semester='S17' then menfamID='S17MF_THUG';
if night='Thursday' and family='H' and semester='S17' then menfamID='S17MF_THUH';
if night='Thursday' and family='I' and semester='S17' then menfamID='S17MF_THUI';

if night='Monday' and family2='A' and semester='S17' then combined='S17MF_MONA';
if night='Monday' and family2='B' and semester='S17' then combined='S17MF_MONB';
if night='Monday' and family2='C' and semester='S17' then combined='S17MF_MONC';
if night='Monday' and family2='D' and semester='S17' then combined='S17MF_MOND';
if night='Monday' and family2='E' and semester='S17' then combined='S17MF_MONE';
if night='Monday' and family2='F' and semester='S17' then combined='S17MF_MONF';
if night='Monday' and family2='G' and semester='S17' then combined='S17MF_MONG';
if night='Monday' and family2='H' and semester='S17' then combined='S17MF_MONH';
if night='Monday' and family2='I' and semester='S17' then combined='S17MF_MONI';

if night='Tuesday' and family2='A' and semester='S17' then combined='S17MF_TUEA';
if night='Tuesday' and family2='B' and semester='S17' then combined='S17MF_TUEB';
if night='Tuesday' and family2='C' and semester='S17' then combined='S17MF_TUEC';
if night='Tuesday' and family2='D' and semester='S17' then combined='S17MF_TUED';
if night='Tuesday' and family2='E' and semester='S17' then combined='S17MF_TUEE';
if night='Tuesday' and family2='F' and semester='S17' then combined='S17MF_TUEF';
if night='Tuesday' and family2='G' and semester='S17' then combined='S17MF_TUEG';
if night='Tuesday' and family2='H' and semester='S17' then combined='S17MF_TUEH';
if night='Tuesday' and family2='I' and semester='S17' then combined='S17MF_TUEI';

if night='Wednesday' and family2='A' and semester='S17' then combined='S17MF_WEDA';
if night='Wednesday' and family2='B' and semester='S17' then combined='S17MF_WEDB';
if night='Wednesday' and family2='C' and semester='S17' then combined='S17MF_WEDC';
if night='Wednesday' and family2='D' and semester='S17' then combined='S17MF_WEDD';
if night='Wednesday' and family2='E' and semester='S17' then combined='S17MF_WEDE';
if night='Wednesday' and family2='F' and semester='S17' then combined='S17MF_WEDF';
if night='Wednesday' and family2='G' and semester='S17' then combined='S17MF_WEDG';
if night='Wednesday' and family2='H' and semester='S17' then combined='S17MF_WEDH';
if night='Wednesday' and family2='I' and semester='S17' then combined='S17MF_WEDI';

if night='Thursday' and family2='A' and semester='S17' then combined='S17MF_THUA';
if night='Thursday' and family2='B' and semester='S17' then combined='S17MF_THUB';
if night='Thursday' and family2='C' and semester='S17' then combined='S17MF_THUC';
if night='Thursday' and family2='D' and semester='S17' then combined='S17MF_THUD';
if night='Thursday' and family2='E' and semester='S17' then combined='S17MF_THUE';
if night='Thursday' and family2='F' and semester='S17' then combined='S17MF_THUF';
if night='Thursday' and family2='G' and semester='S17' then combined='S17MF_THUG';
if night='Thursday' and family2='H' and semester='S17' then combined='S17MF_THUH';
if night='Thursday' and family2='I' and semester='S17' then combined='S17MF_THUI';
run;

/*N = 873 */

data obsdyads; set obsdyads;
if mentor_name="" or mentee_name="" then delete;
run;

/*EVERYONE HAS A NAME! N= 873*/

data id; set id; in_id=1; run;

data idM; set id; if mentor_name="" then delete; keep mentor_name Final_ID; run;
data idK; set id; if mentee_name="" then delete; keep mentee_name Final_ID; run;

/*N = 173 Consistent!*/

/*Merge Files for Mentor ID*/
proc sort data = idM; by mentor_name; run;
proc sort data = obsdyads; by mentor_name; run;

data obsdyads; set obsdyads; in_obs=1; run;

data obsdyads1;
LENGTH 	mentor_name $50
		impnotes $100;
merge idM obsdyads;
by mentor_name;
run;

proc freq; tables Final_ID; run;

data look; set obsdyads1; where Final_ID=""; run;
proc print data=look; var mentor_name; run;

data obsdyads1; set obsdyads1; 
rename Final_ID=Final_ID_M;
run;

/*N = 916, Fixed in next statements, we added everyone (even if they arent't in the obsdyads... they get removed*/


/*Merge files for Mentee ID*/
proc sort data = idK; by mentee_name; run;
proc sort data = obsdyads1; by mentee_name; run;

/*Inconsistincies in the Spring 17 obsdyads file*/

Data obsdyads1; SET obsdyads1;

RUN;

/*This is for S17 only*/

data obsdyads2;
	Length impnotes $100;
merge idK obsdyads1; 
by mentee_name;
run;

proc freq; tables Final_ID; run;

data look; set obsdyads2; where Final_ID=""; run;


proc print data=look; var mentee_name; run;
/*No cases. This is good!*/
proc sort data = id; by mentee_name; run;
proc sort data = MASTER; by mentee_name; run;

data obsdyads2; set obsdyads2; 
rename Final_ID=Final_ID_K; 
run;

data obsdyads3; set obsdyads2;
LENGTH impnotes $100;

if in_obs ne 1 then delete;
if engage=. then delete;

/*if Final_ID_M eq "" or Final_ID_K eq "" then delete;*/

/*delete non-consenters*/

keep Final_ID_M Final_ID_K semester week menfamID combined engage coder live impnotes;
run;
/*In dropped to 783... This is fine, because we deleted thos ewith no engage score and those that were NOT in observation*/

DATA obsdyads_final;
	LENGTH impnotes $100;
RUN;

data obsdyads_final; 
retain Final_ID_M Final_ID_K semester week menfamID combined engage coder live impnotes;
set obsdyads3; 
run;

/*****FAMILY DIMENSIONS DATA*****/

proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\FINALDATA\OTHER_FILES\S17_obsdimensions.csv" 
out=obsdim dbms=csv replace; guessingrows=30000; getnames=yes; run;

/*N = 3255*/

data obsdim; set obsdim;
LENGTH	nightname $10;

If night='M' then nightname='Monday';
If night='T' then nightname='Tuesday';
If night='W' then nightname='Wednesday';
If night='R' then nightname='Thursday';

if score=. then delete;

DROP night;
run;

/*N = 2865... THIS MAKES SENSE we dropped those without scores*/

data obsdim; set obsdim;
rename nightname=night;
run;

data obsdim; set obsdim;
LENGTH	menfamID $12;

if night='Monday' and family='A' and semester='S17' then menfamID='S17MF_MONA';
if night='Monday' and family='B' and semester='S17' then menfamID='S17MF_MONB';
if night='Monday' and family='C' and semester='S17' then menfamID='S17MF_MONC';
if night='Monday' and family='D' and semester='S17' then menfamID='S17MF_MOND';
if night='Monday' and family='E' and semester='S17' then menfamID='S17MF_MONE';
if night='Monday' and family='F' and semester='S17' then menfamID='S17MF_MONF';
if night='Monday' and family='G' and semester='S17' then menfamID='S17MF_MONG';
if night='Monday' and family='H' and semester='S17' then menfamID='S17MF_MONH';
if night='Monday' and family='I' and semester='S17' then menfamID='S17MF_MONI';

if night='Tuesday' and family='A' and semester='S17' then menfamID='S17MF_TUEA';
if night='Tuesday' and family='B' and semester='S17' then menfamID='S17MF_TUEB';
if night='Tuesday' and family='C' and semester='S17' then menfamID='S17MF_TUEC';
if night='Tuesday' and family='D' and semester='S17' then menfamID='S17MF_TUED';
if night='Tuesday' and family='E' and semester='S17' then menfamID='S17MF_TUEE';
if night='Tuesday' and family='F' and semester='S17' then menfamID='S17MF_TUEF';
if night='Tuesday' and family='G' and semester='S17' then menfamID='S17MF_TUEG';
if night='Tuesday' and family='H' and semester='S17' then menfamID='S17MF_TUEH';
if night='Tuesday' and family='I' and semester='S17' then menfamID='S17MF_TUEI';

if night='Wednesday' and family='A' and semester='S17' then menfamID='S17MF_WEDA';
if night='Wednesday' and family='B' and semester='S17' then menfamID='S17MF_WEDB';
if night='Wednesday' and family='C' and semester='S17' then menfamID='S17MF_WEDC';
if night='Wednesday' and family='D' and semester='S17' then menfamID='S17MF_WEDD';
if night='Wednesday' and family='E' and semester='S17' then menfamID='S17MF_WEDE';
if night='Wednesday' and family='F' and semester='S17' then menfamID='S17MF_WEDF';
if night='Wednesday' and family='G' and semester='S17' then menfamID='S17MF_WEDG';
if night='Wednesday' and family='H' and semester='S17' then menfamID='S17MF_WEDH';
if night='Wednesday' and family='I' and semester='S17' then menfamID='S17MF_WEDI';

if night='Thursday' and family='A' and semester='S17' then menfamID='S17MF_THUA';
if night='Thursday' and family='B' and semester='S17' then menfamID='S17MF_THUB';
if night='Thursday' and family='C' and semester='S17' then menfamID='S17MF_THUC';
if night='Thursday' and family='D' and semester='S17' then menfamID='S17MF_THUD';
if night='Thursday' and family='E' and semester='S17' then menfamID='S17MF_THUE';
if night='Thursday' and family='F' and semester='S17' then menfamID='S17MF_THUF';
if night='Thursday' and family='G' and semester='S17' then menfamID='S17MF_THUG';
if night='Thursday' and family='H' and semester='S17' then menfamID='S17MF_THUH';
if night='Thursday' and family='I' and semester='S17' then menfamID='S17MF_THUI';

if night='Monday' and family2='A' and semester='S17' then combined='S17MF_MONA';
if night='Monday' and family2='B' and semester='S17' then combined='S17MF_MONB';
if night='Monday' and family2='C' and semester='S17' then combined='S17MF_MONC';
if night='Monday' and family2='D' and semester='S17' then combined='S17MF_MOND';
if night='Monday' and family2='E' and semester='S17' then combined='S17MF_MONE';
if night='Monday' and family2='F' and semester='S17' then combined='S17MF_MONF';
if night='Monday' and family2='G' and semester='S17' then combined='S17MF_MONG';
if night='Monday' and family2='H' and semester='S17' then combined='S17MF_MONH';
if night='Monday' and family2='I' and semester='S17' then combined='S17MF_MONI';

if night='Tuesday' and family2='A' and semester='S17' then combined='S17MF_TUEA';
if night='Tuesday' and family2='B' and semester='S17' then combined='S17MF_TUEB';
if night='Tuesday' and family2='C' and semester='S17' then combined='S17MF_TUEC';
if night='Tuesday' and family2='D' and semester='S17' then combined='S17MF_TUED';
if night='Tuesday' and family2='E' and semester='S17' then combined='S17MF_TUEE';
if night='Tuesday' and family2='F' and semester='S17' then combined='S17MF_TUEF';
if night='Tuesday' and family2='G' and semester='S17' then combined='S17MF_TUEG';
if night='Tuesday' and family2='H' and semester='S17' then combined='S17MF_TUEH';
if night='Tuesday' and family2='I' and semester='S17' then combined='S17MF_TUEI';

if night='Wednesday' and family2='A' and semester='S17' then combined='S17MF_WEDA';
if night='Wednesday' and family2='B' and semester='S17' then combined='S17MF_WEDB';
if night='Wednesday' and family2='C' and semester='S17' then combined='S17MF_WEDC';
if night='Wednesday' and family2='D' and semester='S17' then combined='S17MF_WEDD';
if night='Wednesday' and family2='E' and semester='S17' then combined='S17MF_WEDE';
if night='Wednesday' and family2='F' and semester='S17' then combined='S17MF_WEDF';
if night='Wednesday' and family2='G' and semester='S17' then combined='S17MF_WEDG';
if night='Wednesday' and family2='H' and semester='S17' then combined='S17MF_WEDH';
if night='Wednesday' and family2='I' and semester='S17' then combined='S17MF_WEDI';

if night='Thursday' and family2='A' and semester='S17' then combined='S17MF_THUA';
if night='Thursday' and family2='B' and semester='S17' then combined='S17MF_THUB';
if night='Thursday' and family2='C' and semester='S17' then combined='S17MF_THUC';
if night='Thursday' and family2='D' and semester='S17' then combined='S17MF_THUD';
if night='Thursday' and family2='E' and semester='S17' then combined='S17MF_THUE';
if night='Thursday' and family2='F' and semester='S17' then combined='S17MF_THUF';
if night='Thursday' and family2='G' and semester='S17' then combined='S17MF_THUG';
if night='Thursday' and family2='H' and semester='S17' then combined='S17MF_THUH';
if night='Thursday' and family2='I' and semester='S17' then combined='S17MF_THUI';
run;

/*N = 2865*/

data obsdim; set obsdim;
keep menfamID combined semester week variable score live coder;
run;

data obsdim; 
retain menfamID combined semester week variable score live coder;
set obsdim; 
run;
proc sort data=obsdim; by menfamID week; run;

proc freq; run;

/*Combined frequency = 2865*/

data finalS17.obsdyads; set obsdyads_final; run;
data finalS17.obsdim; set obsdim; run;



/*N = 2865*/




/*
proc contents data=final.ALLF16 noprint out=out(keep=name label);
run;
 
proc transpose data=out out=out1(drop=_name_ _label_);
var name label;
run;
 
ods listing close;
ods tagsets.excelxp file='T:\Research folders\CCWTG\CodeBooks\spss_mentees.xls';
 
proc report nowd noheader data=out1
 style(column)=[cellwidth=1in];
run;
 
ods _all_ close;
ods listing;
*/ 
/*Neil Name Check*/

PROC SORT DATA = Weekly
	OUT = Weekly_Unique NODUPKEY; 
	BY Mentor_name; 
RUN; 

DATA Weekly_Unique;
	SET Weekly_Unique;
	KEEP Mentor_Name Mentee_Name;
RUN;

PROC SORT DATA = obsdyads
	OUT = obsdyads_Unique NODUPKEY; 
	BY Mentor_name; 
RUN; 

DATA obsdyads_Unique;
	SET obsdyads_Unique;
	KEEP Mentor_Name Mentee_Name;
RUN;



DATA TxAssign_Unique;
	SET Txassign;
	KEEP Mentor_Name Mentee_Name;
RUN;


Proc Sort Data = TxAssign_Unique
	OUT = TxAssign_Unique NODUPKEY;
	By Mentor_Name;
RUN;


DATA ID_Unique;
	SET ID;
	KEEP Mentor_Name Mentee_Name;
RUN;


Proc Sort Data = ID_Unique
	OUT = ID_Unique NODUPKEY;
	By Mentor_Name;
RUN;


DATA ID_Unique;
	SET ID_Unique;
IF mentor_name ne "" THEN check = 1;

RUN;

DATA CHECKNAMES;
	merge ID_UNIQUE TXassign_Unique;
	BY Mentor_name;
	DROP mentee_Name;
	IF mentor_name = "" THEN DELETE;
	IF check ne 1 THEN output;
RUN;


DATA CheckNAMES;
	SET CHECKNAMES;
	merge	ID_Unique	weekly_Unique;
	IF mentor_name = "" THEN DELETE;
	IF check ne 1 THEN output;
RUN;
	

PROC Print data = CHECKNAMES;
	title 'CHECK THESE NAMES';
RUN;

title;   

DATA weekly_unique; 
	set Weekly_unique; 
	if mentor_name ne "" THEN check = 1;
RUN;

DATA CHECKNAMES2;
	merge obsdyads_unique	Weekly_Unique;
By mentor_name;
	If mentor_name ="" THEN DELETE;
IF check ne 1 THEN output;
RUN;



DATA ID_Unique;
	SET ID_Unique;
IF mentor_name ne "" THEN check_ID = 1;
RUN;

DATA weekly_Unique;
	SET weekly_Unique;
IF mentor_name ne "" THEN check_weekly = 1;
RUN;

DATA Txassign_Unique	;
	SET Txassign_Unique	;
IF mentor_name ne "" THEN check_tx = 1;
RUN;


DATA obsdyads_Unique	;
	SET obsdyads_Unique;
IF mentor_name ne "" THEN check_obsdy = 1;
RUN;



DATA Check_Names_FINAL;
	merge	ID_Unique		
			Txassign_Unique	
			obsdyads_Unique	
			Weekly_Unique	
			;
	BY	mentor_name;
	check = SUM(check_ID,  check_tx, check_obsdy, Check_Weekly);
	IF check < 4 THEN output;

RUN;


proc print data = Check_names_FInal;
	run;

proc sort data = ID_Unique;
	BY mentee_name;
RUN;


proc sort data = Txassign_Unique;
	BY mentee_name;
RUN;


DATA ID_Unique;
	SET ID_unique;
	if mentee_name ne "" THEN mentee_check = 1;
RUN;

DATA CHECKNAMES_mentee;
	merge ID_UNIQUE TXassign_Unique;
	BY Mentee_name;
	DROP mentor_Name;
	IF mentee_name = "" THEN DELETE;
	IF mentor_name = "" THEN DELETE;
	IF mentee_check ne 1 THEN output;
RUN;

PROC Print data = CHECKNAMES_mentee;
	title 'CHECK THESE NAMES';
RUN;

title;  

proc print data = ID_unique;
	run;
Proc Print data = Txassign_unique;
	RUN;

/*SOCIAL NETWORKS*/



/***********SOCIAL NETWORKS***********************************************/
/********MENTOR social networks*/
/*first, pull out id and the sn variables from the main datafile*/

DATA work.sn_mentors; SET S17.S17_final_mentor; run; 


/*ONLY DO FOR SPRING 17 -NEIL Weird naming problem in Qualtrics Fixing here*/
data sn_mentors;
   rename 
		m4ksn2a_m4ksn2a_x1-m4ksn2a_m4ksn2a_x33 = m4ksn2a_x1 - m4ksn2a_x33
		m4msn2a_m4msn2a_x1-m4msn2a_m4msn2a_x38 = m4msn2a_x1 - m4msn2a_x38;
Set sn_mentors;

		/*IF (m2ksn2a_x1 - m2ksn2a_x33) > 0 THEN (m2ksn1a_1 - m2ksn1a_33) = 1;*/
   RUN;

Data sn_mentors;
	SET SN_mentors;
		IF m2ksn2a_x1 ne  . THEN m2ksn1a_1  = 1;
		IF m2ksn2a_x2 ne  . THEN m2ksn1a_2  = 1;
		IF m2ksn2a_x3 ne  . THEN m2ksn1a_3  = 1;
		IF m2ksn2a_x4 ne  . THEN m2ksn1a_4  = 1;
		IF m2ksn2a_x5 ne  . THEN m2ksn1a_5  = 1;
		IF m2ksn2a_x6 ne  . THEN m2ksn1a_6  = 1;
		IF m2ksn2a_x7 ne  . THEN m2ksn1a_7  = 1;
		IF m2ksn2a_x8 ne  . THEN m2ksn1a_8  = 1;
		IF m2ksn2a_x9 ne  . THEN m2ksn1a_9  = 1;
		IF m2ksn2a_x10 ne . THEN m2ksn1a_10 = 1;
		IF m2ksn2a_x11 ne . THEN m2ksn1a_11 = 1;
		IF m2ksn2a_x12 ne . THEN m2ksn1a_12 = 1;
		IF m2ksn2a_x13 ne . THEN m2ksn1a_13 = 1;
		IF m2ksn2a_x14 ne . THEN m2ksn1a_14 = 1;
		IF m2ksn2a_x15 ne . THEN m2ksn1a_15 = 1;
		IF m2ksn2a_x16 ne . THEN m2ksn1a_16 = 1;
		IF m2ksn2a_x17 ne . THEN m2ksn1a_17 = 1;
		IF m2ksn2a_x18 ne . THEN m2ksn1a_18 = 1;
		IF m2ksn2a_x19 ne . THEN m2ksn1a_19 = 1;
		IF m2ksn2a_x20 ne . THEN m2ksn1a_20 = 1;
		IF m2ksn2a_x21 ne . THEN m2ksn1a_21 = 1;
		IF m2ksn2a_x22 ne . THEN m2ksn1a_22 = 1;
		IF m2ksn2a_x23 ne . THEN m2ksn1a_23 = 1;
		IF m2ksn2a_x24 ne . THEN m2ksn1a_24 = 1;
		IF m2ksn2a_x25 ne . THEN m2ksn1a_25 = 1;
		IF m2ksn2a_x26 ne . THEN m2ksn1a_26 = 1;
		IF m2ksn2a_x27 ne . THEN m2ksn1a_27 = 1;
		IF m2ksn2a_x28 ne . THEN m2ksn1a_28 = 1;
		IF m2ksn2a_x29 ne . THEN m2ksn1a_29 = 1;
		IF m2ksn2a_x30 ne . THEN m2ksn1a_30 = 1;
		IF m2ksn2a_x31 ne . THEN m2ksn1a_31 = 1;
		IF m2ksn2a_x32 ne . THEN m2ksn1a_32 = 1;
		IF m2ksn2a_x33 ne . THEN m2ksn1a_33 = 1;
run;

/*DONE WITH FIX 08/18/2017*/

/**/
/*data mentors;*/
/*   rename */
/*		m4ksn2a_m4ksn2a_x1-m4ksn2a_m4ksn2a_x33 = m4ksn2a_x1 - m4ksn2a_x33*/
/*		m4msn2a_m4msn2a_x1-m4msn2a_m4msn2a_x38 = m4msn2a_x1 - m4msn2a_x38;*/
/*Set mentors;*/
/*   RUN;*/
/**/
/**/
/**/
/**/
/*Data mentors;*/
/*RETAIN Final_ID m2ksn1a_1 - m2ksn1a_33;*/
/*SET mentors;*/
/*	IF m2ksn2a_x1 ne  . THEN m2ksn1a_1  = 1;*/
/*	IF m2ksn2a_x2 ne  . THEN m2ksn1a_2  = 1;*/
/*	IF m2ksn2a_x3 ne  . THEN m2ksn1a_3  = 1;*/
/*	IF m2ksn2a_x4 ne  . THEN m2ksn1a_4  = 1;*/
/*	IF m2ksn2a_x5 ne  . THEN m2ksn1a_5  = 1;*/
/*	IF m2ksn2a_x6 ne  . THEN m2ksn1a_6  = 1;*/
/*	IF m2ksn2a_x7 ne  . THEN m2ksn1a_7  = 1;*/
/*	IF m2ksn2a_x8 ne  . THEN m2ksn1a_8  = 1;*/
/*	IF m2ksn2a_x9 ne  . THEN m2ksn1a_9  = 1;*/
/*	IF m2ksn2a_x10 ne . THEN m2ksn1a_10 = 1;*/
/*	IF m2ksn2a_x11 ne . THEN m2ksn1a_11 = 1;*/
/*	IF m2ksn2a_x12 ne . THEN m2ksn1a_12 = 1;*/
/*	IF m2ksn2a_x13 ne . THEN m2ksn1a_13 = 1;*/
/*	IF m2ksn2a_x14 ne . THEN m2ksn1a_14 = 1;*/
/*	IF m2ksn2a_x15 ne . THEN m2ksn1a_15 = 1;*/
/*	IF m2ksn2a_x16 ne . THEN m2ksn1a_16 = 1;*/
/*	IF m2ksn2a_x17 ne . THEN m2ksn1a_17 = 1;*/
/*	IF m2ksn2a_x18 ne . THEN m2ksn1a_18 = 1;*/
/*	IF m2ksn2a_x19 ne . THEN m2ksn1a_19 = 1;*/
/*	IF m2ksn2a_x20 ne . THEN m2ksn1a_20 = 1;*/
/*	IF m2ksn2a_x21 ne . THEN m2ksn1a_21 = 1;*/
/*	IF m2ksn2a_x22 ne . THEN m2ksn1a_22 = 1;*/
/*	IF m2ksn2a_x23 ne . THEN m2ksn1a_23 = 1;*/
/*	IF m2ksn2a_x24 ne . THEN m2ksn1a_24 = 1;*/
/*	IF m2ksn2a_x25 ne . THEN m2ksn1a_25 = 1;*/
/*	IF m2ksn2a_x26 ne . THEN m2ksn1a_26 = 1;*/
/*	IF m2ksn2a_x27 ne . THEN m2ksn1a_27 = 1;*/
/*	IF m2ksn2a_x28 ne . THEN m2ksn1a_28 = 1;*/
/*	IF m2ksn2a_x29 ne . THEN m2ksn1a_29 = 1;*/
/*	IF m2ksn2a_x30 ne . THEN m2ksn1a_30 = 1;*/
/*	IF m2ksn2a_x31 ne . THEN m2ksn1a_31 = 1;*/
/*	IF m2ksn2a_x32 ne . THEN m2ksn1a_32 = 1;*/
/*	IF m2ksn2a_x33 ne . THEN m2ksn1a_33 = 1;*/
/*run;*/
/*DONE*/

proc sort data=sn_mentors; by Final_ID; run;
/*proc sort data=mentors1; by Final_ID; run;*/




/****NEIL FIX DONE  08/03/17***/

/*ONLY RUN THIS FOR Spring '17*/
data sn_mentors; set sn_mentors (keep =Final_ID 
m1msn1a_1--m1ksn2d_x28
m2msn1a_1--m2msn2a_x38

/*Unique to spring '17*/
m2ksn1a_1--m2ksn1a_28
m2ksn1a_29--m2ksn1a_33
m2ksn2a_x1--m2ksn2d_x30
/*end unique phase*/

m3msn1a_1--m3ksn2d_x31
m4msn1a_1--m4ksn2d_x31
m5msn1a_1--m5ksn2d_x31);
run;

DATA sn_mentors;

m1ksn1a_29 =.;
m1ksn1a_30 =.;
m1ksn1a_31 =.;
m1ksn1a_32 =.;
m1ksn1a_33 =.;
m1ksn1b_29 =.;
m1ksn1b_30 =.;
m1ksn1c_29 =.;
m1ksn1c_30 =.;
m1ksn1c_31 =.;
m1msn1d_39 =.;
m2msn1d_39 =.;
m1ksn1d_29 =.;
m1ksn1d_30 =.;
m1ksn1d_31 =.;
m2ksn1d_31 =.;

m1ksn2a_x29 =.;
m1ksn2a_x30 =.;
m1ksn2a_x31 =.;
m1ksn2a_x32 =.;
m1ksn2a_x33 =.;
m1ksn2b_x29 =.;
m1ksn2b_x30 =.;
m1ksn2c_x29 =.;
m1ksn2c_x30 =.;
m1ksn2c_x31 =.;
m1msn2d_x39 =.;
m2msn2d_x39 =.;
m1ksn2d_x29 =.;
m1ksn2d_x30 =.;
m1ksn2d_x31 =.;
m2ksn2d_x31 =.;

SET sn_mentors;
RUN;

/**/
/**/
/*data sn_mentors; set sn_mentors (keep =Final_ID */
/*m1msn1a_1--m1ksn2d_x28*/
/*m2msn1a_1--m2ksn2d_x30*/
/*m1ksn1a_1 -- m1ksn1a_33*/
/*m3msn1a_1--m3ksn2d_x31*/
/*m4msn1a_1--m4ksn2d_x31*/
/*m5msn1a_1--m5ksn2d_x31);*/
/*run;*/

/*transpose the social network data to go from wide to long*/
proc transpose data=sn_mentors out=el_mentors;
by Final_ID;
var m1msn1a_1--m2ksn1a_33 /*missing instances ->*/ m1ksn1a_29--m2ksn2d_x31;
run;

/*rename variables and subset variables*/

data el_mentors; set el_mentors;
length receiver $ 15; 
receiver=_NAME_; 
value=COL1;


if receiver='' then delete;

drop _NAME_ _LABEL_ COL1;

type_sn = substr(strip(receiver),4,3);
dyadrole = substr(strip(receiver),3,1);
survnum_c = substr(strip(receiver),2,1);
nightcode = substr(strip(receiver),7,1);

length night $ 10;
if nightcode='a' then night='Monday';
if nightcode='b' then night='Tuesday';
if nightcode='c' then night='Wednesday';
if nightcode='d' then night='Thursday';

if survnum_c='1' then survnum=1;
if survnum_c='2' then survnum=2;
if survnum_c='3' then survnum=3;
if survnum_c='4' then survnum=4;
if survnum_c='5' then survnum=5;


if dyadrole='k' then receiver_kid=1;
else if dyadrole='m' then receiver_kid=0;

drop dyadrole;

sender_kid=0;

m = 'M';
Sender_Final_ID = cats(of m Final_ID);
drop Final_ID m;

receiver_adj=receiver;
substr(receiver_adj,1,2)='mX';

receiver_wt=receiver;

drop survnum_c nightcode;
run;



proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\FINALDATA\OTHER_FILES\S17_SNMATCH.csv"
out=snmatch dbms=csv replace; guessingrows=500; getnames=yes;
run;

data snmatch_original;
	set snmatch;
RUN;


proc print data = snmatch noobs;
	where weight_mentor_1 = "";
	VAR receiver_mentor ;*weight_mentor_1;
RUN;



DATA snmatch;
	SET snmatch;
	 IF receiver_mentor=	"mXksn1a_29" THEN 	weight_mentor_1=	"m1ksn2a_x29";
else IF receiver_mentor=	"mXksn1a_30" THEN 	weight_mentor_1=	"m1ksn2a_x30";
else IF receiver_mentor=	"mXksn1a_31" THEN	weight_mentor_1=	"m1ksn2a_x31";
else IF	receiver_mentor= 	"mXksn1a_32" THEN	weight_mentor_1=	"m1ksn2a_x32";
else IF	receiver_mentor= 	"mXksn1a_33" THEN	weight_mentor_1=	"m1ksn2a_x33";
else IF	receiver_mentor= 	"mXksn1b_29" THEN	weight_mentor_1=	"m1ksn2b_x29";
else IF	receiver_mentor=	"mXksn1b_30" THEN	weight_mentor_1=	"m1ksn2b_x30";
else IF	receiver_mentor= 	"mXksn1c_29" THEN	weight_mentor_1=	"m1ksn2c_x29";
else IF	receiver_mentor= 	"mXksn1c_30" THEN	weight_mentor_1=	"m1ksn2c_x30";
else IF	receiver_mentor= 	"mXksn1c_31" THEN	weight_mentor_1=	"m1ksn2c_x31";
else IF	receiver_mentor= 	"mXmsn1d_39" THEN	weight_mentor_1=	"m1msn2d_x39";

else IF	receiver_mentor= 	"mXmsn1d_39" THEN	weight_mentor_2=	"m2msn2d_x39";

else IF	receiver_mentor= 	"mXksn1d_29" THEN	weight_mentor_1=	"m1ksn2d_x29";
else IF	receiver_mentor= 	"mXksn1d_30" THEN	weight_mentor_1=	"m1ksn2d_x30";
else IF	receiver_mentor= 	"mXksn1d_31" THEN	weight_mentor_1=	"m1ksn2d_x31";

else IF	receiver_mentor= 	"mXksn1d_31" THEN	weight_mentor_2=	"m2ksn2d_x31";


	 IF receiver_mentor=	"mXksn1a_29" THEN 	weight_mentee_1=	"k1ksn2a_x29";
else IF receiver_mentor=	"mXksn1a_30" THEN 	weight_mentee_1=	"k1ksn2a_x30";
else IF receiver_mentor=	"mXksn1a_31" THEN	weight_mentee_1=	"k1ksn2a_x31";
else IF	receiver_mentor= 	"mXksn1a_32" THEN	weight_mentee_1=	"k1ksn2a_x32";
else IF	receiver_mentor= 	"mXksn1a_33" THEN	weight_mentee_1=	"k1ksn2a_x33";
else IF	receiver_mentor= 	"mXksn1b_29" THEN	weight_mentee_1=	"k1ksn2b_x29";
else IF	receiver_mentor=	"mXksn1b_30" THEN	weight_mentee_1=	"k1ksn2b_x30";
else IF	receiver_mentor= 	"mXksn1c_29" THEN	weight_mentee_1=	"k1ksn2c_x29";
else IF	receiver_mentor= 	"mXksn1c_30" THEN	weight_mentee_1=	"k1ksn2c_x30";
else IF	receiver_mentor= 	"mXksn1c_31" THEN	weight_mentee_1=	"k1ksn2c_x31";
else IF	receiver_mentor= 	"mXmsn1d_39" THEN	weight_mentee_1=	"k1msn2d_x39";

else IF	receiver_mentor= 	"mXmsn1d_39" THEN	weight_mentee_2=	"k2msn2d_x39";

else IF	receiver_mentor= 	"mXksn1d_29" THEN	weight_mentee_1=	"k1ksn2d_x29";
else IF	receiver_mentor= 	"mXksn1d_30" THEN	weight_mentee_1=	"k1ksn2d_x30";
else IF	receiver_mentor= 	"mXksn1d_31" THEN	weight_mentee_1=	"k1ksn2d_x31";

else IF	receiver_mentor= 	"mXksn1d_31" THEN	weight_mentee_2=	"k2ksn2d_x31";
RUN;




data el_mentors_adj; set el_mentors; where type_sn='sn1'; run;
data el_mentors_sn2_wk1; set el_mentors; where type_sn='sn2'; run; data el_mentors_sn2_wk1; set el_mentors_sn2_wk1; if survnum ne '1' then delete; run; 
data el_mentors_sn2_wk3; set el_mentors; where type_sn='sn2'; run; data el_mentors_sn2_wk3; set el_mentors_sn2_wk3; if survnum ne '2' then delete; run; 
data el_mentors_sn2_wk6; set el_mentors; where type_sn='sn2'; run; data el_mentors_sn2_wk6; set el_mentors_sn2_wk6; if survnum ne '3' then delete; run; 
data el_mentors_sn2_wk9; set el_mentors; where type_sn='sn2'; run; data el_mentors_sn2_wk9; set el_mentors_sn2_wk9; if survnum ne '4' then delete; run; 
data el_mentors_sn2_wk11; set el_mentors; where type_sn='sn2'; run; data el_mentors_sn2_wk11; set el_mentors_sn2_wk11; if survnum ne '5' then delete; run; 



data snmatch; set snmatch; length receiver_adj $ 15; receiver_adj=receiver_mentor; run;
proc sort data=snmatch; by receiver_adj; run;
proc sort data=el_mentors_adj; by receiver_adj; run;
data el_mentors_adj; merge el_mentors_adj snmatch (keep=receiver_adj name); by receiver_adj;  run;


proc sort data=el_mentors_sn2_wk1; by receiver; run;
proc sort data=el_mentors_sn2_wk3; by receiver; run;
proc sort data=el_mentors_sn2_wk6; by receiver; run;
proc sort data=el_mentors_sn2_wk9; by receiver; run;
proc sort data=el_mentors_sn2_wk11; by receiver; run;


data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentor_1; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentors_wt_wk1; merge el_mentors_sn2_wk1 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentor_3; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentors_wt_wk3; merge el_mentors_sn2_wk3 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentor_6; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentors_wt_wk6; merge el_mentors_sn2_wk6 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentor_9; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentors_wt_wk9; merge el_mentors_sn2_wk9 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentor_11; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentors_wt_wk11; merge el_mentors_sn2_wk11 snmatch (keep=receiver_wt name); by receiver_wt; run;

data el_mentors; set el_mentors_adj el_mentors_wt_wk1 el_mentors_wt_wk3 el_mentors_wt_wk6 el_mentors_wt_wk9  
el_mentors_wt_wk11; run;


/*check - hope that there are not any cases*/
data check; set el_mentors; where name="" and value ne .; run;

/*No CASES in check! 09/06/2017 -NEIL*/



/*transpose the id match file to go from wide to long to account for
mentor and mentee having the same ID*/
proc sort data=id; by Final_ID; run;
proc transpose data=id out=id_long;
by Final_ID;
var mentor_name mentee_name;
run;

data id_long; set id_long;
name=COL1;
drop COL1;

if name="" then delete;
run;

proc sort data=el_mentors; by name; run;
proc sort data=id_long; by name; run;



/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*NEIL CHECKING SN match & tempdelete files*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;

PROC SORT data = ID_long;
BY name;
RUN;

PROC SORT data = Snmatch;
BY name;
RUN;

DATA namecheck;
	MERGE ID_long Snmatch;
	BY name;
RUN;


PROC SORT data = namecheck;
BY Final_ID Name;
RUN;

PROC PRINT data = namecheck;
VAR Final_ID Name;
RUN;



DATA snmatch;
	Set Snmatch;
RUN;




/*ALL GOOD! 05/10/2017 -NEIL*/
/*/*/*/*/NEIL DONE*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;


/*make the final edgelist file*/
data el_mentors_final; 
length name $ 50; 
merge 
el_mentors (keep=Sender_Final_ID name value type_sn receiver_kid sender_kid 
night survnum)  
id_long; 
by name; run; 


proc freq data=el_mentors_final;
TABLES Final_ID;
RUN;



data el_mentors_final; set el_mentors_final;
if survnum=. then delete;

m = 'M';
k = 'K';

if receiver_kid=1 then do; Receiver_Final_ID = cats(of k Final_ID); end;
if receiver_kid=0 then do; Receiver_Final_ID = cats(of m Final_ID); end;

keep Sender_Final_ID Receiver_Final_ID survnum type_sn value night;
run;



data check; set el_mentors_final; where Sender_Final_ID='' or Receiver_Final_ID=''; run;
/*^^^No observations! This is good! Neil 09/06/17^^^*/


data el_mentors_final;

retain
Sender_Final_ID Receiver_Final_ID survnum type_sn value night;
set el_mentors_final;
run;


proc sort data=el_mentors_final; by Sender_Final_ID survnum night Receiver_Final_ID type_sn; run; 


proc transpose data=el_mentors_final out=el_mentors_final;
    by Sender_Final_ID survnum night Receiver_Final_ID;
    id type_sn;
    var value;
run;

data el_mentors_final; set el_mentors_final;
drop _NAME_;
run;



proc print; where sn1=1 and sn2=.; run;
proc print; where sn1=. and sn2 ne .; run;

/*2 instances of sn1= 1 and sn2=.
	NO instances of sn1=. and Sn2 ne . (This is good) NEIL - 09/06/2017*/


data check; set el_mentors_final; /*where survnum=5 and night='monday';*/

if Sender_Final_ID = 'M' then delete;
if Sender_Final_ID = 'K' then delete;
if Receiver_Final_ID = 'M' then delete;
if Receiver_Final_ID = 'K' then delete;

role = substr(strip(Receiver_Final_ID),1,1);
if role = 'M' then delete;

s = substr(strip(Sender_Final_ID),8,4);
r = substr(strip(Receiver_Final_ID),8,4);

if s ne r then delete;
run;




/*NEIL removing instances of nights that they don't belong*/
/*Created custom staff list - THIS IMPORT NEEDS TO CHANGE EACH SEMESTER*/

proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\FINALDATA\Other_Files\staff_list.csv"
out=stafflist dbms=csv replace; guessingrows=32767; getnames=yes;
run;

proc sort data = IDM;
	BY	mentor_name;
RUN;

proc sort data = stafflist;
	BY	mentor_name;
RUN;


DATA stafflist; 
	MERGE IDm Stafflist;
	BY mentor_name;
	DROP mentor_name;
	night1=night;
RUN;

DATA el_mentors_final; 
	SET El_mentors_final;
	Night1 = Lowcase(Night);
	DROP NIGHT;
RUN; 

DATA el_mentors_final;
	RETAIN Sender_Final_ID survnum night Receiver_Final_ID;
	SET el_mentors_final;
	Night = Night1;
	DROP Night1;
RUN;

DATA stafflist; 
	SET Stafflist;
	Sender_Final_ID	=	CAT('M', Final_ID); 
	DROP Final_ID;
RUN;

proc sort data = el_mentors_final;
	By	Sender_Final_ID night;
RUN;


proc sort data = Stafflist;
	By	Sender_Final_ID night;
RUN;

DATA el_mentors_final;
	MERGE el_mentors_final Stafflist;
	BY Sender_Final_ID night;
RUN;


DATA el_mentors_final;
	SET el_mentors_final;
	IF night ne night1 THEN DELETE;
	DROP Night1;
RUN;
	

/******MENTEE social networks*/
/*first, pull out id and the sn variables from the main datafile*/
DATA work.sn_mentees; SET S17.S17_final_mentee; run; 

proc sort data=sn_mentees; by Final_ID; run;
/*proc sort data=mentors1; by Final_ID; run;*/

DATA sn_mentees; 
rename 
		k2msn2a_x1_0 = k2ksn2a_x1
		k2msn2a_x2_0 = k2ksn2a_x2
		k2msn2a_x3_0 = k2ksn2a_x3
		k2msn2a_x4_0 = k2ksn2a_x4
		k2msn2a_x5_0 = k2ksn2a_x5
		k2msn2a_x6_0 = k2ksn2a_x6
		k2msn2a_x7_0 = k2ksn2a_x7
		k2msn2a_x8_0 = k2ksn2a_x8
		k2msn2a_x9_0 = k2ksn2a_x9
		k2msn2a_x10_0 = k2ksn2a_x10
		k2msn2a_x11_0 = k2ksn2a_x11
		k2msn2a_x12_0 = k2ksn2a_x12
		k2msn2a_x13_0 = k2ksn2a_x13
		k2msn2a_x14_0 = k2ksn2a_x14
		k2msn2a_x15_0 = k2ksn2a_x15
		k2msn2a_x16_0 = k2ksn2a_x16
		k2msn2a_x17_0 = k2ksn2a_x17
		k2msn2a_x18_0 = k2ksn2a_x18
		k2msn2a_x19_0 = k2ksn2a_x19
		k2msn2a_x20_0 = k2ksn2a_x20
		k2msn2a_x21_0 = k2ksn2a_x21
		k2msn2a_x22_0 = k2ksn2a_x22
		k2msn2a_x23_0 = k2ksn2a_x23
		k2msn2a_x24_0 = k2ksn2a_x24
		k2msn2a_x25_0 = k2ksn2a_x25
		k2msn2a_x26_0 = k2ksn2a_x26
		k2msn2a_x27_0 = k2ksn2a_x27
		k2msn2a_x28_0 = k2ksn2a_x28
		k2msn2a_x29_0 = k2ksn2a_x29
		k2msn2a_x30_0 = k2ksn2a_x30
		k2msn2a_x31_0 = k2ksn2a_x31
		k2msn2a_x32_0 = k2ksn2a_x32
		k2msn2a_x33_0 = k2ksn2a_x33
									;
			Set sn_mentees;
RUN;
 



/****NEIL FIX***/
data sn_mentees; set sn_mentees (keep =Final_ID 
k1msn1a_1--k1ksn2d_x28
k2msn1a_1--k2ksn2d_x30
k3msn1a_1--k3ksn2d_x31
k4msn1a_1--k4ksn2d_x31
k5msn1a_1--k5ksn2d_x31);
run;



DATA sn_mentees;

k1ksn1a_29 =.;
k1ksn1a_30 =.;
k1ksn1a_31 =.;
k1ksn1a_32 =.;
k1ksn1a_33 =.;
k1ksn1b_29 =.;
k1ksn1b_30 =.;
k1ksn1c_29 =.;
k1ksn1c_30 =.;
k1ksn1c_31 =.;
k1msn1d_39 =.;
k2msn1d_39 =.;
k1ksn1d_29 =.;
k1ksn1d_30 =.;
k1ksn1d_31 =.;
k2ksn1d_31 =.;

k1ksn2a_x29 =.;
k1ksn2a_x30 =.;
k1ksn2a_x31 =.;
k1ksn2a_x32 =.;
k1ksn2a_x33 =.;
k1ksn2b_x29 =.;
k1ksn2b_x30 =.;
k1ksn2c_x29 =.;
k1ksn2c_x30 =.;
k1ksn2c_x31 =.;
k1msn2d_x39 =.;
k2msn2d_x39 =.;
k1ksn2d_x29 =.;
k1ksn2d_x30 =.;
k1ksn2d_x31 =.;
k2ksn2d_x31 =.;

SET sn_mentees;
RUN;



/*transpose the social network data to go from wide to long*/
proc transpose data=sn_mentees out=el_mentees;
by Final_ID;
var k1msn1a_1--k5ksn2d_x31  k1ksn1a_29--k2ksn2d_x31;
run;



/*rename variables and subset variables*/
data el_mentees; set el_mentees;
length receiver $ 15; 
receiver=_NAME_; 
value=COL1;

if receiver='' then delete;

drop _NAME_ _LABEL_ COL1;

type_sn = substr(strip(receiver),4,3);
dyadrole = substr(strip(receiver),3,1);
survnum_c = substr(strip(receiver),2,1);
nightcode = substr(strip(receiver),7,1);

length night $ 10;
if nightcode='a' then night='monday';
if nightcode='b' then night='tuesday';
if nightcode='c' then night='wednesday';
if nightcode='d' then night='thursday';

if survnum_c='1' then survnum=1;
if survnum_c='2' then survnum=2;
if survnum_c='3' then survnum=3;
if survnum_c='4' then survnum=4;
if survnum_c='5' then survnum=5;


if dyadrole='k' then receiver_kid=1;
else if dyadrole='m' then receiver_kid=0;

drop dyadrole;

sender_kid=1;

k = 'K';
Sender_Final_ID = cats(of k Final_ID);
drop Final_ID k;

receiver_adj=receiver;
substr(receiver_adj,1,2)='kX';

receiver_wt=receiver;

drop survnum_c nightcode;
run;

/*proc import datafile="T:\Research folders\CCWTG\Data\Fall2016\FINALDATA\OTHER_FILES\F16_SNMATCH.csv" */
/*out=snmatch dbms=csv replace; guessingrows=200; getnames=yes;*/
/*run;*/



data el_mentees_adj; set el_mentees; where type_sn='sn1'; run;
data el_mentees_sn2_wk1; set el_mentees; where type_sn='sn2'; run; data el_mentees_sn2_wk1; set el_mentees_sn2_wk1; if survnum ne '1' then delete; run; 
data el_mentees_sn2_wk3; set el_mentees; where type_sn='sn2'; run; data el_mentees_sn2_wk3; set el_mentees_sn2_wk3; if survnum ne '2' then delete; run; 
data el_mentees_sn2_wk6; set el_mentees; where type_sn='sn2'; run; data el_mentees_sn2_wk6; set el_mentees_sn2_wk6; if survnum ne '3' then delete; run; 
data el_mentees_sn2_wk9; set el_mentees; where type_sn='sn2'; run; data el_mentees_sn2_wk9; set el_mentees_sn2_wk9; if survnum ne '4' then delete; run; 
data el_mentees_sn2_wk11; set el_mentees; where type_sn='sn2'; run; data el_mentees_sn2_wk11; set el_mentees_sn2_wk11; if survnum ne '5' then delete; run; 

data snmatch; set snmatch; length receiver_adj $ 15; receiver_adj=receiver_mentee; run;
proc sort data=snmatch; by receiver_adj; run;
proc sort data=el_mentees_adj; by receiver_adj; run;
data el_mentees_adj; merge el_mentees_adj snmatch (keep=receiver_adj name); by receiver_adj;  run;

proc sort data=el_mentees_sn2_wk1; by receiver; run;
proc sort data=el_mentees_sn2_wk3; by receiver; run;
proc sort data=el_mentees_sn2_wk6; by receiver; run;
proc sort data=el_mentees_sn2_wk9; by receiver; run;
proc sort data=el_mentees_sn2_wk11; by receiver; run;



data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentee_1; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentees_wt_wk1; merge el_mentees_sn2_wk1 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentee_3; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentees_wt_wk3; merge el_mentees_sn2_wk3 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentee_6; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentees_wt_wk6; merge el_mentees_sn2_wk6 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentee_9; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentees_wt_wk9; merge el_mentees_sn2_wk9 snmatch (keep=receiver_wt name); by receiver_wt; run;

data snmatch; set snmatch; length receiver_wt $ 15; receiver_wt=weight_mentee_11; run; proc sort data=snmatch; by receiver_wt; run;
data el_mentees_wt_wk11; merge el_mentees_sn2_wk11 snmatch (keep=receiver_wt name); by receiver_wt; run;


data el_mentees; set el_mentees_adj el_mentees_wt_wk1 el_mentees_wt_wk3 el_mentees_wt_wk6 el_mentees_wt_wk9 el_mentees_wt_wk11; run;


data check; set el_mentees; where name="" and value ne .; run;

/*NO OBSERVATIONS! This is good -Neil 09/06/2017*/

/*transpose the id match file to go from wide to long to account for
mentor and mentee having the same ID*/
proc sort data=id; by Final_ID; run;
proc transpose data=id out=id_long;
by Final_ID;
var mentor_name mentee_name;
run;

data id_long; set id_long;
name=COL1;
drop COL1;

if name="" then delete;
run;

proc sort data=el_mentees; by name; run;
proc sort data=id_long; by name; run;


/*make the final edgelist file*/
data el_mentees_final; 
length name $ 50; 
merge 
el_mentees (keep=Sender_Final_ID name value type_sn receiver_kid sender_kid 
night survnum)  
id_long; 
by name; run; 


data el_mentees_final; set el_mentees_final;
if survnum=. then delete;

m = 'M';
k = 'K';

if receiver_kid=1 then do; Receiver_Final_ID = cats(of k Final_ID); end;
if receiver_kid=0 then do; Receiver_Final_ID = cats(of m Final_ID); end;

keep Sender_Final_ID Receiver_Final_ID survnum type_sn value night;
run;



data check; set el_mentees_final; where Sender_Final_ID='' or Receiver_Final_ID=''; run;
/*NO OBSERVATIONS This is good -NEIL 09/06/2017 */

data el_mentees_final;

retain
Sender_Final_ID Receiver_Final_ID survnum type_sn value night;
set el_mentees_final;
run;

proc freq; tables Sender_Final_ID Receiver_Final_ID; run;

proc sort data=el_mentees_final; by Sender_Final_ID survnum night Receiver_Final_ID type_sn; run;  

data temp; set el_mentees_final;
if Sender_Final_ID='' or Receiver_Final_ID='' then delete;
if Receiver_Final_ID='K' then delete;
run;


proc transpose data=/*el_mentees_final*/ temp out=el_mentees_final;
    by Sender_Final_ID survnum night Receiver_Final_ID;
    id type_sn;
    var value;
run;


data el_mentees_final; set el_mentees_final;
drop _NAME_;
run;

proc print; where sn1=1 and sn2=.; run;
proc print; where sn1=. and sn2 ne .; run;

/*2 instance of sn1= 1 and sn2=.
	NO instances of sn1=. and Sn2 ne . (This is good) NEIL - 09/06/2017*/


data check; set el_mentees_final; /*where survnum=5 and night='monday';*/

if Sender_Final_ID = 'M' then delete;
if Sender_Final_ID = 'K' then delete;
if Receiver_Final_ID = 'M' then delete;
if Receiver_Final_ID = 'K' then delete;

role = substr(strip(Receiver_Final_ID),1,1);
if role = 'K' then delete;

s = substr(strip(Sender_Final_ID),8,4);
r = substr(strip(Receiver_Final_ID),8,4);

if s ne r then delete;
if sn1 ne . then delete;
run;


/*NEIL removing instances of nights that they don't belong*/
/*Created custom staff list*/

proc sort data = IDK;
	BY	Final_ID;
RUN;

DATA Master2;
	Set MAster1;
	IF no_start = 1 THEN DELETE;
	Night1 = LOWCASE(Night);
RUN;

proc sort data = Master2;
	BY	Final_ID;
RUN;


DATA KidList; 
	MERGE IDk Master2;
	BY FInal_ID;
	KEEP	Final_ID Night1;
	Night = Night1;
	IF Night = '' THEN DELETE;
RUN;


DATA el_mentees_final; 
	SET El_mentees_final;
	Night1 = Lowcase(Night);
	DROP NIGHT;
RUN; 

DATA el_mentees_final;
	RETAIN Sender_Final_ID survnum night Receiver_Final_ID;
	SET el_mentees_final;
	Night = Night1;
	DROP NIGHT1;
RUN;


DATA kidlist; 
	SET kidlist;
	Sender_Final_ID	=	CAT('K', Final_ID); 
	DROP Final_ID;
	Night = Night1;
RUN;



proc sort data = el_mentees_final;
	By	Sender_Final_ID night;
RUN;


proc sort data = kidlist;
	By	Sender_Final_ID Night;
RUN;

DATA el_mentees_final;
	MERGE el_mentees_final kidlist;
	BY Sender_Final_ID night;
RUN;

proc sort data = el_mentees_final;
	BY Sender_final_ID;
RUN;

DATA el_mentees_final;
	SET el_mentees_final;
	IF night ne night1 THEN DELETE;
	DROP Night1;
RUN;


proc print data = staff_master;
	where FINAL_ID = "CCS17_4709";
RUN;


/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/




								NEIL Indicating points where Mentors did not rate their Paired Youth



/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/;

/*STEP 1: Assign Dates to Surveys (Dates created by the Fall '15 Master schedule. Dates= survey was distributed*/

DATA El_mentors_odd;
	SET El_mentors_final;

	Mentor = FINDC(receiver_Final_ID, 'M', "i"); * Finds the first 'M' regardless of case *;

/*CHANGE THESE DATES BASED ON WHEN SURVEYS WERE TAKEN: Keep DayMonYear format*/

	IF survnum=1 THEN survdate= '06Feb2017'd;
	IF survnum=2 THEN survdate= '20Feb2017'd;
	IF survnum=3 THEN survdate= '20Mar2017'd;
	IF survnum=4 THEN survdate= '10Apr2017'd;
	IF survnum=5 THEN survdate= '24Apr2017'd;



	FORMAT survdate MMDDYY.;
	
	RUN;


/*Step 2: Identifying cases in which SENDERS were mentors*/

DATA Work.MasterM;
	Set Work.Master1;

	Sender_Final_ID	=	CAT('M', Final_ID); 

	RUN;


/*Step 3: Merging the information from the final edgelist with the information from the Master file 
	(So we can get date dropped and mentor/mentee pairs*/

proc sort data = el_mentors_odd;
	BY Sender_Final_ID; 
	RUN;

proc sort data = MasterM;
	BY Sender_Final_ID; 
	RUN;


data el_mentors_odd2; 
  merge el_mentors_odd MasterM;
  by Sender_Final_ID;



/*Step 3.1: Merging the files together.*/

/*  	1.) 	removign cases where theyouth did not start*/
IF no_start = 1 THEN DELETE;

/*2.) 	Removing the survey portions after the youth dropped*/
IF date_Dropped ne .  AND date_dropped < survdate THEN DELETE;

/*Only including Mentors because they were the senders in this survey*/

IF mentor = 1 THEN DELETE;

DROP Final_ID; 
  RUN;


/*Step 4: Drop K or M indicators so we can match on Final_ID again.*/
DATA el_mentors_odd2;

	SET el_mentors_odd2;
		Mentor_ID = SUBSTR(Sender_Final_ID, 2, 10);
		Mentee_ID = SUBSTR(Receiver_Final_ID, 2, 10);
RUN;




/*Step 5: Creating data set that shows pairs*/
DATA Mentor_Send_Match;
	SET el_mentors_odd2;
	WHERE Mentor_ID = Mentee_ID;
	
RUN;

/*Step 6: Proc Print and Proc Freq showing these odd cases where Mentors did NOT choose their assigned youth pair AFTER survey 1 (We would expect them not to rate them at survey 1)*/
PROC SORT data = Mentor_Send_Match;
	BY SurvNum;
RUN;


PROC PRINT DATA = Mentor_Send_Match;
	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;
/*	BY Survnum;*/
RUN;

PROC FREQ data = Mentor_Send_Match;
	TABLE survnum; 
	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;
/*	BY Survnum;*/
RUN;


/*Total pairs NOT indicating a relationship after survnum 1 = 31

Survey 2 missing = 21
Survey 3 missing = 7
Survey 4 missing = 2
Survey 5 missing = 1


*/


/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

Below Neil is seperating the cases where Mentee did Not choose the Mentor Because their survey is missing.

/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/;


DATA sncheck_allM;
	SET Mentor_Send_Match (Where=(Sn1 = . AND survnum ne 1 AND date_dropped = .));
		Final_ID = Mentee_ID;
RUN;





/*PROC FREQ data = sncheck_allM;*/
/*	TABLE survnum; */
/*	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;*/
/*	BY Survnum;*/
/*RUN;*/



/*Outputting cases where mentee did not choose mentor into seperate datafiles*/

Data	sncheckM_surv2
		sncheckM_surv3
		sncheckM_surv4
		sncheckM_surv5;

SET	Mentor_Send_Match;

	FINAL_ID = Mentor_ID;
	
	IF Sn1 = . AND survnum = 2 AND date_dropped = . THEN Output sncheckM_surv2;
	IF Sn1 = . AND survnum = 3 AND date_dropped = . THEN Output sncheckM_surv3;
	IF Sn1 = . AND survnum = 4 AND date_dropped = . THEN Output sncheckM_surv4;
	IF Sn1 = . AND survnum = 5 AND date_dropped = . THEN Output sncheckM_surv5;


RUN;


/*Survey 2: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

PROC SORT DATA = sncheckM_surv2;
	BY Final_ID;
RUN;

PROC SORT Data = Mentors1; 
	BY Final_ID;
RUN;
	

DATA sncheckM_surv2 survM_missing2;
	Merge sncheckM_surv2 Mentors1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID m2start;
		IF m2start = . Then OUtput survM_missing2;
		else If m2start ne . Then Output sncheckM_surv2;
RUN;



/*Survey 3: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

Proc SORT DATA = sncheckM_surv3;
	BY Final_ID;
RUN;

PROC SORT Data = Mentors1; 
	BY Final_ID;
RUN;
	

DATA sncheckM_surv3 survM_missing3;
	Merge sncheckM_surv3 Mentors1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID m3start;
		IF m3start = . Then OUtput survM_missing3;
		else If m3start ne . Then Output sncheckM_surv3;
RUN;

	

/*Survey 4: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/


Proc SORT DATA = sncheckM_surv4;
	BY Final_ID;
RUN;

PROC SORT Data = Mentors1; 
	BY Final_ID;
RUN;
	

DATA sncheckM_surv4 survM_Missing4;
	Merge sncheckM_surv4 Mentors1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID m4start;
		IF m4start = . Then OUtput survM_missing4;
		else If m4start ne . Then Output sncheckM_surv4;
RUN;



/*Survey 5: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

Proc SORT DATA = sncheckM_surv5;
	BY Final_ID;
RUN;

PROC SORT Data = Mentors1; 
	BY Final_ID;
RUN;
	

DATA sncheckM_surv5 survM_missing5;
	Merge sncheckM_surv5 Mentors1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID m5start;
		IF k5start = . Then OUtput survM_missing5;
		else If m5start ne . Then Output sncheckM_surv5;
RUN;

/*Merge ALL Missing surveys where Mentee did nto choose paired mentor*/

Data sncheckM_missing;
	Set survM_missing2 - survM_missing5;
RUN;



/*Merge all non missing surveys where Mentee did nto choose paired mentor*/

Data sncheckM_nomiss;
	SET sncheckM_surv2 - sncheckM_surv5;
RUN;
	
proc sort data = sncheckM_nomiss;
	BY sender_Final_ID;
RUN;


/*Check frequency of missing*/

proc freq data = sncheckM_missing;
	where m2start -- m5start = .;
	TABLES m2start -- m5start / missprint;
	label survnum = 'Frequency of mentors not choosing paired mentees because missing surveys';
RUN;


/**/

/*Check Frequency of Non-Missing*/

proc freq data = sncheckM_nomiss;
	TABLES survnum;
	label  survnum = 'Frequency of mentors not choosing paired mentees w/out missing surveys';
RUN;


/*Adding times the mentors missed the surveys*/

DATA El_mentors_Final;
	SET El_Mentors_Final;
	Final_ID = SUBSTR(Sender_Final_ID, 2, 10);
RUN;




DATA El_mentors_final;
	MERGE	El_mentors_Final Mentors1;
	BY FINAL_ID;

	Keep Sender_Final_ID -- sn2 m1start m2start m3start m4start m5start;


	run;

	
DATA El_mentors_final;
	Set El_Mentors_final;
		IF m1start = . THEN m1miss = 1;
		IF m2start = . THEN m2miss = 1;
		IF m3start = . THEN m3miss = 1;
		IF m4start = . THEN m4miss = 1;
		IF m5start = . THEN m5miss = 1;

		IF m1miss = . THEN m1miss = 0;
		IF m2miss = . THEN m2miss = 0;
		IF m3miss = . THEN m3miss = 0;
		IF m4miss = . THEN m4miss = 0;
		IF m5miss = . THEN m5miss = 0;

	DROP m1start -- m5start;
RUN;





/*/*/*/*/*Neil SHowing points that Mentees did not rate their Mentor pair/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/;


DATA El_mentees_odd;
	SET El_mentees_final;

	Mentor = FINDC(receiver_Final_ID, 'M', "i"); * "i" Finds the first letter regardless of case *;

/*CHANGE THESE DATES BASED ON WHEN SURVEYS WERE TAKEN: Keep DayMonYear format*/

	IF survnum=1 THEN survdate= '06Feb2017'd;
	IF survnum=2 THEN survdate= '20Feb2017'd;
	IF survnum=3 THEN survdate= '20Mar2017'd;
	IF survnum=4 THEN survdate= '10Apr2017'd;
	IF survnum=5 THEN survdate= '24Apr2017'd;



	FORMAT survdate MMDDYY.;
	
	RUN;



	
DATA Work.MasterY;
	Set Work.Master1;

	Sender_Final_ID	=	CAT('K', Final_ID); 

RUN;





	
/*Incorporating if Mentee Was Present during survey weeks. Will merge into the ODD file a few steps below -Neil*/
proc print data = weekly1;
	where FINAL_ID = "";
RUN;


DATA Work.WeeklyY; 
	Set Weekly1;

	Sender_Final_ID = CAT('K', Final_ID); 

	If	WEEK = 2	THEN DELETE;
		ELSE IF WEEK = 4	THEN DELETE;
		ELSE IF WEEK = 5	THEN DELETE;
		ELSE IF WEEK = 7	THEN DELETE;
		ELSE IF WEEK = 8	THEN DELETE;
		ELSE IF WEEK = 10	THEN DELETE;
		ELSE IF WEEK = 12	THEN DELETE;

	IF Week = 1 	THEN survnum = 1;
	IF Week = 3 	THEN survnum = 2;
	IF Week = 6 	THEN survnum = 3;
	IF Week = 9 	THEN survnum = 4;
	IF Week = 11 	THEN survnum = 5;



	Keep Sender_Final_ID  survnum present week;


RUN;



proc sort data = el_mentees_odd;
	BY Sender_Final_ID; 
	RUN;

proc sort data = MasterY;
	BY Sender_Final_ID; 
	RUN;


	
data el_mentees_odd2; 
  merge el_mentees_odd MasterY;
  by Sender_Final_ID;



	IF no_start = 1 THEN DELETE;
	IF date_Dropped ne .  AND date_dropped < survdate THEN DELETE;
	IF mentor = 0 THEN DELETE;



	DROP Final_ID; 
 RUN;


 
/*Adding in the weekly file to determine if Youth was present*/

Proc Sort data = WeeklyY;
	By Sender_FInal_ID survnum;
RUN;


Proc Sort data = El_mentees_odd2;
	By Sender_FInal_ID;
RUN;

DATA El_Mentees_odd2;
	merge el_mentees_odd2 WeeklyY;
	by Sender_final_ID survnum; 
	RUN;;



DATA el_mentees_odd2;

	SET el_mentees_odd2;

Mentee_ID = SUBSTR(Sender_Final_ID, 2, 10);
Mentor_ID = SUBSTR(Receiver_Final_ID, 2, 10);
RUN;



/*proc Print DATA = El_mentees_final_3;*/
/*	where date_dropped ne .;*/
/*RUN;*/


DATA Mentee_Send_Match;
	SET el_mentees_odd2;
	WHERE Mentor_ID = Mentee_ID;
	
RUN;

PROC SORT data = Mentee_Send_Match;
	BY SurvNum Sender_Final_ID;
RUN;

PROC PRINT DATA = Mentee_Send_Match;
	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;
/*	BY Survnum;*/
RUN;



PROC FREQ data = Mentee_Send_Match;
	TABLE survnum; 
	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;
/*	BY Survnum;*/
RUN;




/*survnum Frequency Percent Cumulative*/
/* Total After Survey 1 = 95


/*survey 2: 24  */
/*survey 3: 25  */
/*survey 4: 26  */
/*survey 5: 20 */



/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

Below Neil is seperating the cases where Mentee did Not choose the Mentor Because their survey is missing.

/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/;


/*DATA sncheckK_all;*/
/*	SET Mentee_Send_Match (Where=(Sn1 = . AND survnum ne 1 AND date_dropped = .));*/
/*		Final_ID = Mentee_ID;*/
/*RUN;*/
/**/

/*PROC FREQ data = sncheck_all;*/
/*	TABLE survnum; */
/*	Where Sn1 = . AND survnum ne 1 AND date_dropped = .;*/
/*	BY Survnum;*/
/*RUN;*/


/*Outputting cases where mentee did not choose mentor into seperate datafiles*/

Data	sncheckK_surv2
		sncheckK_surv3
		sncheckK_surv4
		sncheckK_surv5;

SET	Mentee_Send_Match;

	FINAL_ID = Mentee_ID;
	
	IF Sn1 = . AND survnum = 2 AND date_dropped = . THEN Output sncheckK_surv2;
	IF Sn1 = . AND survnum = 3 AND date_dropped = . THEN Output sncheckK_surv3;
	IF Sn1 = . AND survnum = 4 AND date_dropped = . THEN Output sncheckK_surv4;
	IF Sn1 = . AND survnum = 5 AND date_dropped = . THEN Output sncheckK_surv5;


RUN;







/*Survey 2: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

Proc SORT DATA = sncheckK_surv2;
	BY Final_ID;
RUN;

PROC SORT Data = Mentees1; 
	BY Final_ID;
RUN;
	

DATA sncheckK_surv2 survK_missing2;
	Merge sncheckK_surv2 Mentees1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID k2start;
		IF k2start = . Then OUtput survK_missing2;
		else If k2start ne . Then Output sncheckK_surv2;
RUN;
	

/*Survey 3: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

Proc SORT DATA = sncheckK_surv3;
	BY Final_ID;
RUN;

PROC SORT Data = Mentees1; 
	BY Final_ID;
RUN;
	

DATA sncheckK_surv3 survK_missing3;
	Merge sncheckK_surv3 Mentees1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID k3start;
		IF k3start = . Then OUtput survK_missing3;
		else If k3start ne . Then Output sncheckK_surv3;
RUN;


/*Survey 4: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/


Proc SORT DATA = sncheckK_surv4;
	BY Final_ID;
RUN;

PROC SORT Data = Mentees1; 
	BY Final_ID;
RUN;
	

DATA sncheckK_surv4 survK_Missing4;
	Merge sncheckK_surv4 Mentees1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID k4start;
		IF k4start = . Then OUtput survK_missing4;
		else If k4start ne . Then Output sncheckK_surv4;
RUN;




/*Survey 5: Outputting and seperating cases where Mentee never took survey vs. when mentee did NOT choose paired mentor*/

Proc SORT DATA = sncheckK_surv5;
	BY Final_ID;
RUN;

PROC SORT Data = Mentees1; 
	BY Final_ID;
RUN;
	

DATA sncheckK_surv5 survK_missing5;
	Merge sncheckK_surv5 Mentees1;
		BY	Final_ID;
		IF survnum = . THEN DELETE;
	KEEP	Sender_Final_ID Receiver_Final_ID survnum Final_ID k5start;
		IF k5start = . Then OUtput survK_missing5;
		else If k5start ne . Then Output sncheckK_surv5;
RUN;



/*Merge ALL Missing surveys where Mentee did nto choose paired mentor*/

Data sncheckK_missing;
	Set survK_missing2 - survK_missing5;
RUN;


/*Merge all non missing surveys where Mentee did nto choose paired mentor*/

Data sncheckK_nomiss;
	SET sncheckK_surv2 - sncheckK_surv5;
RUN;




proc sort data = sncheckK_nomiss;
	BY sender_Final_ID;
RUN;


/*Check frequency of missing*/

proc freq data = sncheckK_missing;
	TABLES survnum;
	label survnum = 'Frequency of mentees not choosing paired mentors because missing surveys';
RUN;


/*Check Frequency of Non-Missing*/

proc freq data = sncheckK_nomiss;
	TABLES survnum;
	label  survnum = 'Frequency of mentees not choosing paired mentors w/out missing surveys';
RUN;



/*Adding if they took the survey to Mentee edgelist*/

DATA El_mentees_Final;
	SET El_Mentees_Final;
	Final_ID = SUBSTR(Sender_Final_ID, 2, 10);
RUN;

proc sort data = El_mentees_Final;;
	BY FInal_ID;
RUN;


DATA El_mentees_final;
	MERGE	El_mentees_Final Mentees1;
	BY FINAL_ID;
	Keep Sender_Final_ID -- sn2 k1start k2start k3start k4start k5start;
	IF Sender_Final_ID = "" 	THEN DELETE;
	IF Receiver_Final_ID = "" 	THEN DELETE;
	run;

DATA El_mentees_final;
	Set El_Mentees_final;
		IF k1start = . THEN k1miss = 1;
		IF k2start = . THEN k2miss = 1;
		IF k3start = . THEN k3miss = 1;
		IF k4start = . THEN k4miss = 1;
		IF k5start = . THEN k5miss = 1;

		IF k1start ne . THEN k1miss = 0;
		IF k2start ne . THEN k2miss = 0;
		IF k3start ne . THEN k3miss = 0;
		IF k4start ne . THEN k4miss = 0;
		IF k5start ne . THEN k5miss = 0;

	DROP k1start -- k5start;
RUN;


proc print data = el_mentees_final;
	where Sender_Final_ID = "";
RUN;



/*/*/*/*/*/*/*/*/*/*/*/*/*/Neil Creating excel spreadsheet separated by day to show who to include in the Social network*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;

/*The imported file was copied from stacy's "R:\William T Grant\Fall 2015\Master Spreadsheets\StaffRoster_Fall2015 update.xlsx" 
	formatted to only include one night. Only mentor name and night I need to pull this in in order to get the days & mentor names together*/

proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\FINALDATA\OTHER_FILES\Staff_List.csv"
out=Staff_list dbms=csv replace; guessingrows=32767; getnames=yes;
run;



/*Staff and mentors were separated at one point. Putting them back together*/

DATA staff_mentor;
	SET ID_Staff
		IDM;
	KEEP	Mentor_name Final_ID;
RUN;


/*A couple were listed twice, I think because they serve multiple roles, 
Have to remove duplicates (If they are in multiple social networks this gets incorporated later with the merge)*/

Proc sort data = staff_mentor NODUPKEY;
	BY Mentor_Name;
	
RUN; 

Proc Sort data = Staff_List;
	BY Mentor_Name;
RUN;


/*Merge so we can get days, names, and FINAL_ID's in the same sheet*/

Data Staff_Mentor;
	Merge Staff_Mentor Staff_List;
	By	Mentor_Name;
RUN;




/*MENTORS/STAFF Merging FInal_ID & Night, and addign "M" Mentor indicator*/

proc sort data = staff_Mentor;
	BY Final_ID night;
Run;


PROC SORT data = Master1;
	BY Final_ID night;
Run;


DATA days_m;
	LENGTH Final_ID 	$11.;
 	FORMAT Final_ID 	$11.;
   	INFORMAT Final_ID 	$11.;
	SET Staff_mentor;
		Final_ID = CAT('M', Final_ID); 
	DROP mentor_name;
RUN;



/*MENTOR Separatign mentor nights out*/

proc sort data = days_m;
	by night;
RUN;

DATA	daym_mon
		daym_tue
		daym_wed
		daym_thu;
SET days_m; 
	If night = 			'monday'  	THEN output daym_mon;
	ELSE If night =  	'tuesday' 	THEN output daym_tue;
	ELSE If night =  	'wednesday' THEN output daym_wed;
	ELSE If night =  	'thursday' 	THEN output daym_thu;
RUN;



/*YOUTH Merging FInal_ID & Night, and addign "Y" Mentor indicator
NOTE: had to lower case night because there were differences in formatting.*/

proc sort data = IDk;
	BY Final_ID;
Run;

PROC SORT data = Master1;
	BY Final_ID night;
Run;


DATA days_k;
	MERGE	IDk Master1;
		BY Final_ID;
		Night1 = lowcase(NIGHT); 
	Keep Mentee_name Final_ID night1 no_start;
	IF No_start = 1 THEN Delete;
run;

DATA days_k;
	LENGTH Final_ID 	$11.;
 	FORMAT Final_ID 	$11.;
   	INFORMAT Final_ID 	$11.;
	SET days_k;
		Final_ID = CAT('K', Final_ID);
		Night = Night1; 
	DROP mentee_name No_Start Night1; 
RUN;


/*Separatign youth nights out*/

DATA	dayk_mon
		dayk_tue
		dayk_wed
		dayk_thu;
SET Days_k; 
	If night = 	'monday'  	THEN output dayk_mon;
	If night =  'tuesday' 	THEN output dayk_tue;
	If night =  'wednesday' THEN output dayk_wed;
	If night =  'thursday' 	THEN output dayk_thu;
RUN;


/*Combining Youth and Mentor Monday*/

DATA day_mon;
	Set daym_mon dayk_mon;
	RENAME Final_ID = Monday;
	DROP NIGHT;
RUN;











*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*NEIL SETTING UP FALL EDGELIST FOR STATS DEPT*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;

/*SETTING UP Instances where Survey was not taken by week MENTEES*/

DATA EL_mentee_final_stat;
	Set EL_mentees_final;
If K1miss = 1 & survnum = 1 THEN Sender_missing = 1 ;
IF K2miss = 1 & survnum = 2 THEN Sender_missing = 1 ;
IF K3miss = 1 & survnum = 3 THEN Sender_missing = 1 ;
If K4miss = 1 & survnum = 4 THEN Sender_missing = 1 ;
If K5miss = 1 & survnum = 5 THEN Sender_missing = 1 ;
	IF Sender_missing = . THEN Sender_Missing = 0;

/*Need to add this because there is a non-consenting youth's namein the */
	IF Sender_Final_ID = "" THEN DELETE;

DROP k1miss -- k5miss;

RUN;



/*Adding Semester S17*/
DATA EL_mentee_final_stat;
	semester = "S17";
	SET EL_mentee_final_stat;
RUN;

/*Looking for instance of missing photos*/
proc print data = Snmatch;
	where weight_mentee_1 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentee_3 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentee_6 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentee_9 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentee_11 = "";
	RUN;


/*proc print data = NAMEcheck;*/
/*	where receiver_mentee = "kXksn1d_33";*/
/*	VAR FINAL_ID receiver_mentee;*/
/*RUN;*/


DATA EL_mentee_final_stat;
	SET EL_mentee_final_stat;


/*Surv 1 missing*/
IF Receiver_Final_ID = "KCCS17_4731" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4279" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4816" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4535" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4742" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4035" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4141" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4098" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4053" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4397" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4653" & survnum = 1 THEN Receiver_Missing = 1;




/*Surv 2 Missing*/

IF Receiver_Final_ID = "KCCS17_4653" & survnum = 2 THEN Receiver_Missing = 1;





/*None for FAll '17*/

/*Surv 3 Missing*/

/*None for Fall '17*/

/*Surv 4 Missing*/

/*None for Fall '17/

/*Surv 5 Missing*/

/*None for Fal '17*/


IF Receiver_Missing = . THEN Receiver_Missing = 0;
RUN;



proc freq data = EL_mentee_final_stat;
	TABLES Receiver_Missing;
RUN;



/*SETTING UP Instances where Survey was not taken by week MENTORS*/

DATA EL_staff_final_stat;
	Set EL_mentors_final;
If M1miss = 1 & survnum = 1 THEN Sender_missing = 1 ;
IF M2miss = 1 & survnum = 2 THEN Sender_missing = 1 ;
IF M3miss = 1 & survnum = 3 THEN Sender_missing = 1 ;
If M4miss = 1 & survnum = 4 THEN Sender_missing = 1 ;
If M5miss = 1 & survnum = 5 THEN Sender_missing = 1 ;
	IF Sender_missing = . THEN Sender_Missing = 0;

DROP M1miss -- M5miss;

RUN;



/*Neil Checkign to make sure non-consenting mentor not included*/
/*PROC Print data = EL_staff_final_stat;*/
/*	WHERE Sender_Final_ID = "MCCS16_2899";*/
/*RUN;*/

proc sort data = ID_pair;
	BY FInal_ID;
RUN;

/*Adding Semester S16*/
DATA EL_staff_final_stat;
	semester = "S17";
	SET EL_staff_final_stat;
RUN;


/*Checking for Mentor Missing */

proc print data = Snmatch;
	where weight_mentor_1 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentor_3 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentor_6 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentor_9 = "";
	RUN;

proc print data = Snmatch;
	where weight_mentor_11 = "";
	RUN;



/*Addign indicator of Missing Receiver photos*/

DATA EL_staff_final_stat;
	SET EL_staff_final_stat;


/*Surv 1 missing*/
IF Receiver_Final_ID = "KCCS17_4731" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4279" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4816" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4535" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4742" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4035" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4141" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4801" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4098" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4053" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4397" & survnum = 1 THEN Receiver_Missing = 1;
IF Receiver_Final_ID = "KCCS17_4653" & survnum = 1 THEN Receiver_Missing = 1;



/*Surv 2 Missing*/

IF Receiver_Final_ID = "KCCS17_4653" & survnum = 2 THEN Receiver_Missing = 1;




/*Surv 3 Missing*/

/*None for Spring '17*/

/*Surv 4 Missing*/

/*None for Spring '17*/

/*Surv 5 Missing*/

/*None for Spring '17*/


IF Receiver_Missing = . THEN Receiver_Missing = 0;
IF Receiver_FInal_ID = "K" THEN DELETE;
RUN;



proc print data = EL_staff_final_stat;
	where receiver_missing = 1 & sn1 ne .;
	RUN;

proc print data = EL_mentee_final_stat;
	where receiver_missing = 1 & sn1 ne .;
	RUN;


proc sort data = EL_staff_final_stat;
	BY survnum;
RUN;

proc freq data =  EL_staff_final_stat;
	BY survnum;
TABLES receiver_missing;
	RUN; 




proc sort data = EL_mentee_final_stat;
	BY survnum;
RUN;

proc freq data =  EL_mentee_final_stat;
	BY survnum;
TABLES receiver_missing;
	RUN; 


proc print data = EL_staff_final_stat;
	where receiver_final_ID = "MCCS17_4078" & night = "thursday";
	RUN;

/*Settign up Attributes file for Stats DEPT*/
/*MENTEES*/

DATA Attributes_Mentee; 
	Role =	"mentee";
	SET MASTERy;
/*IF No_Start = 1 THEN Delete;*/
KEEP 	Final_ID
		Sender_Final_ID
		Night
		mfcond
		Role
		room
		no_start
		mentee_male
		impnotes;
Run;

Proc Sort data = Attributes_Mentee;
	BY Final_ID;
RUN;

Proc Sort data = Master1;
	BY Final_ID;
RUN;



DATA Attributes_Mentee; 
	Merge Attributes_Mentee Master1;
	By Final_ID;



KEEP
		Sender_Final_ID
		Night
		mfcond
		Role
		room
		no_start
		mentee_male
		impnotes
		date_dropped;
	IF Role = "" THEN DELETE;
RUN;




DATA Attributes_Mentee;
	Semester = "S17";
	Set Attributes_Mentee(rename=(Sender_Final_ID=Final_ID));
RUN;


DATA Attributes_Mentee;
	RETAIN
		Final_ID
		Semester
		Night
		mfcond
		Role
		room
		no_start
		mentee_male
		date_dropped
		impnotes
		;
	SET Attributes_mentee;
RUN;



/*Settign up Attributes file for Stats DEPT*/
/*MENTORS*/

/*The following imported file contains important information on the staff menotrs including Night(s), role, impnotes, & role*/

proc import datafile="T:\Research folders\CCWTG\Data\Spring2017\S17 Staff_AND_ACNS.csv"
out=staffroster_update dbms=csv replace; guessingrows=32767; getnames=yes;
run;


/*DATA staffroster_update;*/
/*	SET staffroster_update;*/
/*		KEEP Student_ID -- NOTES___OK_TO_DELETE;*/
/*		DROP Night3;*/
/*RUN;*/



DATA staffroster_update;
	SET staffroster_update;
	night1_temp = LOWCASE(night1);
	night2_temp = LOWCASE(night2);
	Drop Night1 Night2;


RUN;




DATA staffroster_update;
	SET staffroster_update(rename=(night1_temp = night1 
									night2_temp = night2
									Name = mentor_name));

*******************************************************************************;

RUN;



Proc Sort data = IDm;
	By mentor_name;
	RUN;

	Proc Sort data = staffroster_update;
	By mentor_name;
	RUN;

DATA Attributes_Mentor;
	Merge	IDm staffroster_update /*(rename=(name=mentor_name))*/; 
	BY mentor_name;
RUN;



Proc Sort Data = Attributes_mentor; 
	BY Final_ID;
RUN;

Proc Sort Data = Masterm; 
	BY Final_ID;
RUN;


DATA Attributes_Mentor;
	Merge Attributes_Mentor MasterM;
	BY FInal_ID; 
RUN;



/*assignign mfcond nights. input correct nights in the corect places. mfcond = 0 IS MF night 1= control*/
DATA Attributes_Mentor;
	SET Attributes_Mentor;
	Sender_Final_ID = CAT('M', Final_ID); 
	IF type = "no_mentor" THEN DELETE;
	IF night1 = "monday" OR night1 = "thursday" THEN mfcond = 0;
	IF night1 = "tuesday" OR night1 = "wednesday" THEN mfcond = 1;
	IF Final_ID = "" THEN DELETE;

/*impnotes don't have any information in this case*/
DROP impnotes;

RUN;



DATA Attributes_Mentor;

	
	semester = "S17";
	SET Attributes_Mentor (rename=(NOTES = impnotes));
KEEP	Final_ID
		Sender_FInal_ID
		night1
		night2
		mfcond
		role1
		role2
		room
		impnotes
		;
RUN;




proc sort data = Mentors1;
	BY Final_ID;
RUN;

proc sort data = Attributes_Mentor;
	BY Final_ID;
RUN;



DATA Attributes_Mentor;
	Merge Attributes_Mentor Mentors1;
	BY Final_ID;

KEEP	Final_ID
		Sender_FInal_ID
		night1
		night2
		mfcond
		role1
		role2
		room
		m0gender
		impnotes
		;

RUN;




PROC SORT DATA = ID_Staff;
	BY FInal_ID;
RUN;

PROC SORT DATA = Attributes_Mentor;
	BY FInal_ID;
RUN;

DATA Attributes_Mentor;
	MERGE Attributes_Mentor ID_Staff;
	BY Final_ID;

	IF type = "no_mentee" THEN mentee = 0;
	IF type = "" THEN mentee = 1;


KEEP 	
		Sender_Final_ID
		night1
		night2
		mfcond
		role1
		role2
		room
		m0gender
		impnotes
		mentee
		;
RUN;



DATA Attributes_Mentor;
	Semester = "S17";
	Set Attributes_Mentor(rename=(Sender_Final_ID=Final_ID
									m0gender = gender));

RUN;

DATA Attributes_Mentor;
	RETAIN Final_ID 
			Semester
			night1
		night2
		mfcond
		role1
		role2
		room
		gender
		mentee
		impnotes;
	Set Attributes_Mentor;
RUN;


/*Stacking the Kid and staff edgelists*/

DATA EL_STAT_FINAL;
	SET 
		EL_staff_final_Stat
		EL_mentee_final_Stat;
RUN;




DATA EL_STAT_FINAL;
	SET EL_Stat_FInal;
IF receiver_FInal_ID = "" THEN DELETE;
RUN;

/*2 phoros of mentees that should not be included (dropped before program start)*/

DATA EL_STAT_FINAL;
	SET EL_STAT_FINAL; 
	If Receiver_Final_ID = "KCCS17_4957" THEN DELETE;
	If Receiver_Final_ID = "KCCS17_4045" THEN DELETE;

/*4 instances that need to be removed:

1.) KCCS17_4731 - need to remove from thursday network completely they are available in monday network.
	KCCS17_4801 - need to remove from wednesday network completely they are available in wednesday network
	MCCS17_4708 - Need to remove from thursday network because they ended up dropping that night they are available on monday network

Both switched nights right before program start and were only included */

	If Receiver_Final_ID = "KCCS17_4731" & Night = "wednesday" THEN DELETE;
	If Receiver_Final_ID = "KCCS17_4801" & Night = "wednesday" THEN DELETE;
	If Receiver_Final_ID = "MCCS17_4078" & Night = "thursday" THEN DELETE;
	IF receiver_FINAL_ID = "M" THEN DELETE;
RUN;

proc sort data = EL_STAT_FINAL;
	BY survnum;
RUN;

proc freq data = EL_STAT_FINAL;
	BY survnum;
TABLES receiver_missing;
	RUN;


proc print data = EL_STAT_FINAL;
		WHERE sender_missing = 1 & sn1 ne .;
RUN;

proc print data = EL_STAT_FINAL;
	where receiver_FINAL_ID = "M";
	RUN;


Proc Print data = EL_STAT_FINAL;
	where receiver_Final_ID = "MCCS17_4078";
RUN;

Proc Print data = EL_STAT_FINAL;
	where sender_Final_ID = "KCCS17_4045";
RUN;


/*/**/
/*PROC EXPORT DATA=EL_STAT_FINAL*/
/*   OUTFILE="T:\Research folders\CCWTG\Analyses\Data for Stats Dept\Data for merge\S17_EL_forStats.csv"*/
/*   DBMS=CSV REPLACE;*/
/*   PUTNAMES= YES;*/
/*RUN;*/
/**/
/*PROC EXPORT DATA=Attributes_mentee*/
/*   OUTFILE="T:\Research folders\CCWTG\Analyses\Data for Stats Dept\Data for merge\S17_MenteeAttributes_forStats.csv"*/
/*   DBMS=CSV REPLACE;*/
/*   PUTNAMES= YES;*/
/*RUN;*/
/**/;*/
/*PROC EXPORT DATA=Attributes_mentor*/
/*   OUTFILE="T:\Research folders\CCWTG\Analyses\Data for Stats Dept\Data for merge\S17_StaffAttributes_forStats.csv"*/
/*   DBMS=CSV REPLACE;*/
/*   PUTNAMES= YES;*/
/*RUN;*/
;



proc print data = attributes_mentor;
	where FINAL_ID = "MCCS17_4078";
RUN;


proc print data = attributes_mentor;
	where FINAL_ID = "MCCS17_4078";
RUN;


