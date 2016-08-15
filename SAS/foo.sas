/* ca_drive_time_google.sas – Mike Zdeb (4-29-11) */

*  modified by N Maizlish 5-5-11;
* Calculates time minimized shortest distance between x-y;
* coordinates from BATS 2000 travel survey of trip segments;
* Missing and 0 x-y coordinates have been filtered out;

* You must indicate the number of records N in the input file;
* %do j=1 %to N;
* You must alter the surveyselect statement to indicate the input file;
* Creates a SAS output dataset named "google_distance.sas7bdat";

* you must change the mode in the use macro %distance_time(type);
* (b)= bicycle (w) walk no parentheses is car;

* Select the input directory;
* test: libname z 'H:\ClimateChange\TravelSurveys\BATS2000\BATS2000Data\GoogleMaps';

libname z 'H:\ClimateChange\TravelSurveys\BATS2000\BATS2000Data\Version2';

************************ take a random sample of points;
* Select same random sample based on seed=5511;
* Bicycle;
* proc surveyselect data=z.xy_coordinates_bicycle out=xy_coordinates sampsize=3056 seed=5511;
* Walk;
* proc surveyselect data=z.xy_coordinates_walk out=xy_coordinates sampsize=2461 seed=5511;
* Car - Driver;
* proc surveyselect data=z.xy_coordinates_cardriver out=xy_coordinates sampsize=2992 seed=5511;
* Car - Passenger;
* proc surveyselect data=z.xy_coordinates_carpassenger out=xy_coordinates sampsize=2449 seed=5511;
* Bus taxi;
* proc surveyselect data=z.xy_coordinates_bustaxi out=xy_coordinates sampsize=2848 seed=5511;
* Rail;
proc surveyselect data=z.xy_coordinates_rail out=xy_coordinates sampsize=2276 seed=5511;

run;



proc contents data=xy_coordinates;
run;

* create a macro that contains a loop to access Google Maps multiple time;

%macro distance_time(type);

* delete any data set named DISTANCE_TIME that might exist in the WORK library;
proc datasets lib=work nolist;
delete distance_time;
quit;

********************* Change the loop counter to max number of records;
%do j=1 %to 2276;
data _null_;
nrec = &j;

* Select the input data set;
set xy_coordinates point=nrec;

* Test;
* set z.ca_test point=nrec;

call symputx('ll1',catx(',', orglati_num ,orglong_num ));
call symputx('ll2',catx(',', deslati_num ,deslong_num ));
stop;
run;

filename x url "http://maps.google.com/maps?daddr=&ll2.%nrstr(&saddr)=&ll1%nrstr(&dirflg)=&type";
filename z temp;

* same technique used in the example with a pair of lat/long coordinates;
data _null_;
infile x recfm=f lrecl=1 end=eof;
file z recfm=f lrecl=1;
input @1 x $char1.;
put @1 x $char1.;
if eof;
call symputx('filesize',_n_);
run;

* drive time as a numeric variable;
data temp;
infile z recfm=f lrecl=&filesize. eof=done;
input @ "distance:'" @;
input text $50.;
distance_google = input(scan(text,1,"' "),comma12.);
units    = scan(text,2,"' ");
text     = scan(text,3,"'");
* convert times to seconds;
  select;
* combine days and hours;
   when (find(text,'day') ne 0)  time = 86400*input(scan(text,1,' '),best.) +
                                        3600*input(scan(text,3,' '),best.);
* combine hours and minutes;
   when (find(text,'hour') ne 0) time = 3600*input(scan(text,1,' '),best.) +
                                        60*input(scan(text,3,' '),best.);
* just minutes;
   otherwise                     time = 60*input(scan(text,1,' '),best.);
  end;
output;
keep distance_google time;
stop;
done:
output;
run;

filename x clear;
filename z clear;

* add an observation to the data set DISTANCE_TIME;
proc append base=distance_time data=temp;
run;
%end;
%mend;

* use the macro;
* Asterisk out the mode you want;
* Walk;
* %distance_time(w);
* Car, bus, taxi, rail;
%distance_time;
* Bike;
* %distance_time(b);

*
add variables from original data set to new data set distance_time
use geodist function to calculate straight line distance
;
data distance_time;
  set distance_time;

* Set the input data set;
set xy_coordinates point=_n_;

* Test;
* set z.ca_test point= _n_;
run;

* Print out a file, if you want;
* proc print data=distance_time noobs;
* var day personid_n distance distance_google time org: des: ;
* var person_id distance_google time org: des: ;
* format time time6. ;
* run;

* Create a SAS output data set;
* Output file can then be used to calculate weekly and annual;
* miles traveled by mode using best route distances;

* Change erroneous Google Maps distances in feet to miles (>100 mph);
* based on speed;
data distance_time;
  set distance_time;
  speed = 3600*distance_google/time;
if speed > 100 then distance_google = distance_google/5280;
run;

* Change the file name in Windows after running to reflect type of mode;
data z.google_distance;
   set distance_time;
run;

proc contents;
run;
