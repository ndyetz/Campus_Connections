**** MAS composite score of Substance use (delinquency scale);

/* Below is the set-up and analyses for a project with Gereon. The purpose of this study is to understand the relationship between Mentorship Relationship Quality (MRQ) and */
														/*		substance use in CC mentees.


PLEASE EMAIL NEIL YETZ at: neil.yetz@colostate.edu with questions*/



libname ALL "R:\William T Grant\SharedData";

proc datasets lib=work memtype=data nolist kill; run;



proc import datafile="R:\William T Grant\SharedData\MENTEESURVEY.csv" 
out=youth dbms=csv replace; guessingrows=32767; getnames=yes;
run;

/*/*Setting dataset*/*/
/**/
/*DATA youth; /*SET ALL.MENTEESURVEY;*/
/*RUN;*/
/*/*Keeping only youth varibles*/*/
/**/
/*DATA youth;*/
/*	SET all;*/
/*	KEEP Final_ID k0start -- kage1;*/
/*RUN;*/


/*Looking at substance use variables*/;

proc univariate data = youth;
	VAR k0dlq_4 k0dlq_5 k0dlq_6 k0dlq_7;
	HISTOGRAM k0dlq_4 k0dlq_5 k0dlq_6 k0dlq_7;
RUN;
/*All histograms show very skewed data*/

/*Creating composite substance use score

This is the mean score of 4 items on the delinquency scale:


On how many DAYS in the LAST MONTH have the following things happened?
Scale Choices: Slider ranging from 0 (0 days) to 30 (30 days)

kXdlq_4	I drank alcohol.
kXdlq_5	I got drunk.
kXdlq_6	I used marijuana.
kXdlq_7	I smoked cigarettes or chewed tobacco.


NOTE: kXldq_7 has a lwo alpha with the delinquency scale (however this is associated with all the items, not just the substanvce Use items.

*/

DATA Youth;
	SET Youth;
	k0sub_total = MEAN(of k0dlq_4 - k0dlq_7);
RUN;

/*Viewing composite substance use descriptives*/


proc univariate data = YOUth;
VAR k0sub_total; 
HISTOGRAM k0sub_total;
RUN;
	
/*HISTOGRAM SHOWS SKEWNNESS. We may need to run a logistic regression procedures*/


/*setting up to look at only tose that participate in substance use*/

proc univariate data = Youth;
	where k0sub_total > 0;
	VAR k0sub_total;
	HISTOGRAM k0sub_total;
RUN;


/*	Dichotomizing variables*/


DATA Youth;
	SET YOUTH;
		IF k0sub_total = 0 THEN k0sub_dic = 0;
		IF k0sub_total ne 0 THEN k0sub_dic = 1;
RUN;

/*Looking at dichotmized variable*/
proc univariate data = Youth;
	VAR k0sub_dic;
	HISTOGRAM k0sub_dic;
RUN;



/*/*/*/*/*/*/SETTING UP FOR Post intervention*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/**/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
;

proc univariate data = youth;
	VAR k5dlq_4 k5dlq_5 k5dlq_6 k5dlq_7;
	HISTOGRAM k5dlq_4 k5dlq_5 k5dlq_6 k5dlq_7;
RUN;
/*All histograms show very skewed data*/

/*Creating composite substance use score*/
DATA Youth;
	SET Youth;
	k5sub_total = MEAN(of k5dlq_4 - k5dlq_7);
RUN;

/*Viewing composite substance use descriptives*/

proc univariate data = YOUth;
VAR k5sub_total; 
HISTOGRAM k5sub_total;
RUN;


/*	Dichotomizing variables*/


DATA Youth;
	SET YOUTH;
		IF k5sub_total = 0 THEN k5sub_dic = 0;
		IF k5sub_total ne 0 THEN k5sub_dic = 1;
RUN;

/*Looking at dichotmized variable*/
proc univariate data = Youth;
	VAR k0sub_dic k5sub_dic;
	HISTOGRAM k0sub_dic k5sub_dic;
RUN;

/*Mentorship quality - We are using the mentor alliance scale*/

/*



Instrument Citation
Adapted from: Cavell, T.A., Elledge, L.C.,, Malcolm, K.T., Faith, M.A. and Hughes, J.M. (2009). Relationship Quality and the Mentoring of Aggressive, High-Risk Children. Journal of Clinical Child & Adolescent Psychology, 38(2), 185-198.

Description of Instrument
The instrument is available at week 6 (k3) and week 11 (k5).

List of Items in Instrument
The next set of questions are about your relationship with your mentor. How often do you experience the following:
Scale Anchors: Never=1, Hardly Ever=2, Sometimes=3, Usually=4, Always=5
Variable 	Description
kXmas_1 	I look forward to meeting with my mentor.
kXmas_2 	I tell my mentor about things that upset me.
kXmas_3R 	When I知 with my mentor, I want the time to go quickly.
kXmas_4 	When I知 with my mentor, I bring up things that bother me.
kXmas_5 	I like spending time with my mentor.
kXmas_6R 	When I知 with my mentor, I keep my problems to myself.
kXmas_7 	I like my mentor.
kXmas_8 	When my mentor asks about my problems, I talk about them.
kXmas_9R 	I壇 rather do other things than meet with my mentor.
kXmas_10 	I feel like my mentor is on my side and tries to help me.
kXmas_11 	I talk to my mentor about my feelings.
kXmas_12R 	I wish my mentor would leave me alone.
kXmas_13R 	When I知 with my mentor, I feel ignored.
kXmas_14R 	When I知 with my mentor, I feel mad.
kXmas_15R 	When I知 with my mentor, I feel disappointed.
kXmas_16R 	When I知 with my mentor, I feel bored.

Psychometrics

Cronbach痴 Alpha: Week 6 (0.84), Week 11 (0.86)


*/

/*create mentor alliance scale*/

/*Reverse Score*/

/*Week 6 (surv 3)*/
DATA Youth;
	SET Youth;
k3mas_3R  = 6-k3mas_3;
k3mas_6R  =	6-k3mas_6;
k3mas_9R  =	6-k3mas_9;
k3mas_12R =	6-k3mas_12;
k3mas_13R =	6-k3mas_13;
k3mas_14R =	6-k3mas_14;
k3mas_15R =	6-k3mas_15;
k3mas_16R =	6-k3mas_16;
RUN;


/*Week 11 (surv 5)*/
DATA Youth;
	SET Youth;
k5mas_3R  = 6-k5mas_3;
k5mas_6R  =	6-k5mas_6;
k5mas_9R  =	6-k5mas_9;
k5mas_12R =	6-k5mas_12;
k5mas_13R =	6-k5mas_13;
k5mas_14R =	6-k5mas_14;
k5mas_15R =	6-k5mas_15;
k5mas_16R =	6-k5mas_16;
RUN;

/*Take average composite score*/

DATA Youth;
	SET Youth;
	k3mas = MEAN(of 

k3mas_1 	,
k3mas_2 	,
k3mas_3R 	,
k3mas_4 	,	
k3mas_5 	,	
k3mas_6R 	,
k3mas_7 	,	
k3mas_8 	,	
k3mas_9R	,
k3mas_10	,
k3mas_11	,
k3mas_12R	,
k3mas_13R	,
k3mas_14R	,
k3mas_15R	,
k3mas_16R)	;
RUN;




DATA Youth;
	SET Youth;
	k5mas = MEAN(of 

k5mas_1 	,
k5mas_2 	,
k5mas_3R 	,
k5mas_4 	,	
k5mas_5 	,	
k5mas_6R 	,
k5mas_7 	,	
k5mas_8 	,	
k5mas_9R	,
k5mas_10	,
k5mas_11	,
k5mas_12R	,
k5mas_13R	,
k5mas_14R	,
k5mas_15R	,
k5mas_16R)	;
RUN;


/*Remove missing surveys*/

DATA Youth;
	SET YOUTH;
	IF  k5sub_dic = . THEN DELETE;
	IF k5mas = . THEN DELETE;
RUN;



/*Basic Logistic Model 1
	post_sub_use (yes/no) = Bo + BxMAS (survey 5; scale 0-5) + BxPre_sub_use (yes/no)*/


/*   ODS TAGSETS.EXCELXP*/
/*file='T:\Research folders\CCWTG\Analyses\Papers\Gereon MRQP SU\substance_reg.xls'*/
/*STYLE=minimal*/
/*OPTIONS ( Orientation = 'landscape'*/
/*FitToPage = 'yes'*/
/*Pages_FitWidth = '1'*/
/*Pages_FitHeight = '100' );*/

PROC LOGISTIC DESCENDING DATA = Youth;
	model k5sub_dic =  k5mas  k0sub_dic /scale=n aggregate lackfit;
	output out=pdat p=pihat;
RUN;

/*ods tagsets.excelxp close;*/


/*Plotting the pihats*/
title1 'probability of substance use as Mentor Alliance increases';
axis1 minor=none label=(f=swiss h=2.5 'Mentor Alliance at Timepoint 5'); 
axis2 minor=none label=(f=swiss h=2.5 a=90 'Substance use at timepoint 5'); 
goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; 
symbol1 c=black v=dot; 
symbol2 c=black v=circle; 
symbol3 c=black v=star h=2;

proc gplot data=Pdat; 
plot (k5sub_dic pihat)*k5mas/overlay haxis=axis1 vaxis=axis2; 
run; quit;

/*COOL TREND!*/





																		/*END PROGRAM */

/**/
/**/
/*/*Basic Logistic Model 1*/
/*	post_sub_use (yes/no) = Bo + BxMAS (survey 3; scale 0-5) + BxPre_sub_use (yes/no)*/*/
/**/
/**/
/*PROC LOGISTIC DESCENDING DATA = Youth;*/
/*	model k5sub_dic =  k3mas  k0sub_dic /scale=n aggregate lackfit;*/
/*	output out=pdat p=pihat;*/
/*RUN;*/
/**/
/**/
/*/*Plotting the pihats*/*/
/**/
/*axis1 minor=none label=(f=swiss h=2.5 'MAS_3'); */
/*axis2 minor=none label=(f=swiss h=2.5 a=90 'Sub_use'); */
/*goptions FTEXT=swissb HTEXT=2.0 HSIZE=6 in VSIZE=6 in; */
/*symbol1 c=black v=dot; */
/*symbol2 c=black v=circle; */
/*symbol3 c=black v=star h=2;*/
/**/
/*proc gplot data=Pdat; */
/*plot (k5sub_dic pihat)*k3mas/overlay haxis=axis1 vaxis=axis2; */
/*run; /*quit;*/

/*COOL TREND!*/;







