capture log close
log using cpsfeb98.log, replace
set mem 500m

/*------------------------------------------------
  by Jean Roth Wed Nov  4 16:52:58 EST 2009
  Please report errors to jroth@nber.org
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http://www.gnu.org/licenses/ for details.
  Run with do cpsfeb98
----------------------------------------------- */

/* The following line should contain
   the complete path and name of the raw data file.
   On a PC, use backslashes in paths as in C:\  */

local dat_name "/homes/data/cps/cpsfeb98.dat"

/* The following line should contain the path to your output '.dta' file */

local dta_name "cpsfeb1998.dta"

/* The following line should contain the path to the data dictionary file */

local dct_name "cpsfeb98.dct"

/* The line below does NOT need to be changed */

quietly infile using "`dct_name'", using("`dat_name'") clear

/*------------------------------------------------

  All items, except those with one character, also can have values
  of -1, -2, or -3 even if the values are not in the documentation
  The meaning is
       -1 .Blank or not in universe
       -2 .Don't know
       -3 .Refused

  The following changes in variable names have been made, if necessary:
      '$' to 'd';            '-' to '_';              '%' to 'p';
      ($ = unedited data;     - = edited data;         % = allocated data)

  Decimal places have been made explict in the dictionary file.
  Stata resolves a missing value of -1 / # of decimal places as a missing value.
 -----------------------------------------------*/

** These note statements incorporate variable universes into the Stata data file.
note: by Jean Roth, jroth@nber.org Wed Nov  4 16:52:58 EST 2009
note prsupsat: U PESD5 .1, 2, -2, or -3
*Everything below this point, aside from the final save, are value labels

#delimit ;

;
label values hufinal  hufinal;
label define hufinal
	0           "New Interview - Not Contacted"
	1           "Fully Complete CATI Interview"
	2           "Partially Completed CATI"
	5           "Labor Force Complete,"
	24          "HH Occupied Entirely By Armed"
	112         "Partial Interview With Callback"
	200         "New Interview - Contacted"
	201         "CAPI Complete"
	202         "Callback Needed"
	203         "Sufficient Partial - Precloseout"
	204         "Sufficient Partial - At Closeout"
	205         "Labor Force Complete, - Suppl."
	210         "CAPI Complete Reinterview"
	216         "No One Home"
	217         "Temporarily Absent"
	218         "Refused"
	219         "Other Occupied - Specify"
	224         "Armed Forces Occupied Or Under"
	225         "Temp. Occupied W/persons With"
	226         "Vacant Regular"
	227         "Vacant - Storage Of Hhld"
	228         "Unfit, To Be Demolished"
	229         "Under Construction, Not Ready"
	230         "Converted To Temp Business Or"
	231         "Unoccupied Tent Or Trailer Site"
	232         "Permit Granted - Construction"
	233         "Other - Specify"
	240         "Demolished"
	241         "House Or Trailer Moved"
	242         "Outside Segment"
	243         "Converted To Perm. Business Or"
	244         "Merged"
	245         "Condemned"
	246         "Built After April 1, 1980"
	247         "Unused Serial No./Listing Sheet"
	248         "Other - Specify"
;
label values huspnish huspnish;
label define huspnish
	1           "Spanish Only Language Spoken"
;
label values hetenure hetenure;
label define hetenure
	1           "Owned Or Being Bought By A HH"
	2           "Rented For Cash"
	3           "Occupied Without Payment Of"
;
label values hehousut hehousut;
label define hehousut
	0           "Other Unit"
	1           "House, Apartment, Flat"
	2           "HU In Nontransient Hotel, Motel,"
	3           "HU Permanent In Transient Hotel,"
	4           "HU In Rooming House"
	5           "Mobile Home Or Trailer W/no"
	6           "Mobile Home Or Trailer W/1 Or"
	7           "HU Not Specified Above"
	8           "Quarters Not HU In Rooming Or"
	9           "Unit Not Perm. In Transient"
	10          "Unoccupied Tent Site Or Trlr"
	11          "Student Quarters In College Dorm"
	12          "Other Unit Not Specified Above"
;
label values hetelhhd hetelhhd;
label define hetelhhd
	1           "Yes"
	2           "No"
;
label values hetelavl hetelavl;
label define hetelavl
	1           "Yes"
	2           "No"
;
label values hephoneo hephoneo;
label define hephoneo
	1           "Yes"
	2           "No"
;
label values hufaminc hufaminc;
label define hufaminc
	1           "Less Than $5,000"
	2           "5,000 to 7,499"
	3           "7,500 to 9,999"
	4           "10,000 to 12,499"
	5           "12,500 to 14,999"
	6           "15,000 to 19,999"
	7           "20,000 to 24,999"
	8           "25,000 to 29,999"
	9           "30,000 to 34,999"
	10          "35,000 to 39,999"
	11          "40,000 to 49,999"
	12          "50,000 to 59,999"
	13          "60,000 to 74,999"
	14          "75,000 or more"
;
label values hutypea  hutypea;
label define hutypea
	1           "No One Home (NOH)"
	2           "Temporarily Absent (TA)"
	3           "Refused (REF)"
	4           "Other Occupied - Specify"
;
label values hutypb   hutypb;
label define hutypb
	1           "Vacant Regular"
	2           "Temporarily Occupied By"
	3           "Vacant-storage Of Hhld Furniture"
	4           "Unfit Or To Be Demolished"
	5           "Under Construction, Not Ready"
	6           "Converted To Temp Business Or"
	7           "Unoccupied Tent Site Or Trailer"
	8           "Permit Granted Construction Not"
	9           "Other Type B - Specify"
;
label values hutypc   hutypc;
label define hutypc
	1           "Demolished"
	2           "House Or Trailer Moved"
	3           "Outside Segment"
	4           "Converted To Perm. Business Or"
	5           "Merged"
	6           "Condemned"
	8           "Unused Line Of Listing Sheet"
	9           "Other - Specify"
;
label values hrintsta hrintsta;
label define hrintsta
	1           "Interview"
	2           "Type A Non-interview"
	3           "Type B Non-interview"
	4           "Type C Non-interview"
;
label values hrhtype  hrhtype;
label define hrhtype
	0           "Non-interview Household"
	1           "Husband/Wife Primary Family"
	2           "Husb/Wife Prim. Family"
	3           "Unmarried Civilian Male-Prim."
	4           "Unmarried Civ. Female-Prim Fam"
	5           "Primary Family HHLDER-RP In"
	6           "Civilian Male Primary Individual"
	7           "Civilian Female Primary"
	8           "Primary Individual HHLD-RP In"
	9           "Group Quarters With Family"
	10          "Group Quarters Without Family"
;
label values huinttyp huinttyp;
label define huinttyp
	0           "Noninterview/indeterminate"
	1           "Personal"
	2           "Telephone"
;
label values hrlonglk hrlonglk;
label define hrlonglk
	0           "Mis 1 Or Replacement HH (No"
	2           "Mis 2-4 Or Mis 6-8"
	3           "Mis 5"
;
label values hubus    hubus;
label define hubus
	1           "Yes"
	2           "No"
;
label values gereg    gereg;
label define gereg
	1           "Northeast"
	2           "Midwest (Formerly North Central)"
	3           "South"
	4           "West"
;
label values gestcen  gestcen;
label define gestcen
	11          "ME"
	12          "NH"
	13          "VT"
	14          "MA"
	15          "RI"
	16          "CT"
	21          "NY"
	22          "NJ"
	23          "PA"
	31          "OH"
	32          "IN"
	33          "IL"
	34          "MI"
	35          "WI"
	41          "MN"
	42          "IA"
	43          "MO"
	44          "ND"
	45          "SD"
	46          "NE"
	47          "KS"
	51          "DE"
	52          "MD"
	53          "DC"
	54          "VA"
	55          "WV"
	56          "NC"
	57          "SC"
	58          "GA"
	59          "FL"
	61          "KY"
	62          "TN"
	63          "AL"
	64          "MS"
	71          "AR"
	72          "LA"
	73          "OK"
	74          "TX"
	81          "MT"
	82          "ID"
	83          "WY"
	84          "CO"
	85          "NM"
	86          "AZ"
	87          "UT"
	88          "NV"
	91          "WA"
	92          "OR"
	93          "CA"
	94          "AK"
	95          "HI"
;
label values gestfips gestfips;
label define gestfips
	1           "AL"
	2           "AK"
	4           "AZ"
	5           "AR"
	6           "CA"
	8           "CO"
	9           "CT"
	10          "DE"
	11          "DC"
	12          "FL"
	13          "GA"
	15          "HI"
	16          "ID"
	17          "IL"
	18          "IN"
	19          "IA"
	20          "KS"
	21          "KY"
	22          "LA"
	23          "ME"
	24          "MD"
	25          "MA"
	26          "MI"
	27          "MN"
	28          "MS"
	29          "MO"
	30          "MT"
	31          "NE"
	32          "NV"
	33          "NH"
	34          "NJ"
	35          "NM"
	36          "NY"
	37          "NC"
	38          "ND"
	39          "OH"
	40          "OK"
	41          "OR"
	42          "PA"
	44          "RI"
	45          "SC"
	46          "SD"
	47          "TN"
	48          "TX"
	49          "UT"
	50          "VT"
	51          "VA"
	53          "WA"
	54          "WV"
	55          "WI"
	56          "WY"
;
label values gecmsa   gecmsa;
label define gecmsa
	0           "Not Identified Or"
;
label values gemsa    gemsa;
label define gemsa
	0           "Not Identified Or Non"
;
label values geco     geco;
label define geco
	0           "Not Identified"
;
label values gemsast  gemsast;
label define gemsast
	1           "Central City"
	2           "Balance"
	3           "Nonmetropolitan"
	4           "Not Identified"
;
label values gemetsta gemetsta;
label define gemetsta
	1           "Metropolitan"
	2           "Nonmetropolitan"
	3           "Not Identified"
;
label values geindvcc geindvcc;
label define geindvcc
	0           "Not Identified, Nonmetropolitan,"
;
label values gemsasz  gemsasz;
label define gemsasz
	0           "Not Identified Or"
	2           "100,000 - 249,999"
	3           "250,000 - 499,999"
	4           "500,000 - 999,999"
	5           "1,000,000 - 2,499,999"
	6           "2,500,000 - 4,999,999"
	7           "5,000,000+"
;
label values gecmsasz gecmsasz;
label define gecmsasz
	0           "Not Identified Or"
	2           "100,000 - 249,999"
	3           "250,000 - 499,999"
	4           "500,000 - 999,999"
	5           "1,000,000 - 2,499,999"
	6           "2,500,000 - 4,999,999"
	7           "5,000,000+"
;
label values proldrrp proldrrp;
label define proldrrp
	1           "Ref Pers With Other Relatives"
	2           "Ref Pers With No Other"
	3           "Spouse"
	4           "Child"
	5           "Grandchild"
	6           "Parent"
	7           "Brother/Sister"
	8           "Other Relative"
	9           "Foster Child"
	10          "Non-rel Of Ref Per W/Own Rels"
	11          "Partner/Roommate"
	12          "Non-rel Of Ref Per W/No Own"
;
label values pupelig  pupelig;
label define pupelig
	1           "Eligible For Interview"
	2           "Labor Force Fully Complete"
	3           "Missing Labor Force Data For"
	4           "(Not Used)"
	5           "Assigned If Age Is Blank"
	6           "Armed Forces Member"
	7           "Under 15 Years Old"
	8           "Not A HH Member"
	9           "Deleted"
	10          "Deceased"
	11          "End Of List"
	12          "After End Of List"
;
label values perrp    perrp;
label define perrp
	1           "Reference Person W/rels."
	2           "Reference Person W/o Rels."
	3           "Spouse"
	4           "Child"
	5           "Grandchild"
	6           "Parent"
	7           "Brother/sister"
	8           "Other Rel. Or Ref. Person"
	9           "Foster Child"
	10          "Nonrel. Of Ref. Person W/Rels."
	11          "Not Used"
	12          "Nonrel. Of Ref. Person W/O"
	13          "Unmarried Partner W/Rels."
	14          "Unmarried Partner W/Out Rels."
	15          "Housemate/Roommate W/Rels."
	16          "Housemate/Roommate W/Out"
	17          "Roomer/Boarder W/Rels."
	18          "Roomer/Boarder W/Out Rels."
;
label values peparent peparent;
label define peparent
	-1          "No Parent"
;
label values ptage    ptage;
label define ptage
	0           "No Top Code"
	1           "Top Coded Value For Age"
;
label values pemaritl pemaritl;
label define pemaritl
	1           "Married - Spouse Present"
	2           "Married - Spouse Absent"
	3           "Widowed"
	4           "Divorced"
	5           "Separated"
	6           "Never Married"
;
label values pespouse pespouse;
label define pespouse
	-1          "No Spouse"
;
label values pesex    pesex;
label define pesex
	1           "Male"
	2           "Female"
;
label values puafever puafever;
label define puafever
	1           "Yes"
	2           "No"
;
label values peafwhen peafwhen;
label define peafwhen
	1           "Vietnam Era (8/64-4/75)"
	2           "Korean War (6/50-1/55)"
	3           "World War II (9/40-7/47)"
	4           "World War I (4/17-11/18)"
	5           "Other Service (All Other"
	6           "Nonveteran"
;
label values peafnow  peafnow;
label define peafnow
	1           "Yes"
	2           "No"
;
label values peeduca  peeduca;
label define peeduca
	31          "Less Than 1st Grade"
	32          "1st, 2nd, 3rd Or 4th Grade"
	33          "5th Or 6th Grade"
	34          "7th Or 8th Grade"
	35          "9th Grade"
	36          "10th Grade"
	37          "11th Grade"
	38          "12th Grade No Diploma"
	39          "High School Grad-Diploma Or"
	40          "Some College But No Degree"
	41          "Associate Degree-"
	42          "Associate Degree-Academic"
	43          "Bachelor's Degree (Ex:  BA,"
	44          "Master's Degree (Ex:  MA, MS,"
	45          "Professional School Deg (Ex:"
	46          "Doctorate Degree (Ex:  PHD,"
;
label values perace   perace;
label define perace
	1           "White"
	2           "Black"
	3           "American Indian, Aleut, Eskimo"
	4           "Asian Or Pacific Islander"
;
label values prorigin prorigin;
label define prorigin
	1           "Mexican American"
	2           "Chicano"
	3           "Mexican (Mexicano)"
	4           "Puerto Rican"
	5           "Cuban"
	6           "Central Or South American"
	7           "Other Spanish"
	8           "All Other"
	9           "Don't Know"
	10          "NA"
;
label values puchinhh puchinhh;
label define puchinhh
	1           "Person Added"
	2           "Person Added - URE"
	3           "Person Undeleted"
	4           "Person Died"
	5           "Deleted For Reason Other Than"
	6           "Person Joined Armed Forces"
	7           "Person No Longer In Af"
	9           "Change In Demographic"
;
label values purelflg purelflg;
label define purelflg
	0           "Not Owner Or Related To"
	1           "Owner Of Bus Or Related To"
;
label values prfamnum prfamnum;
label define prfamnum
	0           "Not A Family Member"
	1           "Primary Family Member Only"
	2           "Subfamily No. 2 Member"
	3           "Subfamily No. 3 Member"
	4           "Subfamily No. 4 Member"
	5           "Subfamily No. 5 Member"
	6           "Subfamily No. 6 Member"
	7           "Subfamily No. 7 Member"
	8           "Subfamily No. 8 Member"
	9           "Subfamily No. 9 Member"
	10          "Subfamily No. 10 Member"
	11          "Subfamily No. 11 Member"
	12          "Subfamily No. 12 Member"
	13          "Subfamily No. 13 Member"
	14          "Subfamily No. 14 Member"
	15          "Subfamily No. 15 Member"
	16          "Subfamily No. 16 Member"
	17          "Subfamily No. 17 Member"
	18          "Subfamily No. 18 Member"
	19          "Subfamily No. 19 Member"
;
label values prfamrel prfamrel;
label define prfamrel
	0           "Not A Family Member"
	1           "Reference Person"
	2           "Spouse"
	3           "Child"
	4           "Other Relative (Primary Family"
;
label values prfamtyp prfamtyp;
label define prfamtyp
	1           "Primary Family"
	2           "Primary Individual"
	3           "Related Subfamily"
	4           "Unrelated Subfamily"
	5           "Secondary Individual"
;
label values prhspnon prhspnon;
label define prhspnon
	1           "Hispanic"
	2           "Non-Hispanic"
;
label values prmarsta prmarsta;
label define prmarsta
	1           "Married, Civilian Spouse"
	2           "Married, Armed Forces Spouse"
	3           "Married, Spouse Absent (Exc."
	4           "Widowed"
	5           "Divorced"
	6           "Separated"
	7           "Never Married"
;
label values prpertyp prpertyp;
label define prpertyp
	1           "Child Household Member"
	2           "Adult Civilian Household"
	3           "Adult Armed Forces Household"
;
label values penatvty penatvty;
label define penatvty
	57          "United States"
	72          "Puerto Rico"
	96          "U.S. Outlying Area"
	555         "Abroad, Country Not Known"
;
label values pemntvty pemntvty;
label define pemntvty
	57          "United States"
	72          "Puerto Rico"
	96          "U.S. Outlying Area"
	555         "Abroad, Country Not Known"
;
label values pefntvty pefntvty;
label define pefntvty
	57          "United States"
	72          "Puerto Rico"
	96          "U.S. Outlying Area"
	555         "Abroad, Country Not Known"
;
label values prcitshp prcitshp;
label define prcitshp
	1           "Native, Born In The United"
	2           "Native, Born In Puerto Rico Or"
	3           "Native, Born Abroad Of"
	4           "Foreign Born, U.S. Citizen By"
	5           "Foreign Born, Not A Citizen Of"
;
label values prinusyr prinusyr;
label define prinusyr
	-1          "Not In Universe (Born In U.S.)"
	0           "Not Foreign Born"
	1           "Before 1950"
	2           "1950-1959"
	3           "1960-1964"
	4           "1965-1969"
	5           "1970-1974"
	6           "1975-1979"
	7           "1980-1981"
	8           "1982-1983"
	9           "1984-1985"
	10          "1986-1987"
	11          "1988-1989"
	12          "1990-1991"
	13          "1992-1993"
	14          "1994-1995"
	15          "1996-1998"
;
label values puslfprx puslfprx;
label define puslfprx
	1           "Self"
	2           "Proxy"
	3           "Both Self And Proxy"
;
label values pemlr    pemlr;
label define pemlr
	1           "Employed-At Work"
	2           "Employed-Absent"
	3           "Unemployed-On Layoff"
	4           "Unemployed-Looking"
	5           "Not In Labor Force-Retired"
	6           "Not In Labor Force-Disabled"
	7           "Not In Labor Force-Other"
;
label values puwk     puwk;
label define puwk
	1           "Yes"
	2           "No"
	3           "Retired"
	4           "Disabled"
	5           "Unable To Work"
;
label values pubus1   pubus1l;
label define pubus1l
	1           "Yes"
	2           "No"
;
label values pubus2ot pubus2ot;
label define pubus2ot
	1           "Yes"
	2           "No"
;
label values pubusck1 pubuscka;
label define pubuscka
	1           "Goto PUBUS1"
	2           "Goto PURETCK1"
;
label values pubusck2 pubusckb;
label define pubusckb
	1           "Goto PUHRUSL1"
	2           "Goto PUBUS2"
;
label values pubusck3 pubusckc;
label define pubusckc
	1           "Goto PUABSRSN"
	2           "Goto PULAY"
;
label values pubusck4 pubusckd;
label define pubusckd
	1           "Goto PUHRUSL1"
	2           "Goto PUABSPD"
;
label values puretot  puretot;
label define puretot
	1           "Yes"
	2           "No"
	3           "Was Not Retired Last Month"
;
label values pudis    pudis;
label define pudis
	1           "Yes"
	2           "No"
	3           "Did Not Have Disability Last"
;
label values peret1   peret1l;
label define peret1l
	1           "Yes"
	2           "No"
	3           "Has A Job"
;
label values pudis1   pudis1l;
label define pudis1l
	1           "Yes"
	2           "No"
;
label values pudis2   pudis2l;
label define pudis2l
	1           "Yes"
	2           "No"
;
label values puabsot  puabsot;
label define puabsot
	1           "Yes"
	2           "No"
	3           "Retired"
	4           "Disabled"
	5           "Unable To Work"
;
label values pulay    pulay;
label define pulay
	1           "Yes"
	2           "No"
	3           "Retired"
	4           "Disabled"
	5           "Unable To Work"
;
label values peabsrsn peabsrsn;
label define peabsrsn
	1           "On Layoff"
	2           "Slack Work/Business Conditions"
	3           "Waiting For A New Job To"
	4           "Vacation/Personal Days"
	5           "Own Illness/Injury/Medical"
	6           "Child Care Problems"
	7           "Other Family/Personal"
	8           "Maternity/Paternity Leave"
	9           "Labor Dispute"
	10          "Weather Affected Job"
	11          "School/Training"
	12          "Civic/Military Duty"
	13          "Does Not Work In The"
	14          "Other (Specify)"
;
label values peabspdo peabspdo;
label define peabspdo
	1           "Yes"
	2           "No"
;
label values pemjot   pemjot;
label define pemjot
	1           "Yes"
	2           "No"
;
label values pemjnum  pemjnum;
label define pemjnum
	2           "Jobs"
	3           "3 Jobs"
	4           "4 Or More Jobs"
;
label values pehrusl1 pehrusla;
label define pehrusla
	-4          "Hours Vary"
;
label values pehrusl2 pehruslb;
label define pehruslb
	-4          "Hours Vary"
;
label values pehrftpt pehrftpt;
label define pehrftpt
	1           "Yes"
	2           "No"
	3           "Hours Vary"
;
label values pehruslt pehruslt;
label define pehruslt
	-4          "Varies"
;
label values pehrwant pehrwant;
label define pehrwant
	1           "Yes"
	2           "No"
	3           "Regular Hours Are Full-Time"
;
label values pehrrsn1 pehrrsna;
label define pehrrsna
	1           "Slack Work/Business Conditions"
	2           "Could Only Find Part-time Work"
	3           "Seasonal Work"
	4           "Child Care Problems"
	5           "Other Family/Personal"
	6           "Health/Medical Limitations"
	7           "School/Training"
	8           "Retired/Social Security Limit On"
	9           "Full-time Workweek Is Less"
	10          "Other - Specify"
;
label values pehrrsn2 pehrrsnb;
label define pehrrsnb
	1           "Child Care Problems"
	2           "Other Family/Personal"
	3           "Health/Medical Limitations"
	4           "School/Training"
	5           "Retired/Social Security Limit On"
	6           "Full-Time Workweek Less Than"
	7           "Other - Specify"
;
label values pehrrsn3 pehrrsnc;
label define pehrrsnc
	1           "Slack Work/Business Conditions"
	2           "Seasonal Work"
	3           "Job Started Or Ended During"
	4           "Vacation/Personal Day"
	5           "Own Illness/Injury/Medical"
	6           "Holiday (Legal Or Religious)"
	7           "Child Care Problems"
	8           "Other Family/Personal"
	9           "Labor Dispute"
	10          "Weather Affected Job"
	11          "School/Training"
	12          "Civic/Military Duty"
	13          "Other Reason"
;
label values puhroff1 puhroffa;
label define puhroffa
	1           "Yes"
	2           "No"
;
label values puhrot1  puhrot1l;
label define puhrot1l
	1           "Yes"
	2           "No"
;
label values pehravl  pehravl;
label define pehravl
	1           "Yes"
	2           "No"
;
label values puhrck1  puhrck1l;
label define puhrck1l
	1           "Goto PUHRUSL2"
	2           "Goto PUHRUSLT"
;
label values puhrck2  puhrck2l;
label define puhrck2l
	1           "If Entry Of 1 In MJ And Entry Of"
	2           "If Entry Of 1 In Mj And Entry"
	3           "If Entry Of 2, D Or R In Mj And"
	4           "If Entry Of 1 In BUS1 And Entry"
	5           "All Others Goto HRCK3-C"
;
label values puhrck3  puhrck3l;
label define puhrck3l
	1           "If Entry Of 1 In ABSOT Or"
	2           "If Entry Of 3 In Ret1 Goto"
	3           "If Entry In HRUSLt Is 0-34"
	4           "If Entry In HRUSLt Is 35+ Goto"
	5           "All Others Goto HRCK4-C"
	6           "Goto PUHRCK4"
;
label values puhrck4  puhrck4l;
label define puhrck4l
	1           "If Entry Of 1, D, R OR V In"
	2           "If ENTRY OF 2, D Or R In"
	3           "If HRUSLT Is 0-34 Then GOTO"
	4           "If Entry Of 2 In HRFTPT Then"
	5           "All Others GOTO HRACT1"
;
label values puhrck5  puhrck5l;
label define puhrck5l
	1           "If Entry Of 1 In MJOT Goto"
	2           "All Others Goto HRCK6-C"
;
label values puhrck6  puhrck6l;
label define puhrck6l
	1           "If HRACT1 And HRACT2 Eq 0"
	2           "If HRACT1 And HRACT2 Eq 0"
	3           "All Others Goto HRACTt-C"
;
label values puhrck7  puhrck7l;
label define puhrck7l
	1           "(If Entry Of 2, D Or R In Bus2)"
	2           "(If Entry Of 2, D Or R In Bus2)"
	3           "(If HRUSLt Is 35+ Or If Entry Of"
	4           "If Entry Of 1 In HRWANT And"
	5           "All Others Goto HRCK8"
;
label values puhrck12 puhrck1b;
label define puhrck1b
	1           "If Entry Of 2, D Or R In BUS2"
	2           "All Others Goto Iock1"
;
label values pulaydt  pulaydt;
label define pulaydt
	1           "Yes"
	2           "No"
;
label values pulay6m  pulay6m;
label define pulay6m
	1           "Yes"
	2           "No"
;
label values pelayavl pelayavl;
label define pelayavl
	1           "Yes"
	2           "No"
;
label values pulayavr pulayavr;
label define pulayavr
	1           "Own Temporary Illness"
	2           "Going To School"
	3           "Other"
;
label values pelaylk  pelaylk;
label define pelaylk
	1           "Yes"
	2           "No"
;
label values pelayfto pelayfto;
label define pelayfto
	1           "Yes"
	2           "No"
;
label values pulayck1 pulaycka;
label define pulaycka
	1           "Goto PULAYCK3"
	2           "Goto PULAYFT"
	3           "Goto PULAYDR"
;
label values pulayck2 pulayckb;
label define pulayckb
	1           "Goto PULAYDR3"
	2           "Goto PULAYFT"
;
label values pulayck3 pulayckc;
label define pulayckc
	1           "MISCK = 5 GOTO IO1INT"
	2           "I-ICR = 1 OR I-OCR = 1, GOTO"
	3           "ALL OTHERS GOTO SCHCK"
;
label values pulk     pulk;
label define pulk
	1           "Yes"
	2           "No"
	3           "Retired"
	4           "Disabled"
	5           "Unable To Work"
;
label values pelkm1   pelkm1l;
label define pelkm1l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	12          "Nothing"
	13          "Other Passive"
;
label values pulkm2   pulkm2l;
label define pulkm2l
	1           "Contacted Employer"
	2           "Contacted Pulbic Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkm3   pulkm3l;
label define pulkm3l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkm4   pulkm4l;
label define pulkm4l
	1           "Contacted Employer"
	2           "Contacted Pulbic Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkm5   pulkm5l;
label define pulkm5l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkm6   pulkm6l;
label define pulkm6l
	1           "Contacted Employer"
	2           "Contacted Pulbic Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkdk1  pulkdk1l;
label define pulkdk1l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	12          "Nothing"
	13          "Other Passive"
;
label values pulkdk2  pulkdk2l;
label define pulkdk2l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkdk3  pulkdk3l;
label define pulkdk3l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkdk4  pulkdk4l;
label define pulkdk4l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkdk5  pulkdk5l;
label define pulkdk5l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkdk6  pulkdk6l;
label define pulkdk6l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkps1  pulkps1l;
label define pulkps1l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	12          "Nothing"
	13          "Other Passive"
;
label values pulkps2  pulkps2l;
label define pulkps2l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkps3  pulkps3l;
label define pulkps3l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkps4  pulkps4l;
label define pulkps4l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkps5  pulkps5l;
label define pulkps5l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pulkps6  pulkps6l;
label define pulkps6l
	1           "Contacted Employer"
	2           "Contacted Public Employment"
	3           "Contacted Private Employment"
	4           "Contacted Friends Or Relatives"
	5           "Contacted School/University"
	6           "Sent Out Resumes/Filled Out"
	7           "Checked Union/Professional"
	8           "Placed Or Answered Ads"
	9           "Other Active"
	10          "Looked At Ads"
	11          "Attended Job Training"
	13          "Other Passive"
;
label values pelkavl  pelkavl;
label define pelkavl
	1           "Yes"
	2           "No"
;
label values pulkavr  pulkavr;
label define pulkavr
	1           "Waiting For New Job To Begin"
	2           "Own Temporary Illness"
	3           "Going To School"
	4           "Other - Specify"
;
label values pelkll1o pelkll1o;
label define pelkll1o
	1           "Working"
	2           "School"
	3           "Left Military Service"
	4           "Something Else"
;
label values pelkll2o pelkll2o;
label define pelkll2o
	1           "Lost Job"
	2           "Quit Job"
	3           "Temporary Job Ended"
;
label values pelklwo  pelklwo;
label define pelklwo
	1           "Within The Last 12 Months"
	2           "More Than 12 Months Ago"
	3           "Never Worked"
;
label values pelkfto  pelkfto;
label define pelkfto
	1           "Yes"
	2           "No"
	3           "Doesn't Matter"
;
label values pedwwnto pedwwnto;
label define pedwwnto
	1           "Yes, Or Maybe, It Depends"
	2           "No"
	3           "Retired"
	4           "Disabled"
	5           "Unable"
;
label values pedwrsn  pedwrsn;
label define pedwrsn
	1           "Believes No Work Available In"
	2           "Couldn't Find Any Work"
	3           "Lacks Necessary"
	4           "Employers Think Too Young Or"
	5           "Other Types Of Discrimination"
	6           "Can't Arrange Child Care"
	7           "Family Responsibilities"
	8           "In School Or Other Training"
	9           "Ill-health, Physical Disability"
	10          "Transportation Problems"
	11          "Other - Specify"
;
label values pedwlko  pedwlko;
label define pedwlko
	1           "Yes"
	2           "No"
;
label values pedwwk   pedwwk;
label define pedwwk
	1           "Yes"
	2           "No"
;
label values pedw4wk  pedw4wk;
label define pedw4wk
	1           "Yes"
	2           "No"
;
label values pedwlkwk pedwlkwk;
label define pedwlkwk
	1           "Yes"
	2           "No"
;
label values pedwavl  pedwavl;
label define pedwavl
	1           "Yes"
	2           "No"
;
label values pedwavr  pedwavr;
label define pedwavr
	1           "Own Temporary Illness"
	2           "Going To School"
	3           "Other"
;
label values pudwck1  pudwck1l;
label define pudwck1l
	1           "If Entry Of 2 In BUS2 Goto"
	2           "If Entry Of 3 On Absrsn Goto"
	3           "If Entry Of 1 In Ret1, Store 1"
	4           "All Others Goto PUDWWNT"
;
label values pudwck2  pudwck2l;
label define pudwck2l
	1           "If Entry In Dis1 Or Dis2 Goto"
	2           "If Entry Of 4 In Dwwnt Goto"
	3           "If Entry Of 5 In Dwwnt Goto"
	4           "All Others Goto PUDWCK4"
;
label values pudwck3  pudwck3l;
label define pudwck3l
	1           "If AGERNG Equals 1-4 Or 9"
	2           "All Others Goto PUNLFCK2"
;
label values pudwck4  pudwck4l;
label define pudwck4l
	1           "If Entry Of 10 And/or 11 And/or"
	2           "If Entry Of 10 And/or 11 And/or"
	3           "If Entry Of 10 And/or 11 And/Or"
	4           "All Others Goto PUDWRSN"
;
label values pudwck5  pudwck5l;
label define pudwck5l
	1           "If Entry Of 1 In LK Then Store 1"
	2           "All Others Goto PUDWLK"
;
label values pejhwko  pejhwko;
label define pejhwko
	1           "Yes"
	2           "No"
;
label values pujhdp1o pujhdp1o;
label define pujhdp1o
	1           "Yes"
	2           "No"
;
label values pejhrsn  pejhrsn;
label define pejhrsn
	1           "Personal/Family (Including"
	2           "Return To School"
	3           "Health"
	4           "Retirement Or Old Age"
	5           "Temp, Seasonal Or Intermittent"
	6           "Slack Work/business Conditions"
	7           "Unsatisfactory Work"
	8           "Other - Specify"
;
label values pejhwant pejhwant;
label define pejhwant
	1           "Yes, Or It Depends"
	2           "No"
;
label values pujhck1  pujhck1l;
label define pujhck1l
	1           "PURET1 = 1, -2, Or -3 Then"
	2           "If MISCK Equals 4 Or 8 Then"
	3           "All Others Goto PUNLFCK1"
;
label values pujhck2  pujhck2l;
label define pujhck2l
	1           "If Entry Of 1 In DWWK And I-"
	2           "If Entry Of 2, D Or R In DWWK"
	3           "All Others Goto PUJHWK"
;
label values prabsrea prabsrea;
label define prabsrea
	1           "Ft Paid-Vacation"
	2           "Ft Paid-Own Illness"
	3           "Ft Paid-Child Care Problems"
	4           "Ft Paid-Other Family/Personal"
	5           "Ft Paid-Maternity/Paternity"
	6           "Ft Paid-Labor Dispute"
	7           "Ft Paid-Weather Affected Job"
	8           "Ft Paid-School/Training"
	9           "Ft Paid-Civic/Military Duty"
	10          "Ft Paid-Other"
	11          "Ft Unpaid-Vacation"
	12          "Ft Unpaid-Own Illness"
	13          "Ft Unpaid-Child Care Problems"
	14          "Ft Unpaid-Other Fam/Personal"
	15          "Ft Unpaid-Maternity/Paternity"
	16          "Ft Unpaid-Labor Dispute"
	17          "Ft Unpaid-Weather Affected"
	18          "Ft Unpaid-School/Training"
	19          "Ft Unpaid-Civic/Military Duty"
	20          "Ft Unpaid-Other"
	21          "Pt Paid-Vacation"
	22          "Pt Paid-Own Illness"
	23          "Pt Paid-Child Care Problems"
	24          "Pt Paid-Other Family/Personal"
	25          "Pt Paid-Maternity/Paternity"
	26          "Pt Paid-Labor Dispute"
	27          "Pt Paid-Weather Affected Job"
	28          "Pt Paid-School/Training"
	29          "Pt Paid-Civic/Military Duty"
	30          "Pt Paid-Other"
	31          "Pt Unpaid-Vacation"
	32          "Pt Unpaid-Own Illness"
	33          "Pt Unpaid-Child Care Problems"
	34          "Pt Unpaid-Other Fam/Personal"
	35          "Pt Unpaid-Maternity/Paternity"
	36          "Pt Unpaid-Labor Dispute"
	37          "Pt Unpaid-Weather Affected"
	38          "Pt Unpaid-School/Training"
	39          "Pt Unpaid-Civic/Military Duty"
	40          "Pt Unpaid-Other"
;
label values prcivlf  prcivlf;
label define prcivlf
	1           "In Civilian Labor Force"
	2           "Not In Civilian Labor Force"
;
label values prdisc   prdisc;
label define prdisc
	1           "Discouraged Worker"
	2           "Conditionally Interested"
	3           "Not Available"
;
label values premphrs premphrs;
label define premphrs
	0           "Unemployed And Nilf"
	1           "W/job, Not At Work-Illnes"
	2           "W/job, Not At Work-Vacation"
	3           "W/job, Not At Work-Weather"
	4           "W/job, Not At Work-Labor"
	5           "W/job, Not At Work-Child Care"
	6           "W/job, Not At Work-Fam/Pers"
	7           "W/job, Not At Work-"
	8           "W/job, Not At Work-"
	9           "W/job, Not At Work-"
	10          "W/job, Not At Work-Does Not"
	11          "W/job, Not At Work-Other"
	12          "At Work- 1-4 Hrs"
	13          "At Work- 5-14 Hrs"
	14          "At Work- 15-21 Hrs"
	15          "At Work- 22-29 Hrs"
	16          "At Work- 30-34 Hrs"
	17          "At Work- 35-39 Hrs"
	18          "At Work- 40 Hrs"
	19          "At Work- 41-47 Hrs"
	20          "At Work- 48 Hrs"
	21          "At Work- 49-59 Hrs"
	22          "At Work- 60 Hrs Or More"
;
label values prempnot prempnot;
label define prempnot
	1           "Employed"
	2           "Unemployed"
	3           "Not In Labor Force (NILF)-"
	4           "Not In Labor Force (NILF)-Other"
;
label values prexplf  prexplf;
label define prexplf
	1           "Employed"
	2           "Unemployed"
;
label values prftlf   prftlf;
label define prftlf
	1           "Full Time Labor Force"
	2           "Part Time Labor Force"
;
label values prhrusl  prhrusl;
label define prhrusl
	1           "0-20 Hrs"
	2           "21-34 Hrs"
	3           "35-39 Hrs"
	4           "40 Hrs"
	5           "41-49 Hrs"
	6           "50 Or More Hrs"
	7           "Varies-Full Time"
	8           "Varies-Part Time"
;
label values prjobsea prjobsea;
label define prjobsea
	1           "Looked Last 4 Weeks - Not"
	2           "Looked Last 4 Weeks - Worked"
	3           "Looked Last 4 Weeks - Layoff"
	4           "Unavailable Job Seekers"
	5           "No Recent Job Search"
;
label values prpthrs  prpthrs;
label define prpthrs
	0           "Usually FT, PT For"
	1           "Usu.FT, Pt Econ Reasons;"
	2           "Usu.FT, Pt Econ Reasons;"
	3           "Usu.FT, Pt Econ Reasons;"
	4           "Usu.FT, Pt Econ Reasons;"
	5           "Usu.PT, Econ Reasons; 1-4 Hrs"
	6           "Usu.PT, Econ Reasons;"
	7           "Usu.PT, Econ Reasons;"
	8           "Usu.PT, Econ Reasons;"
	9           "Usu.PT, Non-Econ Reasons;"
	10          "Usu.PT, Non-Econ Reasons;"
	11          "Usu.PT, Non-Econ Reasons;"
	12          "Usu.PT, Non-Econ Reasons;"
;
label values prptrea  prptrea;
label define prptrea
	1           "Usu. FT-Slack Work/Business"
	2           "Usu. FT-Seasonal Work"
	3           "Usu. FT-Job Started/Ended"
	4           "Usu. FT-Vacation/Personal Day"
	5           "Usu. FT-Own Illness/ Injury/"
	6           "Usu. FT-Holiday (Religious Or"
	7           "Usu. FT-Child Care Problems"
	8           "Usu. FT-Other Fam/Pers"
	9           "Usu. FT-Labor Dispute"
	10          "Usu. FT-Weather Affected Job"
	11          "Usu. FT-School/Training"
	12          "Usu. FT-Civic/Military Duty"
	13          "Usu. FT-Other Reason"
	14          "Usu. PT-Slack Work/Business"
	15          "Usu. PT-Could Only Find PT"
	16          "Usu. PT-Seasonal Work"
	17          "Usu. PT-Child Care Problems"
	18          "Usu. PT-Other Fam/Pers"
	19          "Usu. PT-Health/Medical"
	20          "Usu. PT-School/Training"
	21          "Usu. PT-Retired/S.S. Limit On"
	22          "Usu. PT-Workweek <35 Hours"
	23          "Usu. PT-Other Reason"
;
label values prusftpt prusftpt;
label define prusftpt
	1           "Full Time"
	2           "Part Time"
	3           "Status Unknown"
;
label values pruntype pruntype;
label define pruntype
	1           "Job Loser/On Layoff"
	2           "Other Job Loser"
	3           "Temporary Job Ended"
	4           "Job Leaver"
	5           "Re-Entrant"
	6           "New-Entrant"
;
label values prwksch  prwksch;
label define prwksch
	0           "Not In Labor Force"
	1           "At Work"
	2           "With Job, Not At Work"
	3           "Unemployed, Seeks FT"
	4           "Unemployed, Seeks PT"
;
label values prwkstat prwkstat;
label define prwkstat
	1           "Not In Labor Force"
	2           "FT Hours (35+), Usually FT"
	3           "PT For Economic Reasons,"
	4           "PT For Non-Economic Reasons,"
	5           "Not At Work, Usually FT"
	6           "PT Hrs, Usually PT For"
	7           "PT Hrs, Usually PT For Non-"
	8           "FT Hours, Usually PT For"
	9           "FT Hours, Usually PT For Non-"
	10          "Not At Work, Usually Part-Time"
	11          "Unemployed FT"
	12          "Unemployed PT"
;
label values prwntjob prwntjob;
label define prwntjob
	1           "Want A Job"
	2           "Other Not In Labor Force"
;
label values pujhck3  pujhck3l;
label define pujhck3l
	1           "If I-MLR Eq 3 Or 4 Then Goto"
	2           "All Others Goto PUJHRSN"
;
label values pujhck4  pujhck4l;
label define pujhck4l
	1           "If Entry Of 2, D Or R In"
	2           "If Entry Of 1 In PUDW4WK Or"
	3           "If I-MLR Equals 1 Or 2 And"
	4           "If Entry In PUJHRSN Then Goto"
	5           "All Others Goto PUNLFCK1"
;
label values pujhck5  pujhck5l;
label define pujhck5l
	1           "If I-IO1ICR Equals 1 Or I-"
	2           "All Others Goto PUIOCK5"
;
label values puiodp1  puiodp1l;
label define puiodp1l
	1           "Yes"
	2           "No"
;
label values puiodp2  puiodp2l;
label define puiodp2l
	1           "Yes"
	2           "No"
;
label values puiodp3  puiodp3l;
label define puiodp3l
	1           "YES"
	2           "NO"
;
label values peio1cow peio1cow;
label define peio1cow
	1           "Government - Federal"
	2           "Government - State"
	3           "Government - Local"
	4           "Private, For Profit"
	5           "Private, Nonprofit"
	6           "Self-Employed, Incorporated"
	7           "Self-Employed, Unincorporated"
	8           "Without Pay"
;
label values puio1mfg puio1mfg;
label define puio1mfg
	1           "Manufacturing"
	2           "Retail Trade"
	3           "Wholesale Trade"
	4           "Something Else"
;
label values peio2cow peio2cow;
label define peio2cow
	1           "Government - Federal"
	2           "Government - State"
	3           "Government - Local"
	4           "Private, For Profit"
	5           "Private, Nonprofit"
	6           "Self-Employed, Incorporated"
	7           "Self-Employed, Unincorporated"
	8           "Without Pay"
	9           "Unknown"
	10          "Government, Level Unknown"
	11          "Self-Employed, Incorp. Status"
;
label values puio2mfg puio2mfg;
label define puio2mfg
	1           "Manufacturing"
	2           "Retail Trade"
	3           "Wholesale Trade"
	4           "Something Else"
;
label values puiock1  puiock1l;
label define puiock1l
	1           "If {MISCK Eq 1 Or 5) Or MISCK"
	2           "If (MISCK Eq 1 Or 5) Or"
	3           "If I-IO1NAM Is D, R Or Blank"
	4           "All Others Goto PUIODP1"
;
label values puiock2  puiock2l;
label define puiock2l
	1           "If I-IO1ICR Eq 1 Then Goto"
	2           "If I-IO1OCR Eq 1 Then Goto"
	3           "All Others Goto PUIODP2"
;
label values puiock3  puiock3l;
label define puiock3l
	1           "If I-IO1OCC Equals D, R Or"
	2           "If I-IO1DT1 Is D, R Or Blank"
	3           "All Others Goto PUIODP3"
;
label values prioelg  prioelg;
label define prioelg
	0           "Not Eligible For Edit"
	1           "Eligible For Edit"
;
label values prana    prana;
label define prana
	1           "Agricultural"
	2           "Non-Agricultural"
;
label values prcow1   prcow1l;
label define prcow1l
	1           "Federal Govt"
	2           "State Govt"
	3           "Local Govt"
	4           "Private (Incl. Self-employed"
	5           "Self-Employed, Unincorp."
	6           "Without Pay"
;
label values prcow2   prcow2l;
label define prcow2l
	1           "Federal Govt"
	2           "State Govt"
	3           "Local Govt"
	4           "Private (Incl. Self-employed"
	5           "Self-Employed, Unincorp."
	6           "Without Pay"
;
label values prcowpg  prcowpg;
label define prcowpg
	1           "Private"
	2           "Government"
;
label values prdtcow1 prdtcowa;
label define prdtcowa
	1           "Agri., Wage & Salary, Private"
	2           "Agri., Wage & Salary,"
	3           "Agri., Self-Employed"
	4           "Agri., Unpaid"
	5           "NonAg, WS, Private, Private"
	6           "NonAg, WS, Private, Other"
	7           "NonAg, WS, Govt, Federal"
	8           "NonAg, WS, Govt, State"
	9           "NonAg, WS, Govt, Local"
	10          "NonAg, Self-Employed"
	11          "NonAg, Unpaid"
;
label values prdtcow2 prdtcowb;
label define prdtcowb
	1           "Agri., Wage & Salary, Private"
	2           "Agri., Wage & Salary,"
	3           "Agri., Self-Employed"
	4           "Agri., Unpaid"
	5           "NonAg, WS, Private, Private"
	6           "NonAg, WS, Private, Other"
	7           "NonAg, WS, Govt, Federal"
	8           "NonAg, WS, Govt, State"
	9           "NonAg, WS, Govt, Local"
	10          "NonAg, Self-Employed"
	11          "NonAg, Unpaid"
;
label values prdtind1 prdtinda;
label define prdtinda
	1           "Goods Producing-Agricultural"
	2           "Goods Producing-Other"
	3           "Mining"
	4           "Construction"
	5           "Mfg-Lumber & Wood Prods, Ex"
	6           "Mfg-Furniture & Fixtures"
	7           "Mfg-Stone, Clay, Concrete,"
	8           "Mfg-Primary Metals"
	9           "Mfg-Fabricated Metals"
	10          "Mfg-Not Specified Metal"
	11          "Mfg-Machinery, Ex Electrical"
	12          "Mfg-Electrical Machinery, Equip"
	13          "Mfg-Motor Vehicles & Equip"
	14          "Mfg-Aircraft & Parts"
	15          "Mfg-Other Transportation"
	16          "Mfg-Professional & Photo"
	17          "Mfg-Toys, Amusement &"
	18          "Mfg-Misc & Nec Mfg Industries"
	19          "Mfg-Food & Kindred Prods"
	20          "Mfg-Tobacco Prods"
	21          "Mfg-Textile Mill Prods"
	22          "Mfg-Apparel & Other Finished"
	23          "Mfg-Paper & Allied Products"
	24          "Mfg-Printing, Publishing &"
	25          "Mfg-Chemicals & Allied Prods"
	26          "Mfg-Petroleum & Coal Prods"
	27          "Mfg-Rubber & Misc Plastic"
	28          "Mfg-Leather & Leather Prods"
	29          "Transportation"
	30          "Communications"
	31          "Utilities & Sanitary Services"
	32          "Wholesale Trade"
	33          "Eating And Drinking Places"
	34          "Other Retail Trade"
	35          "Banking And Other Finance"
	36          "Insurance And Real Estate"
	37          "Private Household Services"
	38          "Business Services"
	39          "Automobile And Repair"
	40          "Personal Serv Exc Private"
	41          "Entertainment & Recreation"
	42          "Hospitals"
	43          "Health Services, Exc. Hospitals"
	44          "Educational Services"
	45          "Social Services"
	46          "Other Professional Services"
	47          "Forestry & Fisheries"
	48          "Justice, Public Order & Safety"
	49          "Admin Of Human Resource"
	50          "National Security & Internal"
	51          "Other Public Administration"
	52          "Armed Forces"
;
label values prdtind2 prdtindb;
label define prdtindb
	1           "Goods Producing-Agricultural"
	2           "Goods Producing-Other"
	3           "Mining"
	4           "Construction"
	5           "Mfg-Lumber & Wood Prods, Ex"
	6           "Mfg-Furniture & Fixtures"
	7           "Mfg-Stone, Clay, Concrete,"
	8           "Mfg-Primary Metals"
	9           "Mfg-Fabricated Metals"
	10          "Mfg-Not Specified Metal"
	11          "Mfg-Machinery, Ex Electrical"
	12          "Mfg-Electrical Machinery, Equip"
	13          "Mfg-Motor Vehicles & Equip"
	14          "Mfg-Aircraft & Parts"
	15          "Mfg-Other Transportation"
	16          "Mfg-Professional & Photo"
	17          "Mfg-Toys, Amusement &"
	18          "Mfg-Misc & Nec Mfg Industries"
	19          "Mfg-Food & Kindred Prods"
	20          "Mfg-Tobacco Prods"
	21          "Mfg-Textile Mill Prods"
	22          "Mfg-Apparel & Other Finished"
	23          "Mfg-Paper & Allied Products"
	24          "Mfg-Printing, Publishing &"
	25          "Mfg-Chemicals & Allied Prods"
	26          "Mfg-Petroleum & Coal Prods"
	27          "Mfg-Rubber & Misc Plastic"
	28          "Mfg-Leather & Leather Prods"
	29          "Transportation"
	30          "Communications"
	31          "Utilities & Sanitary Services"
	32          "Wholesale Trade"
	33          "Eating And Drinking Places"
	34          "Other Retail Trade"
	35          "Banking And Other Finance"
	36          "Insurance And Real Estate"
	37          "Private Household Services"
	38          "Business Services"
	39          "Automobile And Repair"
	40          "Personal Serv Exc Private"
	41          "Entertainment & Recreation"
	42          "Hospitals"
	43          "Health Services, Exc. Hospitals"
	44          "Educational Services"
	45          "Social Services"
	46          "Other Professional Services"
	47          "Forestry & Fisheries"
	48          "Justice, Public Order & Safety"
	49          "Admin Of Human Resource"
	50          "National Security & Internal"
	51          "Other Public Administration"
	52          "Armed Forces"
;
label values prdtocc1 prdtocca;
label define prdtocca
	1           "Officials & Administrators,"
	2           "Other Executive, Admin. &"
	3           "Management Related"
	4           "Engineers"
	5           "Mathematical And Computer"
	6           "Natural Scientists"
	7           "Health Diagnosing Occupations"
	8           "Health Assessment And"
	9           "Teachers, College And"
	10          "Teachers, Except College And"
	11          "Lawyers And Judges"
	12          "Other Professional Specialty"
	13          "Health Technologists And"
	14          "Engineering And Science"
	15          "Technicians, Except Health,"
	16          "Supervisors And Proprietors,"
	17          "Sales Reps, Finance And"
	18          "Sales Reps, Commodities,"
	19          "Sales Workers, Retail &"
	20          "Sales Related Occupations"
	21          "Supervisors, Administrative"
	22          "Computer Equiptment"
	23          "Secretaries, Stenographers,"
	24          "Financial Records Processing"
	25          "Mail And Message Distribution"
	26          "Other Admin. Support,"
	27          "Private Household Service"
	28          "Protective Service"
	29          "Food Service"
	30          "Health Service"
	31          "Cleaning And Building Service"
	32          "Personal Service"
	33          "Mechanics And Repairers"
	34          "Construction Trades"
	35          "Other Precision Production,"
	36          "Machine Operators, And"
	37          "Fabricators, Assemblers,"
	38          "Motot Vehicle Operators"
	39          "Other Transportation And"
	40          "Construction Laborers"
	41          "Freight, Stock, & Materials"
	42          "Other Handlers, Equipt."
	43          "Farm Operators And Managers"
	44          "Farm Workers And Related"
	45          "Forestry And Fishing"
	46          "Armed Forces"
;
label values prdtocc2 prdtoccb;
label define prdtoccb
	1           "Officials & Administrators,"
	2           "Other Executive, Admin. &"
	3           "Management Related"
	4           "Engineers"
	5           "Mathematical And Computer"
	6           "Natural Scientists"
	7           "Health Diagnosing Occupations"
	8           "Health Assessment And"
	9           "Teachers, College And"
	10          "Teachers, Except College And"
	11          "Lawyers And Judges"
	12          "Other Professional Speciality"
	13          "Health Technologists And"
	14          "Engineering And Science"
	15          "Technicians, Except Health,"
	16          "Supervisors And Proprietors,"
	17          "Sales Reps, Finance And"
	18          "Sales Reps, Commodities,"
	19          "Sales Workers, Retail &"
	20          "Sales Related Occupations"
	21          "Supervisors, Administrative"
	22          "Computer Equiptment"
	23          "Secretaries, Stenographers,"
	24          "Financial Records Processing"
	25          "Mail And Message Distribution"
	26          "Other Admin. Support,"
	27          "Private Household Service"
	28          "Protective Service"
	29          "Food Service"
	30          "Health Service"
	31          "Cleaning And Building Service"
	32          "Personal Service"
	33          "Mechanics And Repairers"
	34          "Construction Trades"
	35          "Other Precision Production,"
	36          "Machine Operators, And"
	37          "Fabricators, Assemblers,"
	38          "Motor Vehicle Operators"
	39          "Other Transportation And"
	40          "Construction Laborers"
	41          "Freight, Stock, & Materials"
	42          "Other Handlers, Equipt."
	43          "Farm Operators And Managers"
	44          "Farm Workers And Related"
	45          "Forestry And Fishing"
	46          "Armed Forces"
;
label values premp    premp;
label define premp
	1           "Employed Persons (Exc. Farm"
;
label values prmjind1 prmjinda;
label define prmjinda
	1           "Agriculture"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing - Durable Goods"
	5           "Manufacturing - Non-Durable"
	6           "Transportation"
	7           "Communications"
	8           "Utilities And Sanitary Services"
	9           "Wholesale Trade"
	10          "Retail Trade"
	11          "Finance, Insurance, And Real"
	12          "Private Households"
	13          "Business, Auto And Repair"
	14          "Personal Services, Exc. Private"
	15          "Entertainment And Recreation"
	16          "Hospitals"
	17          "Medical Services, Exc."
	18          "Educational Services"
	19          "Social Services"
	20          "Other Professional Services"
	21          "Forestry And Fisheries"
	22          "Public Administration"
	23          "Armed Forces"
;
label values prmjind2 prmjindb;
label define prmjindb
	1           "Agriculture"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing - Durable Goods"
	5           "Manufacturing - Non-Durable"
	6           "Transportation"
	7           "Communications"
	8           "Utilities And Sanitary Services"
	9           "Wholesale Trade"
	10          "Retail Trade"
	11          "Finance, Insurance, And Real"
	12          "Private Households"
	13          "Business, Auto And Repair"
	14          "Personal Services, Exc. Private"
	15          "Entertainment And Recreation"
	16          "Hospitals"
	17          "Medical Services, Exc."
	18          "Educational Services"
	19          "Social Services"
	20          "Other Professional Services"
	21          "Forestry And Fisheries"
	22          "Public Administration"
	23          "Armed Forces"
;
label values prmjocc1 prmjocca;
label define prmjocca
	1           "Executive, Administrative, &"
	2           "Professional Specialty"
	3           "Technicians And Related"
	4           "Sales Occupations"
	5           "Administrative Support"
	6           "Private Household Occupations"
	7           "Protective Service Occupations"
	8           "Service Occupations, Except"
	9           "Precision Production, Craft &"
	10          "Machine Operators,"
	11          "Transportation And Material"
	12          "Handlers, Equip Cleaners,"
	13          "Farming, Forestry And Fishing"
	14          "Armed Forces"
;
label values prmjocc2 prmjoccb;
label define prmjoccb
	1           "Executive, Administrative, &"
	2           "Professional Specialty"
	3           "Technicians And Related"
	4           "Sales Occupations"
	5           "Administrative Support"
	6           "Private Household Occupations"
	7           "Protective Service Occupations"
	8           "Service Occupations, Except"
	9           "Precision Production, Craft &"
	10          "Machine Operators,"
	11          "Transportation And Material"
	12          "Handlers, Equip Cleaners,"
	13          "Farming, Forestry And Fishing"
	14          "Armed Forces"
;
label values prmjocgr prmjocgr;
label define prmjocgr
	1           "Managerail & Professional,"
	2           "Service Occupations"
	3           "Production, Craft, Repair,"
	4           "Farming, Forestry & Fishing"
;
label values prnagpws prnagpws;
label define prnagpws
	1           "Non-Ag Priv Wage & Salary (Ex"
;
label values prnagws  prnagws;
label define prnagws
	1           "Non-Ag Wage And Salary"
;
label values prsjmj   prsjmj;
label define prsjmj
	1           "Single Jobholder"
	2           "Multiple Jobholder"
;
label values prerelg  prerelg;
label define prerelg
	0           "Not Eligible For Edit"
	1           "Eligible For Edit"
;
label values peernuot peernuot;
label define peernuot
	1           "Yes"
	2           "No"
;
label values peernper peernper;
label define peernper
	1           "Hourly"
	2           "Weekly"
	3           "Bi-Weekly"
	4           "Twice Monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other - Specify"
;
label values peernrt  peernrt;
label define peernrt
	1           "Yes"
	2           "No"
;
label values peernhry peernhry;
label define peernhry
	1           "Hourly Worker"
	2           "NonHourly Worker"
;
label values pthr     pthr;
label define pthr
	0           "Not Topcoded"
	1           "Topcoded"
;
label values ptwk     ptwk;
label define ptwk
	0           "Not Topcoded"
	1           "Topcoded"
;
label values ptot     ptot;
label define ptot
	0           "Not Topcoded"
	1           "Topcoded"
;
label values peernlab peernlab;
label define peernlab
	1           "Yes"
	2           "No"
;
label values peerncov peerncov;
label define peerncov
	1           "Yes"
	2           "No"
;
label values penlfjh  penlfjh;
label define penlfjh
	1           "Within The Last 12 Months"
	2           "More Than 12 Months Ago"
	3           "Never Worked"
;
label values penlfret penlfret;
label define penlfret
	1           "Yes"
	2           "No"
;
label values penlfact penlfact;
label define penlfact
	1           "Disabled"
	2           "Ill"
	3           "In School"
	4           "Taking Care Of House Or"
	5           "In Retirement"
	6           "Something Else/other"
;
label values punlfck1 punlfcka;
label define punlfcka
	1           "If AGERNG Equals 1-4 Or 9"
	2           "All Others Go to NLFRET"
;
label values punlfck2 punlfckb;
label define punlfckb
	1           "If MISCK Equals 4 Or 8 Then"
	2           "All Others Goto LBFR-end"
;
label values peschenr peschenr;
label define peschenr
	1           "Yes"
	2           "No"
;
label values peschft  peschft;
label define peschft
	1           "Full-time"
	2           "Part-time"
;
label values peschlvl peschlvl;
label define peschlvl
	1           "High School"
	2           "College Or University"
;
label values prnlfsch prnlfsch;
label define prnlfsch
	1           "In School"
	2           "Not In School"
;
label values prwernal prwernal;
label define prwernal
	0           "No Allocation"
	1           "One Or More Components Of The"
;
label values prhernal prhernal;
label define prhernal
	0           "No Allocation"
	1           "One Or More Components Of The"
;
label values pedipged pedipged;
label define pedipged
	-1          "Not In Universe"
	1           "Graduation From High School"
	2           "Ged Or Other Equivalent"
;
label values pehgcomp pehgcomp;
label define pehgcomp
	-1          "Not In Universe"
	1           "Less Than 1st Grade"
	2           "1st, 2nd, 3rd, Or 4th Grade"
	3           "5th Or 6th Grade"
	4           "7th Or 8th Grade"
	5           "9th Grade"
	6           "10th Grade"
	7           "11th Grade"
	8           "12th Grade (No Diploma)"
;
label values pecyc    pecyc;
label define pecyc
	-1          "Not In Universe"
	1           "Less Than 1 Year"
	2           "The First Or Freshman Year"
	3           "The Second Or Sophomore"
	4           "The Third Or Junior Year"
	5           "Four Or More Years"
;
label values pegrprof pegrprof;
label define pegrprof
	-1          "Not In Universe"
	1           "Yes"
	2           "No"
;
label values pegr6cor pegr6cor;
label define pegr6cor
	-1          "Not In Universe"
	1           "Yes"
	2           "No"
;
label values pems123  pems123l;
label define pems123l
	-1          "Not In Universe"
	1           "1 Year Program"
	2           "2 Year Program"
	3           "3 Year Program"
;
label values pesd1    pesd1l;
label define pesd1l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd2    pesd2l;
label define pesd2l
	1           "Plant or company closed down"
	2           "Insufficient work"
	3           "Position or shift abolished"
	4           "Seasonal job completed"
	5           "Self-operated business failed"
	6           "Some other reason"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd3    pesd3l;
label define pesd3l
	1           "1995"
	2           "1996"
	3           "1997"
	4           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd4    pesd4l;
label define pesd4l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd5    pesd5l;
label define pesd5l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd6    pesd6l;
label define pesd6l
	1           "Less than 1 month"
	2           "1 to 2 months"
	3           "More than 2 months"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pescow1  pescow1l;
label define pescow1l
	1           "Federal government"
	2           "State government"
	3           "Local government"
	4           "Private for profit"
	5           "Private, nonprofit"
	6           "Self-employed, incorporated"
	7           "Self-employed, unincorporated"
	8           "Without pay"
	9           "Unknown"
	10          "Government, level unknown"
	11          "Self-employed, incorporation"
	-9          "No response"
;
label values pes1icd  pes1icd;
label define pes1icd
	-9          "No response"
;
label values prsdind  prsdind;
label define prsdind
	1           "Goods producing - agricultural"
	2           "Goods producing - other"
	3           "Mining"
	4           "Construction"
	5           "Mfg - lumber & wood prods, ex"
	6           "Mfg - furniture & fixtures"
	7           "Mfg - stone, clay, concrete,"
	8           "Mfg - primary metals"
	9           "Mfg - fabricated metals"
	10          "Mfg - not specified metal"
	11          "Mfg - machinery, ex electrical"
	12          "Mfg - electrical machinery,"
	13          "Mfg - motor vehicles & equip"
	14          "Mfg - aircraft & parts"
	15          "Mfg - other transportation"
	16          "Mfg - professional & photo"
	17          "Mfg - toys, amusement &"
	18          "Mfg - misc & n.e.c. mfg"
	19          "Mfg - food & kindred prods"
	20          "Mfg - tobacco prods"
	21          "Mfg - textile mill prods"
	22          "Mfg - apparel & other finished"
	23          "Mfg - paper & allied products"
	24          "Mfg - printing, publishing &"
	25          "Mfg - chemicals & allied prods"
	26          "Mfg - petroleum & coal prods"
	27          "Mfg - rubber & misc plastic"
	28          "Mfg - leather & leather prods"
	29          "Transportation"
	30          "Communications"
	31          "Utilities & sanitary services"
	32          "Wholesale trade"
	33          "Eating and drinking places"
	34          "Other retail trade"
	35          "Banking and other finance"
	36          "Insurance and real estate"
	37          "Private household services"
	38          "Business services"
	39          "Automobile and repair services"
	40          "Personal serv exc private"
	41          "Entertainment & recreation"
	42          "Hospitals"
	43          "Health services, exc."
	44          "Educational services"
	45          "Social services"
	46          "Other professional services"
	47          "Forestry & fisheries"
	48          "Justice, public order & safety"
	49          "Admin of human resource"
	50          "National security & internal"
	51          "Other public administration"
	-9          "No response"
;
label values pes1ocd  pes1ocd;
label define pes1ocd
	-9          "No response"
;
label values prsdocc  prsdocc;
label define prsdocc
	1           "Officials & administrators,"
	2           "Other executive, admin. &"
	3           "Management related occupations"
	4           "Engineers"
	5           "Mathematical and computer"
	6           "Natural Scientists"
	7           "Health diagnosing occs."
	8           "Health assessment and"
	9           "Teachers, college and"
	10          "Teachers, except college and"
	11          "Lawyers and judges"
	12          "Other professional specialty"
	13          "Health technologists and"
	14          "Engineering and science"
	15          "Technicians, exc."
	16          "Supervisors and proprietors,"
	17          "Sales reps, finance and"
	18          "Sales reps, commodities, exc."
	19          "Sales workers, retail &"
	20          "Sales related occs"
	21          "Supervisors, admin. support"
	22          "Computer equipment operators"
	23          "Secretaries, stenographers,"
	24          "Financial records processing"
	25          "Mail and message distributing"
	26          "Other admin support, inc."
	27          "Private household service occs"
	28          "Protective service"
	29          "Food service"
	30          "Health service"
	31          "Cleaning and building service"
	32          "Personal service"
	33          "Mechanics and repairers"
	34          "Construction trades"
	35          "Other precision prod., craft,"
	36          "Machine opertrs and"
	37          "Fabricatrs, assemblrs,"
	38          "Motor vehicle operators"
	39          "Other transp. & material"
	40          "Construction laborers"
	41          "Freight, stock & materials"
	42          "Oth handlrs, equip.cleanrs,"
	43          "Farm operators and managers"
	44          "Farm workers and related"
	45          "Forestry and fishing occs"
	46          "Armed forces"
	-9          "No response"
;
label values pesd16   pesd16l;
label define pesd16l
	1           "Yes"
	2           "No ="
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd17   pesd17l;
label define pesd17l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd18a  pesd18a;
label define pesd18a
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd18b  pesd18b;
label define pesd18b
	1           "Days"
	2           "Weeks"
	3           "Months"
	4           "Years"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd19   pesd19l;
label define pesd19l
	1           "Yes"
	2           "No"
	-4          "Hours varied"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesle1o  pesle1o;
label define pesle1o
	1           "Hourly"
	2           "Weekly"
	3           "Bi-weekly"
	4           "Twice monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesle2   pesle2l;
label define pesle2l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesenh1o pesenh1o;
label define pesenh1o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsenh1o ptsenh1o;
label define ptsenh1o
	0           "No topcode"
	1           "Topcoded value"
;
label values pesle4o  pesle4o;
label define pesle4o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusle5   pusle5l;
label define pusle5l
	1           "Per hour"
	2           "Per day"
	3           "Per week"
	4           "Per month"
	5           "Per year"
	6           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusle6   pusle6l;
label define pusle6l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusle6d  pusle6d;
label define pusle6d
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsern   ptsern;
label define ptsern
	0           "No topcode"
	1           "Topcoded value"
;
label values ptsern2  ptsern2l;
label define ptsern2l
	0           "No topcode"
	1           "Topcoded value"
;
label values pesle22  pesle22l;
label define pesle22l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd20   pesd20l;
label define pesd20l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd21   pesd21l;
label define pesd21l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd22   pesd22l;
label define pesd22l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd23   pesd23l;
label define pesd23l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd24   pesd24l;
label define pesd24l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd25   pesd25l;
label define pesd25l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd26   pesd26l;
label define pesd26l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd27   pesd27l;
label define pesd27l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesce2o  pesce2o;
label define pesce2o
	1           "Hourly"
	2           "Weekly"
	3           "Bi-weekly"
	4           "Twice monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other-specify"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesce3   pesce3l;
label define pesce3l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values peseh1oa peseh1oa;
label define peseh1oa
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptseh1oa ptseh1oa;
label define ptseh1oa
	0           "No topcode"
	1           "Topcoded value"
;
label values pusce5   pusce5l;
label define pusce5l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesce5o  pesce5o;
label define pesce5o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusce6   pusce6l;
label define pusce6l
	1           "Per hour"
	2           "Per day"
	3           "Per week"
	4           "Per month"
	5           "Per year"
	6           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusce7   pusce7l;
label define pusce7l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusce8   pusce8l;
label define pusce8l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsern1  ptsern1l;
label define ptsern1l
	0           "No topcode"
	1           "Topcoded value"
;
label values ptsern2a ptsern2a;
label define ptsern2a
	0           "No topcode"
	1           "Topcoded value"
;
label values pesce25  pesce25l;
label define pesce25l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values prslwkly prslwkly;
label define prslwkly
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptslwkly ptslwkly;
label define ptslwkly
	0           "No topcode"
	1           "Topcoded value"
;
label values prscwkly prscwkly;
label define prscwkly
	-1          "Month-in-sample 4 and 8 cases"
;
label values ptscwkly ptscwkly;
label define ptscwkly
	0           "No topcode"
	1           "Topcoded value"
;
label values peshry   peshry;
label define peshry
	1           "Hourly worker"
	2           "Nonhourly worker"
;
label values prshr    prshr;
label define prshr
	0           "Minimum Value"
	9999        "Maximum Value"
;
label values prsupern prsupern;
label define prsupern
	1           "Eligible"
;
label values pest1a   pest1a;
label define pest1a
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest1b   pest1b;
label define pest1b
	1           "Days"
	2           "Weeks"
	3           "Months"
	4           "Years"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest3    pest3l;
label define pest3l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest4    pest4l;
label define pest4l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest5a1  pest5a1l;
label define pest5a1l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest5b   pest5b;
label define pest5b
	1           "Days"
	2           "Weeks"
	3           "Months"
	4           "Years"
	-2          "Don't Know"
	-3          "Refused"
;
label values pusd7    pusd7l;
label define pusd7l
	1           "Government"
	2           "Private-for-profit company"
	3           "Non-profit organization"
	4           "Self-employed"
	5           "Working in the family business"
	-2          "Don't Know"
	-3          "Refused"
;
label values prsupsat prsupsat;
label define prsupsat
	1           "Not Eligible for Displaced"
	2           "Interview - Interviews had to"
	3           "Noninterview - Cases that met"
;
label values prtensat prtensat;
label define prtensat
	1           "Not Eligible for Employee"
	2           "Interview - Interviews had to"
	3           "Noninterview - Cases that met"
;
label values prst1tn  prst1tn;
label define prst1tn
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values prsd18tn prsd18tn;
label define prsd18tn
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values prdispwk prdispwk;
label define prdispwk
	0           "Not a Displaced Worker"
	1           "Displaced Worker"
;

#delimit cr
compress
saveold "`dta_name'" , replace

/*
Copyright 2009 shared by the National Bureau of Economic Research and Jean Roth

National Bureau of Economic Research.
1050 Massachusetts Avenue
Cambridge, MA 02138
jroth@nber.org

This program and all programs referenced in it are free software. You
can redistribute the program or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/
