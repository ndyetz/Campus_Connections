/*This code creates interview groups based on quartile scores on the mentor alliance scale and Beloningness scale scores*/

libname int "T:\Research folders\CCWTG\Analyses\INTERVIEW";


proc import datafile="T:\Research folders\CCWTG\Analyses\INTERVIEW\INTERVIEW_S18.csv" 
out=mydata  dbms=csv replace;
   guessingrows=32767; getnames=yes;
run;



proc means; run;

data intS18; set mydata;


if k3night='M' then night='monday';
else if k3night='T' then night='tuesday';
else if k3night='W' then night='wednesday';
else if k3night='Th' then night='thursday';

if n (of k3blng_1-k3blng_5) ge 4 then k3blng=mean (of k3blng_1-k3blng_5); 

array revvar k3mas_3 k3mas_6 k3mas_9 k3mas_12 k3mas_13-k3mas_16;
do over revvar; revvar=6-revvar; end;

if n (of k3mas_1-k3mas_16) ge 14 then k3mas=mean(of k3mas_1-k3mas_16);
run;

proc corr alpha nomiss; var k3blng_1-k3blng_5; run;
proc corr alpha nomiss; var k3mas_1-k3mas_16; run;

proc rank
     groups=4
     out=quart;
var k3blng k3mas;
ranks k3blng_q k3mas_q;
run;

proc freq data=quart; tables k3blng_q*k3mas_q; run;


/*Neil Importing names and merging to quart
	NOTE: I had to manipulate stacy's original file to make S17 Staff_AND_ACNS.csv to make this work. 
			Change "Name (Aires)" -> to "Name" 
			AND Change "Alias Email to "Email"*/

proc import datafile="T:\Research folders\CCWTG\Data\Spring2018\S18 Staff_AND_ACNS.csv"
out=names dbms=csv replace;
   guessingrows=32767; getnames=yes;
run;

proc sort data = quart;
	by Recipientemail;
RUN;


proc sort data = names;
	by email;
RUN;


DATA quart;
	merge names quart (rename=(RecipientEmail= Email));
	By email;
RUN;
/*End Neil*/


data Quart;
	set quart;
RUN;


proc freq; tables k3blng_q k3mas_q; run;

proc means; class night; var k3blng k3mas; run;

proc freq; tables k3blng_q*k3mas_q; run;
proc corr; var k3blng k3mas; run;
proc print; title "Group 1: Low Belonging - Low Mentor Alliance"; where k3blng_q=0 and k3mas_q=0; var Name night1 night2 k3blng k3mas; run;
proc print;  title "Group 2: High belonging - High Mentor Alliance"; where k3blng_q=3 and k3mas_q=3; var Name night1 night2 k3blng k3mas; run;
proc print; title "Group 3: High Belonging - Low Mentor Alliance"; where k3blng_q=3 and k3mas_q=0; var Name night1 night2 k3blng k3mas; run;
proc print; title "Group 4: Low Belonging - High Mentor Alliance"; where k3blng_q=0 and k3mas_q=3; var Name night1 night2 k3blng k3mas; run;

/*Group 4 Print for F17 ONLY*/
/*proc print; title "Group 4: Low Belonging - High Mentor Alliance"; where ( k3mas_q=3 and k3blng_q=1)  or (k3blng_q=0 and k3mas_q = 2); var /*Name night1 night2 k3blng k3mas*/ k3mas_q k3blng_q; run;*/

