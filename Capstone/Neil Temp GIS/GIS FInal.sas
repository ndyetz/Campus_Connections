libname bike "C:\Users\HenryRA\Desktop";

proc datasets lib=work memtype=data nolist kill; run;

/*MASTER RECORDS************************************************************************************/
proc import datafile="C:\Users\HenryRA\Desktop\Bike_Count.csv"
out=bike dbms=csv replace; guessingrows=32767; getnames=yes;
run;


DATA Bike;
	SET BIKE;
	Day_tot = SUM(of Hr00 - HR23);
	RUN;

Proc Freq data = BIKE;
	TABLES County*DAY_Tot;
RUN;

PROC Freq data = BIKE;
	TABLES County;
	RUN;

Proc Sort data = BIKE;
	BY County;
RUN;

PROC Means data = BIKE
	N MEAN STD MEDIAN SUM MIN MAX;
	VAR Day_Tot;
	BY COUNTY;
	OUTPUT OUT = Bike_Means N(Day_Tot)= 
							MEAN(Day_Tot)= 
							STD (Day_Tot)= 
							MEDIAN (Day_Tot)=  
							SUM (Day_Tot)= 
							MIN (Day_Tot)= 
							MAX(Day_Tot)=  / AUTONAME;
RUN; 


PROC EXPORT DATA=Bike_Means
   OUTFILE="C:\Users\HenryRA\Desktop\Bike_Means.csv"
   DBMS=CSV REPLACE;
   PUTNAMES= YES;
RUN;


/**/
/*PROC TRANSPOSE DATA=Bike_Means OUT=Bike_Trans;*/
/*    BY County;*/
/*/*    COPY _Freq_;*/*/
/*    ID _STAT_;*/
/*    VAR Day_Tot;*/
/*RUN;*/
/**/
/*Proc Print data = BIKE;*/
/*	Where Day_tot = 1598;*/
/*	VAR County Day_Tot;*/
/*	RUN;*/
/**/
/*DATA Bike*/
/*		Denver;*/
/*	SET Bike;*/
/*	IF COunty = 'Denver' THEN OUTPUT DENVER;*/
/*RUN;*/
/**/
/*PROC SORT DATA = BIKE;*/
/*	BY County;*/
/*RUN;*/
/**/
/*PROC UNIVARIATE Data = BIKE;*/
/*	VAR DAY_Tot;*/
/*	BY County;*/
/*	OUTPUT OUT = Bike_UNI;*/
/*RUN;*/
