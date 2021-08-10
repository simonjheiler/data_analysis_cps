capture log close
log using cpsfeb99.log, replace
set mem 500m

/*------------------------------------------------
  by Jean Roth Mon May 18 12:47:20 EDT 2009
  Please report errors to jroth@nber.org
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http://www.gnu.org/licenses/ for details.
  Run with do cpsfeb99
----------------------------------------------- */

/* The following line should contain
   the complete path and name of the raw data file.
   On a PC, use backslashes in paths as in C:\  */

local dat_name "/homes/data/cps/cpsfeb99.dat"

/* The following line should contain the path to your output '.dta' file */

local dta_name "cpsfeb99.dta"

/* The following line should contain the path to the data dictionary file */

local dct_name "cpsfeb99.dct"

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
note: by Jean Roth, jroth@nber.org Mon May 18 12:47:20 EDT 2009
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
label values pes1ver  pes1ver;
label define pes1ver
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1     pes1l;
label define pes1l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1scri pes1scri;
label define pes1scri
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1scr  pes1scr;
label define pes1scr
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1a    pes1a;
label define pes1a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1b    pes1b;
label define pes1b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1c    pes1c;
label define pes1c
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1d    pes1d;
label define pes1d
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1ftim pes1ftim;
label define pes1ftim
	-9          "No response"
	-4          "Something else"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes1f1   pes1f1l;
label define pes1f1l
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "As long as I want"
	2           "Until I retire"
	3           "Until I find a"
	4           "Until I finish school"
	5           "Until I go back to"
	6           "Other"
;
label values pes1g    pes1g;
label define pes1g
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1h    pes1h;
label define pes1h
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1i    pes1i;
label define pes1i
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Job is temporary"
	2           "Business conditions"
	3           "Introduction of new"
	4           "Other economic"
	5           "Job performance"
	6           "Obtaining another job"
	7           "Attending school"
	8           "Family responsibilities"
	9           "Retirement"
	10          "Health"
	11          "Other personal (Specify)"
;
label values pes1idk  pes1idk;
label define pes1idk
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Job is temporary"
	2           "Business conditions"
	3           "Introduction of new"
	4           "Other economic (Specify)"
	5           "Job performance"
	6           "Obtaining another job"
	7           "Attending school"
	8           "Family responsibilities"
	9           "Retirement"
	10          "Health"
	11          "Other personal (Specify)"
;
label values pes1iin  pes1iin;
label define pes1iin
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Job is temporary"
	2           "Business conditions"
	3           "Introduction of new"
	4           "Other economic (Specify)"
	5           "Job performance"
	6           "Obtained another job"
	7           "Went back to school"
	8           "Family responsibilities"
	9           "Retirement"
	10          "Health"
	11          "Other personal (Specify)"
;
label values pes1j1   pes1j1l;
label define pes1j1l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes1j2   pes1j2l;
label define pes1j2l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes2ins  pes2ins;
label define pes2ins
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes2     pes2l;
label define pes2l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes2ains pes2ains;
label define pes2ains
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes2a    pes2a;
label define pes2a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes3     pes3l;
label define pes3l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Place where temporary help"
	2           "Temporary help agency"
;
label values pes3a    pes3a;
label define pes3a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Government agency"
	2           "Private company"
	3           "Non-profit organization"
;
label values pes3icd  pes3icd;
label define pes3icd
	-1          "Not in Universe"
	999         "No response"
;
label values prs3dicd prs3dicd;
label define prs3dicd
	-1          "Not in Universe"
	1           "GOODS PRODUCING-"
	2           "GOODS PRODUCING-OTHER"
	3           "MINING"
	4           "CONSTRUCTION"
	5           "MFG-LUMBER & WOOD PRODS, EX"
	6           "MFG-FURNITURE & FIXTURES"
	7           "MFG-STONE, CLAY, CONCRETE,"
	8           "MFG-PRIMARY METALS"
	9           "MFG-FABRICATMETALS"
	10          "MFG-NOT SPECIFIED METAL"
	11          "MFG-MACHINERY, EX"
	12          "MFG-ELECTRICAL MACHINERY,"
	13          "MFG-MOTOR VEHICLES & EQUIP"
	14          "MFG-AIRCRAFT & PARTS"
	15          "MFG-OTHER TRANSPORTATION"
	16          "MFG-PROFESSIONAL & PHOTO"
	17          "MFG-TOYS, AMUSEMENT &"
	18          "MFG-MISC & NEC MFG"
	19          "MFG-FOOD & KINDRED PRODS"
	20          "MFG-TOBACCO PRODS"
	21          "MFG-TEXTILE MILL PRODS"
	22          "MFG-APPAREL & OTHER"
	23          "MFG-PAPER & ALLIED PRODUCTS"
	24          "MFG-PRINTING, PUBLISHING &"
	25          "MFG-CHEMICALS & ALLIED"
	26          "MFG-PETROLEUM & COAL PRODS"
	27          "MFG-RUBBER & MISC PLASTIC"
	28          "MFG-LEATHER & LEATHER PRODS"
	29          "TRANSPORTATION"
	30          "COMMUNICATIONS"
	31          "UTILITIES & SANITARY"
	32          "WHOLESALE TRADE"
	33          "EATING AND DRINKING PLACES"
	34          "OTHER RETAIL TRADE"
	35          "BANKING AND OTHER FINANCE"
	36          "INSURANCE AND REAL ESTATE"
	37          "PRIVATE HOUSEHOLD SERVICES"
	38          "BUSINESS SERVICES"
	39          "AUTOMOBILE AND REPAIR"
	40          "PERSONAL SERV EXC PRIVATE"
	41          "ENTERTAINMENT & RECREATION"
	42          "HOSPITALS"
	43          "HEALTH SERVICES, EXC."
	44          "EDUCATIONAL SERVICES"
	45          "SOCIAL SERVICES"
	46          "OTHER PROFESSIONAL SERVICES"
	47          "FORESTRY & FISHERIES"
	48          "JUSTICE, PUBLIC ORDER &"
	49          "ADMIN OF HUMAN RESOURCE"
	50          "NATIONAL SECURITY &"
	51          "OTHER PUBLIC ADMINISTRATION"
	99          "No response"
;
label values pes3tads pes3tads;
label define pes3tads
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Temporary help agency"
	2           "Customer"
	3           "Both"
;
label values pes3tadt pes3tadt;
label define pes3tadt
	-9          "No response"
	-4          "Something else"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes3tad1 pes3tada;
label define pes3tada
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "As long as I want"
	2           "Until I retire"
	3           "Until I find a different job"
	4           "Until I finish school"
	5           "Until I go back to school"
	6           "Other"
;
label values pes3tada pes3tadx;
label define pes3tadx
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes3tadb pes3tadb;
label define pes3tadb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes4     pes4l;
label define pes4l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes4a    pes4a;
label define pes4a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Work regular hours,"
	2           "Only work when called"
	3           "Other (Specify)"
;
label values pes5     pes5l;
label define pes5l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes6     pes6l;
label define pes6l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes6a    pes6a;
label define pes6a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes6b    pes6b;
label define pes6b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Don't have a usual worksite"
;
label values pes6io   pes6io;
label define pes6io
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Company that contracts out"
	2           "Customer for whom do the work"
;
label values pes6ioa  pes6ioa;
label define pes6ioa
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Government agency"
	2           "Private company"
	3           "Non-profit organization"
;
label values pes6icd  pes6icd;
label define pes6icd
	-1          "Not in Universe"
	999         "No response"
;
label values prs6dicd prs6dicd;
label define prs6dicd
	-1          "Not in Universe"
	1           "GOODS PRODUCING-AGRICULTURAL"
	2           "GOODS PRODUCING-OTHER"
	3           "MINING"
	4           "CONSTRUCTION"
	5           "MFG-LUMBER & WOOD PRODS, EX"
	6           "MFG-FURNITURE & FIXTURES"
	7           "MFG-STONE, CLAY, CONCRETE,"
	8           "MFG-PRIMARY METALS"
	9           "MFG-FABRICATMETALS"
	10          "MFG-NOT SPECIFIED METAL"
	11          "MFG-MACHINERY, EX ELECTRICAL"
	12          "MFG-ELECTRICAL MACHINERY,"
	13          "MFG-MOTOR VEHICLES & EQUIP"
	14          "MFG-AIRCRAFT & PARTS"
	15          "MFG-OTHER TRANSPORTATION"
	16          "MFG-PROFESSIONAL & PHOTO"
	17          "MFG-TOYS, AMUSEMENT & SPORTING"
	18          "MFG-MISC & NEC MFG INDUSTRIES"
	19          "MFG-FOOD & KINDRED PRODS"
	20          "MFG-TOBACCO PRODS"
	21          "MFG-TEXTILE MILL PRODS"
	22          "MFG-APPAREL & OTHER FINISHED"
	23          "MFG-PAPER & ALLIED PRODUCTS"
	24          "MFG-PRINTING, PUBLISHING &"
	25          "MFG-CHEMICALS & ALLIED PRODS"
	26          "MFG-PETROLEUM & COAL PRODS"
	27          "MFG-RUBBER & MISC PLASTIC"
	28          "MFG-LEATHER & LEATHER PRODS"
	29          "TRANSPORTATION"
	30          "COMMUNICATIONS"
	31          "UTILITIES & SANITARY SERVICES"
	32          "WHOLESALE TRADE"
	33          "EATING AND DRINKING PLACES"
	34          "OTHER RETAIL TRADE"
	35          "BANKING AND OTHER FINANCE"
	37          "PRIVATE HOUSEHOLD SERVICES"
	38          "BUSINESS SERVICES"
	39          "AUTOMOBILE AND REPAIR SERVICES"
	40          "PERSONAL SERV EXC PRIVATE"
	41          "ENTERTAINMENT & RECREATION"
	42          "HOSPITALS"
	43          "HEALTH SERVICES, EXC."
	44          "EDUCATIONAL SERVICES"
	45          "SOCIAL SERVICES"
	46          "OTHER PROFESSIONAL SERVICES"
	47          "FORESTRY & FISHERIES"
	48          "JUSTICE, PUBLIC ORDER & SAFETY"
	49          "ADMIN OF HUMAN RESOURCE"
	50          "NATIONAL SECURITY & INTERNAL"
	51          "OTHER PUBLIC ADMINISTRATION"
	99          "No response"
;
label values pes7ccds pes7ccds;
label define pes7ccds
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Contract company"
	2           "Customer"
	3           "Both"
;
label values pes7ccdt pes7ccdt;
label define pes7ccdt
	-9          "No response"
	-4          "Something else"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes7ccd1 pes7ccda;
label define pes7ccda
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "As long as I want"
	2           "Until I retire"
	3           "Until I find other employment"
	4           "Until I finish school"
	5           "Until I go back to school"
	6           "Other"
;
label values pes7ccda pes7ccdx;
label define pes7ccdx
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes7ccdb pes7ccdb;
label define pes7ccdb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes7     pes7l;
label define pes7l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes8icds pes8icds;
label define pes8icds
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Independent contractor"
	2           "Customer"
	3           "Both"
;
label values pes8icdt pes8icdt;
label define pes8icdt
	-9          "No response"
	-4          "Something else"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes8icd1 pes8icda;
label define pes8icda
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "As long as I want"
	2           "Until I retire"
	3           "Until I find other employment"
	4           "Until I finish school"
	5           "Until I go back to school"
	6           "Other"
;
label values pes8icda pes8icdx;
label define pes8icdx
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes8icdb pes8icdb;
label define pes8icdb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes8ic   pes8ic;
label define pes8ic
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Independent contractor/"
	2           "Something else"
;
label values pes8sedt pes8sedt;
label define pes8sedt
	-9          "No response"
	-4          "Something else"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes8sed1 pes8seda;
label define pes8seda
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "As long as I want"
	2           "Until I retire"
	3           "Until I find other employment"
	4           "No longer self employed"
	5           "Other"
;
label values pes8seda pes8sedx;
label define pes8sedx
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes8sedb pes8sedb;
label define pes8sedb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes9a    pes9a;
label define pes9a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes9b    pes9b;
label define pes9b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes10tim pes10tim;
label define pes10tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes10num pes10num;
label define pes10num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes10npr pes10npr;
label define pes10npr
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes10wst pes10wst;
label define pes10wst
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes10wsn pes10wsn;
label define pes10wsn
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes10wpr pes10wpr;
label define pes10wpr
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes11    pes11l;
label define pes11l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes12    pes12l;
label define pes12l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes12a   pes12a;
label define pes12a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Attending to personal or"
	2           "Going to school"
	3           "In retirement"
	4           "Other"
;
label values pes13    pes13l;
label define pes13l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes14    pes14l;
label define pes14l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Lost job"
	2           "Quit job"
	3           "Temporary job that ended"
	4           "Other"
;
label values pes15tim pes15tim;
label define pes15tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes15num pes15num;
label define pes15num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes16    pes16l;
label define pes16l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Government"
	2           "Private for profit company"
	3           "Non-profit organization"
	4           "Self-employed"
;
label values pes17icd pes17icd;
label define pes17icd
	-1          "Not in Universe"
	999         "No response"
;
label values prs17idd prs17idd;
label define prs17idd
	-1          "Not in Universe"
	1           "GOODS PRODUCING-AGRICULTURAL"
	2           "GOODS PRODUCING-OTHER"
	3           "MINING"
	4           "CONSTRUCTION"
	5           "MFG-LUMBER & WOOD PRODS, EX"
	6           "MFG-FURNITURE & FIXTURES"
	7           "MFG-STONE, CLAY, CONCRETE,"
	8           "MFG-PRIMARY METALS"
	9           "MFG-FABRICATMETALS"
	10          "MFG-NOT SPECIFIED METAL"
	11          "MFG-MACHINERY, EX ELECTRICAL"
	12          "MFG-ELECTRICAL MACHINERY,"
	13          "MFG-MOTOR VEHICLES & EQUIP"
	14          "MFG-AIRCRAFT & PARTS"
	15          "MFG-OTHER TRANSPORTATION"
	16          "MFG-PROFESSIONAL & PHOTO"
	17          "MFG-TOYS, AMUSEMENT & SPORTING"
	18          "MFG-MISC & NEC MFG INDUSTRIES"
	19          "MFG-FOOD & KINDRED PRODS"
	20          "MFG-TOBACCO PRODS"
	21          "MFG-TEXTILE MILL PRODS"
	22          "MFG-APPAREL & OTHER FINISHED"
	23          "MFG-PAPER & ALLIED PRODUCTS"
	24          "MFG-PRINTING, PUBLISHING &"
	25          "MFG-CHEMICALS & ALLIED PRODS"
	26          "MFG-PETROLEUM & COAL PRODS"
	27          "MFG-RUBBER & MISC PLASTIC"
	28          "MFG-LEATHER & LEATHER PRODS"
	29          "TRANSPORTATION"
	30          "COMMUNICATIONS"
	31          "UTILITIES & SANITARY SERVICES"
	32          "WHOLESALE TRADE"
	33          "EATING AND DRINKING PLACES"
	34          "OTHER RETAIL TRADE"
	35          "BANKING AND OTHER FINANCE"
	36          "INSURANCE AND REAL ESTATE"
	37          "PRIVATE HOUSEHOLD SERVICES"
	38          "BUSINESS SERVICES"
	39          "AUTOMOBILE AND REPAIR SERVICES"
	40          "PERSONAL SERV EXC PRIVATE"
	41          "ENTERTAINMENT & RECREATION"
	42          "HOSPITALS"
	43          "HEALTH SERVICES, EXC."
	44          "EDUCATIONAL SERVICES"
	45          "SOCIAL SERVICES"
	46          "OTHER PROFESSIONAL SERVICES"
	47          "FORESTRY & FISHERIES"
	48          "JUSTICE, PUBLIC ORDER & SAFETY"
	49          "ADMIN OF HUMAN RESOURCE"
	50          "NATIONAL SECURITY & INTERNAL"
	51          "OTHER PUBLIC ADMINISTRATION"
	99          "No response"
;
label values pes25a   pes25a;
label define pes25a
	-9          ".No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends (Specify)"
;
label values pes25ar  pes25ar;
label define pes25ar
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employed laid off and hired"
	2           "Only type or work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Other family/personal"
	7           "Child care problems"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience/training"
	11          "Only wanted to work for a"
	12          "For the money"
	13          "Health limitations"
	14          "Retired/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes25ap  pes25ap;
label define pes25ap
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employer laid off and hired"
	2           "Only type of work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Other family/personal"
	7           "Child care problems"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience/training"
	11          "Only wanted to work for a"
	13          "Health limitations"
	14          "Retired/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes25b   pes25b;
label define pes25b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends"
;
label values pes26tp  pes26tp;
label define pes26tp
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends"
;
label values pes26tr  pes26tr;
label define pes26tr
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employer laid off and hired"
	2           "Only type of work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Child care problems"
	7           "Other family/personal"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience/training"
	11          "Only wanted to work for a"
	12          "For the money"
	13          "Health limitations"
	14          "Retire/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes26to  pes26to;
label define pes26to
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employer laid off and hired"
	2           "Only type of work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Child care problems"
	7           "Other family/personal"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience/training"
	11          "Only wanted to work for a"
	13          "Health limitations"
	14          "Retired/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes26oc  pes26oc;
label define pes26oc
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends"
;
label values pes26or  pes26or;
label define pes26or
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Only type of work could find"
	2           "Hope job leads to permanent"
	3           "Other economic (Specify)"
	4           "Flexibility of schedule"
	5           "Child care problems"
	6           "Other family/personal"
	7           "In school/training"
	8           "Money is better"
	9           "To obtain experience/training"
	10          "For the money"
	11          "Health limitations"
	12          "Retired/SS earnings limit"
	13          "Nature of work/seasonal"
	14          "Other personal (Specify)"
;
label values pes26op  pes26op;
label define pes26op
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Only type of work could find"
	2           "Hope job leads to permanent"
	3           "Other economic (Specify)"
	4           "Flexibility of schedule"
	5           "Child care problems"
	6           "Other family/personal"
	7           "In school/training"
	8           "Money is better"
	9           "To obtain experience/training"
	11          "Health limitations"
	12          "Retired/SS earnings limit"
	13          "Nature of work/seasonal"
	14          "Other personal (Specify)"
;
label values pes26dl  pes26dl;
label define pes26dl
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends"
;
label values pes26dr  pes26dr;
label define pes26dr
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Only type of work could find"
	2           "Hope job leads to permanent"
	3           "Other economic (Specify)"
	4           "Flexibility of schedule"
	5           "Child care problems"
	6           "Other family/personal"
	7           "In school/training"
	8           "Money is better"
	9           "To obtain experience/training"
	10          "For the money"
	11          "Health limitations"
	12          "Retired/SS earnings limit"
	13          "Nature of work/seasonal"
	14          "Other personal (Specify)"
;
label values pes26dp  pes26dp;
label define pes26dp
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Only type of work could find"
	2           "Hope job leads to permanent"
	3           "Other economic (Specify)"
	4           "Flexibility of schedule"
	5           "Child care problems"
	6           "Other family/personal"
	7           "In school/training"
	8           "Money is better"
	9           "To obtain experience/training"
	11          "Health limitations"
	12          "Retired/SS earnings limit"
	13          "Nature of work/seasonal"
	14          "Other personal (Specify)"
;
label values pes26ic  pes26ic;
label define pes26ic
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
	3           "Depends"
;
label values pes26ir  pes26ir;
label define pes26ir
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employer laid off and hired"
	2           "Only type of work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Child care problems"
	7           "Other family/personal"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience/training"
	11          "Enjoys being own"
	12          "For the money"
	13          "Health limitations"
	14          "Retired/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes26ip  pes26ip;
label define pes26ip
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Employer laid off and hired"
	2           "Only type of work could find"
	3           "Hope job leads to permanent"
	4           "Other economic (Specify)"
	5           "Flexibility of schedule"
	6           "Other family/personal"
	7           "Child care problems"
	8           "In school/training"
	9           "Money is better"
	10          "To obtain experience training"
	11          "Enjoys being own boss/"
	13          "Health limitations"
	14          "Retired/SS earnings limit"
	15          "Nature of work/seasonal"
	16          "Other personal (Specify)"
;
label values pes28    pes28l;
label define pes28l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes29    pes29l;
label define pes29l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes30tim pes30tim;
label define pes30tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes30num pes30num;
label define pes30num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes31tmt pes31tmt;
label define pes31tmt
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes31tmn pes31tmn;
label define pes31tmn
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes31tim pes31tim;
label define pes31tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes31num pes31num;
label define pes31num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes32tim pes32tim;
label define pes32tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes32num pes32num;
label define pes32num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes33tim pes33tim;
label define pes33tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes33num pes33num;
label define pes33num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes35tim pes35tim;
label define pes35tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes35num pes35num;
label define pes35num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes36tim pes36tim;
label define pes36tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes36num pes36num;
label define pes36num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes36ctm pes36ctm;
label define pes36ctm
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes36cnm pes36cnm;
label define pes36cnm
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes36dlt pes36dlt;
label define pes36dlt
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes36dln pes36dln;
label define pes36dln
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes36prb pes36prb;
label define pes36prb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes37    pes37l;
label define pes37l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes37ic  pes37ic;
label define pes37ic
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes37ica pes37ica;
label define pes37ica
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes37a   pes37a;
label define pes37a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Just before started working"
	2           "Break in service"
;
label values pes37bti pes37bti;
label define pes37bti
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes37bnu pes37bnu;
label define pes37bnu
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes38    pes38l;
label define pes38l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes39    pes39l;
label define pes39l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes40    pes40l;
label define pes40l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Attending to personal or"
	2           "Going to school"
	3           "In retirement"
	4           "Other (specify)"
;
label values pes42    pes42l;
label define pes42l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes43    pes43l;
label define pes43l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Lost job"
	2           "Quit job"
	3           "Temporary job that ended"
	4           "Other"
;
label values pes44tim pes44tim;
label define pes44tim
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Years"
	2           "Months"
	3           "Weeks"
	4           "Days"
;
label values pes44num pes44num;
label define pes44num
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
;
label values pes44a   pes44a;
label define pes44a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Government"
	2           "Private for Profit Company"
	3           "Non-profit Organization"
	4           "Self employed"
;
label values pes44icd pes44icd;
label define pes44icd
	-1          "Not in Universe"
	999         "No response"
;
label values prs44idd prs44idd;
label define prs44idd
	-1          "Not in Universe"
	1           "GOODS PRODUCING-AGRICULTURAL"
	2           "GOODS PRODUCING-OTHER"
	3           "MINING"
	4           "CONSTRUCTION"
	5           "MFG-LUMBER & WOOD PRODS, EX"
	6           "MFG-FURNITURE & FIXTURES"
	7           "MFG-STONE, CLAY, CONCRETE,"
	8           "MFG-PRIMARY METALS"
	9           "MFG-FABRICATMETALS"
	10          "MFG-NOT SPECIFIED METAL"
	11          "MFG-MACHINERY, EX ELECTRICAL"
	12          "MFG-ELECTRICAL MACHINERY,"
	13          "MFG-MOTOR VEHICLES & EQUIP"
	14          "MFG-AIRCRAFT & PARTS"
	15          "MFG-OTHER TRANSPORTATION"
	16          "MFG-PROFESSIONAL & PHOTO"
	17          "MFG-TOYS, AMUSEMENT & SPORTING"
	18          "MFG-MISC & NEC MFG INDUSTRIES"
	19          "MFG-FOOD & KINDRED PRODS"
	20          "MFG-TOBACCO PRODS"
	21          "MFG-TEXTILE MILL PRODS"
	22          "MFG-APPAREL & OTHER FINISHED"
	23          "MFG-PAPER & ALLIED PRODUCTS"
	24          "MFG-PRINTING, PUBLISHING &"
	25          "MFG-CHEMICALS & ALLIED PRODS"
	26          "MFG-PETROLEUM & COAL PRODS"
	27          "MFG-RUBBER & MISC PLASTIC"
	28          "MFG-LEATHER & LEATHER PRODS"
	29          "TRANSPORTATION"
	30          "COMMUNICATIONS"
	31          "UTILITIES & SANITARY SERVICES"
	32          "WHOLESALE TRADE"
	33          "EATING AND DRINKING PLACES"
	34          "OTHER RETAIL TRADE"
	35          "BANKING AND OTHER FINANCE"
	36          "INSURANCE AND REAL ESTATE"
	37          "PRIVATE HOUSEHOLD SERVICES"
	38          "BUSINESS SERVICES"
	39          "AUTOMOBILE AND REPAIR SERVICES"
	40          "PERSONAL SERV EXC PRIVATE"
	41          "ENTERTAINMENT & RECREATION"
	42          "HOSPITALS"
	43          "HEALTH SERVICES, EXC."
	44          "EDUCATIONAL SERVICES"
	45          "SOCIAL SERVICES"
	46          "OTHER PROFESSIONAL SERVICES"
	47          "FORESTRY & FISHERIES"
	48          "JUSTICE, PUBLIC ORDER & SAFETY"
	49          "ADMIN OF HUMAN RESOURCE"
	50          "NATIONAL SECURITY & INTERNAL"
	51          "OTHER PUBLIC ADMINISTRATION"
	99          "No response"
;
label values pes45a   pes45a;
label define pes45a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes45sea pes45sea;
label define pes45sea
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes45dl  pes45dl;
label define pes45dl
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes45b   pes45b;
label define pes45b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes45seb pes45seb;
label define pes45seb
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes46    pes46l;
label define pes46l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "New job"
	2           "Additional job or second job"
;
label values pes46tmp pes46tmp;
label define pes46tmp
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Temporary/short term"
	2           "More long term"
	3           "Either"
;
label values pes46ta  pes46ta;
label define pes46ta
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes46cw  pes46cw;
label define pes46cw
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes46ocd pes46ocd;
label define pes46ocd
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes47a   pes47a;
label define pes47a
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47b   pes47b;
label define pes47b
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47c   pes47c;
label define pes47c
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47d   pes47d;
label define pes47d
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47e   pes47e;
label define pes47e
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47f   pes47f;
label define pes47f
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47g   pes47g;
label define pes47g
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47h   pes47h;
label define pes47h
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47i   pes47i;
label define pes47i
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47j   pes47j;
label define pes47j
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47k   pes47k;
label define pes47k
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47l   pes47l;
label define pes47l
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes47m   pes47m;
label define pes47m
	-9          "No response"
	-3          "Refused"
	-2          "Don't know"
	-1          "Not in universe"
	1           "employer directly/interview"
	2           "public employment agency"
	3           "private employment agency"
	4           "friends or relatives"
	5           "school/university employment"
	6           "sent out resumes/filled out"
	7           "checked union/professional"
	8           "placed or answered ads"
	9           "other active"
	10          "looked at ads"
	11          "attended job training"
	12          "other passive"
	13          "nothing"
;
label values pes48    pes48l;
label define pes48l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
	1           "Temporary/Short term"
	2           "More long term"
	3           "Either/Anything I can find"
;
label values pes48dis pes48dis;
label define pes48dis
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Temporary/Short term"
	2           "More long term"
	3           "Either/Anything I can find"
;
label values pes49    pes49l;
label define pes49l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes50    pes50l;
label define pes50l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes50a   pes50a;
label define pes50a
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes51    pes51l;
label define pes51l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "All"
	2           "Part"
	3           "None"
;
label values pes52a   pes52a;
label define pes52a
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Receive health insurance"
	2           "Spouse's health insurance"
	3           "Other family member's"
	4           "Receive health insurance"
	5           "Receive health insurance"
	6           "Purchased insurance on your"
	7           "Medicare"
	8           "Medicaid"
	9           "Labor union"
	10          "Association or club"
	11          "School or university"
	12          "Other-specify"
;
label values pes53    pes53l;
label define pes53l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes54    pes54l;
label define pes54l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes55    pes55l;
label define pes55l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Covered by another plan"
	2           "Traded health insurance for"
	3           "Too expensive"
	4           "Don't need health insurance"
	5           "Have a pre-existing condition"
	6           "Haven't yet worked for this"
	7           "Contract or temporary"
	8           "Other-specify"
;
label values pes56    pes56l;
label define pes56l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Don't work enough hours per"
	2           "Contract or temporary"
	3           "Haven't worked for this"
	4           "Have a pre-existing condition"
	5           "Too expensive"
	6           "Other-specify"
;
label values pes57    pes57l;
label define pes57l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes58    pes58l;
label define pes58l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes59    pes59l;
label define pes59l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pes60    pes60l;
label define pes60l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Poor investment"
	2           "Too expensive/can't afford it"
	3           "No one in my type of job is"
	4           "Don't work enough hours per"
	5           "Haven't worked for this"
	6           "Too old"
	7           "Too young"
	8           "Chose not to participate"
	9           "Other-specify"
;
label values pes61    pes61l;
label define pes61l
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pesxper  pesxper;
label define pesxper
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
	1           "Hourly"
	2           "Weekly"
	3           "Bi-Weekly"
	4           "Twice Monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other-specify"
;
label values pesxb    pesxb;
label define pesxb
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
	1           "Yes"
	2           "No"
;
label values pesxh1o  pesxh1o;
label define pesxh1o
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
;
label values ptsxh1o  ptsxh1o;
label define ptsxh1o
	0           "No topcode"
	1           "Topcoded value"
;
label values pesxc1   pesxc1l;
label define pesxc1l
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
;
label values pusxotp  pusxotp;
label define pusxotp
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in universe"
	1           "Per hour"
	2           "Per day"
	3           "Per week"
	4           "Per month"
	5           "Per year"
	6           "Other"
;
label values pusxd1a  pusxd1a;
label define pusxd1a
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
;
label values pusxd1b  pusxd1b;
label define pusxd1b
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
;
label values pusxf    pusxf;
label define pusxf
	-9          "No response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
;
label values pesxi    pesxi;
label define pesxi
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
	1           "Yes"
	2           "No"
;
label values pesxj    pesxj;
label define pesxj
	-9          "No Response"
	-3          "Refused"
	-2          "Don't Know"
	-1          "Not in Universe"
	1           "Yes"
	2           "No"
;
label values ptsernx  ptsernx;
label define ptsernx
	0           "No Topcode"
	1           "Topcoded Value"
;
label values ptsern2x ptsern2x;
label define ptsern2x
	0           "No Topcode"
	1           "Topcoded Value"
;
label values pesxhry  pesxhry;
label define pesxhry
	1           "Hourly status"
	2           "Nonhourly status"
;
label values prcondf1 prcondfa;
label define prcondfa
	0           "Employed persons who do not"
;
label values prcondf2 prcondfb;
label define prcondfb
	0           "Employed individuals who do not"
	1           "All persons who met the"
;
label values prcondf3 prcondfc;
label define prcondfc
	0           "Employed individuals who did"
	1           "Wage and salary workers whose"
;
label values prtmpagc prtmpagc;
label define prtmpagc
	0           "Not paid by temporary help"
	1           "Persons paid by temporary help"
;
label values pric     pric;
label define pric
	0           "Not independent contractor,"
	1           "Wage and salary worker and self"
;
label values prcntrct prcntrct;
label define prcntrct
	0           "Not working for a contract"
;
label values prcall   prcall;
label define prcall
	0           "Not on call or day laborer"
	1           "Individual is either an on call"
;
label values psio1cow psio1cow;
label define psio1cow
	1           "Government - Federal"
	2           "Government - State"
	3           "Government - Local"
	4           "Private, for profit"
	5           "Private, nonprofit"
	6           "Self-employed, incorporated"
	7           "Self-employed, unincorporated"
	8           "Without pay"
	9           "Unknown"
	10          "Government, level unknown"
	11          "Self-employed, incorp. status"
;
label values prsuptyp prsuptyp;
label define prsuptyp
	1           "Interview"
	2           "Noninterview"
;
label values prsupern prsupern;
label define prsupern
	-1          "Not in universe"
	1           "Eligible for earnings"
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
