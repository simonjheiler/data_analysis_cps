local in_file `1'
local out_file `2'
local data_dict `3'
local variables `4'

/*------------------------------------------------
  developed by Jean Roth
  edited by Simon Heiler Thu Jul 02 18:00:00 CEST 2020
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http://www.gnu.org/licenses/ for details.
----------------------------------------------- */

/* The following line should contain the path to the raw data file */

local dat_name `in_file'

/* The following line should contain the path to the data dictionary file */

local dct_name `data_dict'

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

*Everything below this point, aside from the final save, are value labels

#delimit ;

;
label values hufinal  hufinal;
label define hufinal
	0           "NEW INTERVIEW - NOT CONTACTED"
	1           "FULLY COMPLETE CATI INTERVIEW"
	2           "PARTIALLY COMPLETED CATI INTERVIEW"
	5           "LABOR FORCE COMPLETE, SUPPLEMENT INCOMPLETE - CATI"
	24          "HH OCCUPIED ENTIRELY BY ARMED FORCES MEMBERS"
	115         "PARTIAL INTERVIEW WITH CALLBACK PLANNED - CATI"
	200         "NEW INTERVIEW - CONTACTED"
	201         "CAPI COMPLETE"
	202         "CALLBACK NEEDED"
	203         "SUFFICIENT PARTIAL - PRECLOSEOUT"
	204         "SUFFICIENT PARTIAL - AT CLOSEOUT"
	205         "LABOR FORCE COMPLETE, - SUPPL. INCOMPLETE - CAPI"
	210         "CAPI COMPLETE REINTERVIEW"
	216         "NO ONE HOME"
	217         "TEMPORARILY ABSENT"
	218         "REFUSED"
	219         "OTHER OCCUPIED - SPECIFY"
	224         "ARMED FORCES OCCUPIED OR UNDER AGE 14"
	225         "TEMP. OCCUPIED W/PERSONS WITH URE"
	226         "VACANT REGULAR"
	227         "VACANT - STORAGE OF HHLD FURNITURE"
	228         "UNFIT, TO BE DEMOLISHED"
	229         "UNDER CONSTRUCTION, NOT READY"
	230         "CONVERTED TO TEMP BUSINESS OR STORAGE"
	231         "UNOCCUPIED TENT OR TRAILER SITE"
	232         "PERMIT GRANTED - CONSTRUCTION NOT STARTED"
	233         "OTHER - SPECIFY"
	240         "DEMOLISHED"
	241         "HOUSE OR TRAILER MOVED"
	242         "OUTSIDE SEGMENT"
	243         "CONVERTED TO PERM. BUSINESS OR STORAGE"
	244         "MERGED"
	245         "CONDEMNED"
	246         "BUILT AFTER APRIL 1, 1980"
	247         "UNUSED SERIAL NO./LISTING SHEET LINE"
	248         "OTHER - SPECIFY"
;
label values huspnish huspnish;
label define huspnish
	1           "SPANISH ONLY LANGUAGE SPOKEN"
;
label values hetenure hetenure;
label define hetenure
	1           "OWNED OR BEING BOUGHT BY A HH MEMBER"
	2           "RENTED FOR CASH"
	3           "OCCUPIED WITHOUT PAYMENT OF CASH RENT"
;
label values hehousut hehousut;
label define hehousut
	0           "OTHER UNIT"
	1           "HOUSE, APARTMENT, FLAT"
	2           "HU IN NONTRANSIENT HOTEL, MOTEL, ETC."
	3           "HU PERMANENT IN TRANSIENT HOTEL, MOTEL"
	4           "HU IN ROOMING HOUSE"
	5           "MOBILE HOME OR TRAILER W/NO PERM. ROOM ADDED"
	6           "MOBILE HOME OR TRAILER W/1 OR MORE PERM. ROOMS ADDED"
	7           "HU NOT SPECIFIED ABOVE"
	8           "QUARTERS NOT HU IN ROOMING OR BRDING HS"
	9           "UNIT NOT PERM. IN TRANSIENT HOTL, MOTL"
	10          "UNOCCUPIED TENT SITE OR TRLR SITE"
	11          "STUDENT QUARTERS IN COLLEGE DORM"
	12          "OTHER UNIT NOT SPECIFIED ABOVE"
;
label values hetelhhd hetelhhd;
label define hetelhhd
	1           "YES"
	2           "NO"
;
label values hetelavl hetelavl;
label define hetelavl
	1           "YES"
	2           "NO"
;
label values hephoneo hephoneo;
label define hephoneo
	1           "YES"
	2           "NO"
;
label values hufaminc hufaminc;
label define hufaminc
	1           "LESS THAN $5,000"
	2           "5,000 TO 7,499"
	3           "7,500 TO 9,999"
	4           "10,000 TO 12,499"
	5           "12,500 TO 14,999"
	6           "15,000 TO 19,999"
	7           "20,000 TO 24,999"
	8           "25,000 TO 29,999"
	9           "30,000 TO 34,999"
	10          "35,000 TO 39,999"
	11          "40,000 TO 49,999"
	12          "50,000 TO 59,999"
	13          "60,000 TO 74,999"
	14          "75,000 TO 99,999"
	15          "100,000 TO 149,999"
	16          "150,000 OR MORE"
;
label values hutypea  hutypea;
label define hutypea
	1           "NO ONE HOME (NOH)"
	2           "TEMPORARILY ABSENT (TA)"
	3           "REFUSED (REF)"
	4           "OTHER OCCUPIED - SPECIFY"
;
label values hutypb   hutypb;
label define hutypb
	1           "VACANT REGULAR"
	2           "TEMPORARILY OCCUPIED BY PERSONS W/ URE"
	3           "VACANT-STORAGE OF HHLD FURNITURE"
	4           "UNFIT OR TO BE DEMOLISHED"
	5           "UNDER CONSTRUCTION, NOT READY"
	6           "CONVERTED TO TEMP BUSINESS OR STORAGE"
	7           "UNOCCUPIED TENT SITE OR TRAILER SITE"
	8           "PERMIT GRANTED CONSTRUCTION NOT STARTED"
	9           "OTHER TYPE B - SPECIFY"
;
label values hutypc   hutypc;
label define hutypc
	1           "DEMOLISHED"
	2           "HOUSE OR TRAILER MOVED"
	3           "OUTSIDE SEGMENT"
	4           "CONVERTED TO PERM. BUSINESS OR STORAGE"
	5           "MERGED"
	6           "CONDEMNED"
	8           "UNUSED LINE OF LISTING SHEET"
	9           "OTHER - SPECIFY"
;
label values hrintsta hrintsta;
label define hrintsta
	1           "INTERVIEW"
	2           "TYPE A NON-INTERVIEW"
	3           "TYPE B NON-INTERVIEW"
	4           "TYPE C NON-INTERVIEW"
;
label values hrhtype  hrhtype;
label define hrhtype
	0           "NON-INTERVIEW HOUSEHOLD"
	1           "HUSBAND/WIFE PRIMARY FAMILY (NEITHER AF)"
	2           "HUSB/WIFE PRIM. FAMILY (EITHER/BOTH AF)"
	3           "UNMARRIED CIVILIAN MALE-PRIM. FAM HHLDER"
	4           "UNMARRIED CIV. FEMALE-PRIM FAM HHLDER"
	5           "PRIMARY FAMILY HHLDER-RP IN AF, UNMAR."
	6           "CIVILIAN MALE PRIMARY INDIVIDUAL"
	7           "CIVILIAN FEMALE PRIMARY INDIVIDUAL"
	8           "PRIMARY INDIVIDUAL HHLD-RP IN AF"
	9           "GROUP QUARTERS WITH FAMILY"
	10          "GROUP QUARTERS WITHOUT FAMILY"
;
label values huinttyp huinttyp;
label define huinttyp
	0           "NONINTERVIEW/INDETERMINATE"
	1           "PERSONAL"
	2           "TELEPHONE"
;
label values hrlonglk hrlonglk;
label define hrlonglk
	0           "MIS 1 OR REPLACEMENT HH (NO LINK)"
	2           "MIS 2-4 OR MIS 6-8"
	3           "MIS 5"
;
label values hubus    hubus;
label define hubus
	1           "YES"
	2           "NO"
;
label values gereg    gereg;
label define gereg
	1           "NORTHEAST"
	2           "MIDWEST (FORMERLY NORTH CENTRAL)"
	3           "SOUTH"
	4           "WEST"
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
label values gtcbsa   gtcbsa;
label define gtcbsa
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
;
label values gtco     gtco;
label define gtco
	0           "NOT IDENTIFIED"
;
label values gtcbsast gtcbsast;
label define gtcbsast
	1           "PRINCIPAL CITY"
	2           "BALANCE"
	3           "NONMETROPOLITAN"
	4           "NOT IDENTIFIED"
;
label values gtmetsta gtmetsta;
label define gtmetsta
	1           "METROPOLITAN"
	2           "NONMETROPOLITAN"
	3           "NOT IDENTIFIED"
;
label values gtindvpc gtindvpc;
label define gtindvpc
	0           "NOT IDENTIFIED, NONMETROPOLITAN,"
;
label values gtcbsasz gtcbsasz;
label define gtcbsasz
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
	2           "100,000 - 249,999"
	3           "250,000 - 499,999"
	4           "500,000 - 999,999"
	5           "1,000,000 - 2,499,999"
	6           "2,500,000 - 4,999,999"
	7           "5,000,000+"
;
label values gtcsa    gtcsa;
label define gtcsa
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
;
label values proldrrp proldrrp;
label define proldrrp
	1           "REF PERS WITH OTHER RELATIVES IN HH"
	2           "REF PERS WITH NO OTHER RELATIVES IN HH"
	3           "SPOUSE"
	4           "CHILD"
	5           "GRANDCHILD"
	6           "PARENT"
	7           "BROTHER/SISTER"
	8           "OTHER RELATIVE"
	9           "FOSTER CHILD"
	10          "NON-REL OF REF PER W/OWN RELS IN HH"
	11          "PARTNER/ROOMMATE"
	12          "NON-REL OF REF PER W/NO OWN RELS IN HH"
;
label values pupelig  pupelig;
label define pupelig
	1           "ELIGIBLE FOR INTERVIEW"
	2           "LABOR FORCE FULLY COMPLETE"
	3           "MISSING LABOR FORCE DATA FOR PERSON"
	4           "(NOT USED)"
	5           "ASSIGNED IF AGE IS BLANK"
	6           "ARMED FORCES MEMBER"
	7           "UNDER 15 YEARS OLD"
	8           "NOT A HH MEMBER"
	9           "DELETED"
	10          "DECEASED"
	11          "END OF LIST"
	12          "AFTER END OF LIST"
;
label values perrp    perrp;
label define perrp
	1           "REFERENCE PERSON W/RELS."
	2           "REFERENCE PERSON W/O RELS."
	3           "SPOUSE"
	4           "CHILD"
	5           "GRANDCHILD"
	6           "PARENT"
	7           "BROTHER/SISTER"
	8           "OTHER REL. OR REF. PERSON"
	9           "FOSTER CHILD"
	10          "NONREL. OF REF. PERSON W/RELS."
	11          "NOT USED"
	12          "NONREL. OF REF. PERSON W/O RELS."
	13          "UNMARRIED PARTNER W/RELS."
	14          "UNMARRIED PARTNER W/OUT RELS."
	15          "HOUSEMATE/ROOMMATE W/RELS."
	16          "HOUSEMATE/ROOMMATE W/OUT RELS."
	17          "ROOMER/BOARDER W/RELS."
	18          "ROOMER/BOARDER W/OUT RELS."
;
label values peparent peparent;
label define peparent
	-1          "NO PARENT"
;
/*
label values peage    peage;
label define peage
	80          "80-84 Years Old"
	85          "85+ Years Old"
;
*/
label values prtfage  prtfage;
label define prtfage
	0           "NO TOP CODE"
	1           "TOP CODED VALUE FOR AGE"
;
label values pemaritl pemaritl;
label define pemaritl
	1           "MARRIED - SPOUSE PRESENT"
	2           "MARRIED - SPOUSE ABSENT"
	3           "WIDOWED"
	4           "DIVORCED"
	5           "SEPARATED"
	6           "NEVER MARRIED"
;
label values pespouse pespouse;
label define pespouse
	-1          "NO SPOUSE"
;
label values pesex    pesex;
label define pesex
	1           "MALE"
	2           "FEMALE"
;
label values peafever peafever;
label define peafever
	1           "YES"
	2           "NO"
;
label values peafnow  peafnow;
label define peafnow
	1           "YES"
	2           "NO"
;
label values peeduca  peeduca;
label define peeduca
	31          "LESS THAN 1ST GRADE"
	32          "1ST, 2ND, 3RD OR 4TH GRADE"
	33          "5TH OR 6TH GRADE"
	34          "7TH OR 8TH GRADE"
	35          "9TH GRADE"
	36          "10TH GRADE"
	37          "11TH GRADE"
	38          "12TH GRADE NO DIPLOMA"
	39          "HIGH SCHOOL GRAD-DIPLOMA OR EQUIV (GED)"
	40          "SOME COLLEGE BUT NO DEGREE"
	41          "ASSOCIATE DEGREE-OCCUPATIONAL/VOCATIONAL"
	42          "ASSOCIATE DEGREE-ACADEMIC PROGRAM"
	43          "BACHELOR'S DEGREE (EX: BA, AB, BS)"
	44          "MASTER'S DEGREE (EX: MA, MS, MEng, MEd, MSW)"
	45          "PROFESSIONAL SCHOOL DEG (EX: MD, DDS, DVM)"
	46          "DOCTORATE DEGREE (EX: PhD, EdD)"
;
label values ptdtrace ptdtrace;
label define ptdtrace
	1           "White Only"
	2           "Black Only"
	3           "American Indian, Alaskan Native Only"
	4           "Asian Only"
	5           "Hawaiian/Pacific Islander Only"
	6           "White-Black"
	7           "White-AI"
	8           "White-Asian"
	9           "White-Hawaiian"
	10          "Black-AI"
	11          "Black-Asian"
	12          "Black-HP"
	13          "AI-Asian"
	14          "Asian-HP"
	15          "W-B-AI"
	16          "W-B-A"
	17          "W-AI-A"
	18          "W-A-HP"
	19          "W-B-AI-A"
	20          "2 or 3 Races"
	21          "4 or 5 Races"
;
label values prdthsp  prdthsp;
label define prdthsp
	1           "Mexican"
	2           "Puerto Rican"
	3           "Cuban"
	4           "Central/South American"
	5           "Other Spanish"
;
label values puchinhh puchinhh;
label define puchinhh
	1           "PERSON ADDED"
	2           "PERSON ADDED - URE"
	3           "PERSON UNDELETED"
	4           "PERSON DIED"
	5           "DELETED FOR REASON OTHER THAN DEATH"
	6           "PERSON JOINED ARMED FORCES"
	7           "PERSON NO LONGER IN AF"
	9           "CHANGE IN DEMOGRAPHIC INFORMATION"
;
label values prfamnum prfamnum;
label define prfamnum
	0           "NOT A FAMILY MEMBER"
	1           "PRIMARY FAMILY MEMBER ONLY"
	2           "SUBFAMILY NO. 2 MEMBER"
	3           "SUBFAMILY NO. 3 MEMBER"
	4           "SUBFAMILY NO. 4 MEMBER"
	5           "SUBFAMILY NO. 5 MEMBER"
	6           "SUBFAMILY NO. 6 MEMBER"
	7           "SUBFAMILY NO. 7 MEMBER"
	8           "SUBFAMILY NO. 8 MEMBER"
	9           "SUBFAMILY NO. 9 MEMBER"
	10          "SUBFAMILY NO. 10 MEMBER"
	11          "SUBFAMILY NO. 11 MEMBER"
	12          "SUBFAMILY NO. 12 MEMBER"
	13          "SUBFAMILY NO. 13 MEMBER"
	14          "SUBFAMILY NO. 14 MEMBER"
	15          "SUBFAMILY NO. 15 MEMBER"
	16          "SUBFAMILY NO. 16 MEMBER"
	17          "SUBFAMILY NO. 17 MEMBER"
	18          "SUBFAMILY NO. 18 MEMBER"
	19          "SUBFAMILY NO. 19 MEMBER"
;
label values prfamrel prfamrel;
label define prfamrel
	0           "NOT A FAMILY MEMBER"
	1           "REFERENCE PERSON"
	2           "SPOUSE"
	3           "CHILD"
	4           "OTHER RELATIVE (PRIMARY FAMILY & UNREL)"
;
label values prfamtyp prfamtyp;
label define prfamtyp
	1           "PRIMARY FAMILY"
	2           "PRIMARY INDIVIDUAL"
	3           "RELATED SUBFAMILY"
	4           "UNRELATED SUBFAMILY"
	5           "SECONDARY INDIVIDUAL"
;
label values pehspnon pehspnon;
label define pehspnon
	1           "HISPANIC"
	2           "NON-HIPSANIC"
;
label values prmarsta prmarsta;
label define prmarsta
	1           "MARRIED, CIVILIAN SPOUSE PRESENT"
	2           "MARRIED, ARMED FORCES SPOUSE PRESENT"
	3           "MARRIED, SPOUSE ABSENT (EXC. SEPARATED)"
	4           "WIDOWED"
	5           "DIVORCED"
	6           "SEPARATED"
	7           "NEVER MARRIED"
;
label values prpertyp prpertyp;
label define prpertyp
	1           "CHILD HOUSEHOLD MEMBER"
	2           "ADULT CIVILIAN HOUSEHOLD MEMBER"
	3           "ADULT ARMED FORCES HOUSEHOLD MEMBER"
;
label values penatvty penatvty;
label define penatvty
	57          "UNITED STATES"
	72          "PUERTO RICO"
	96          "U.S. OUTLYING AREA"
	555         "ABROAD, COUNTRY NOT KNOWN"
;
label values pemntvty pemntvty;
label define pemntvty
	57          "UNITED STATES"
	72          "PUERTO RICO"
	96          "U.S. OUTLYING AREA"
	555         "ABROAD, COUNTRY NOT KNOWN"
;
label values pefntvty pefntvty;
label define pefntvty
	57          "UNITED STATES"
	72          "PUERTO RICO"
	96          "U.S. OUTLYING AREA"
	555         "ABROAD, COUNTRY NOT KNOWN"
;
label values prcitshp prcitshp;
label define prcitshp
	1           "NATIVE, BORN IN THE UNITED STATES"
	2           "NATIVE, BORN IN PUERTO RICO OR U.S. OUTLYING AREA"
	3           "NATIVE, BORN ABROAD OF AMERICAN PARENT OR PARENTS"
	4           "FOREIGN BORN, U.S. CITIZEN BY NATURALIZATION"
	5           "FOREIGN BORN, NOT A CITIZEN OF THE UNITED STATES"
;
label values prinusyr prinusyr;
label define prinusyr
	-1          "NOT IN UNIVERSE (BORN IN U.S.)"
	0           "NOT FOREIGN BORN"
	1           "BEFORE 1950"
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
	1           "SELF"
	2           "PROXY"
	3           "BOTH SELF AND PROXY"
;
label values pemlr    pemlr;
label define pemlr
	1           "EMPLOYED-AT WORK"
	2           "EMPLOYED-ABSENT"
	3           "UNEMPLOYED-ON LAYOFF"
	4           "UNEMPLOYED-LOOKING"
	5           "NOT IN LABOR FORCE-RETIRED"
	6           "NOT IN LABOR FORCE-DISABLED"
	7           "NOT IN LABOR FORCE-OTHER"
;
label values puwk     puwk;
label define puwk
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pubus1   pubus1l;
label define pubus1l
	1           "YES"
	2           "NO"
;
label values pubus2ot pubus2ot;
label define pubus2ot
	1           "YES"
	2           "NO"
;
label values pubusck1 pubuscka;
label define pubuscka
	1           "GOTO PUBUS1"
	2           "GOTO PURETCK1"
;
label values pubusck2 pubusckb;
label define pubusckb
	1           "GOTO PUHRUSL1"
	2           "GOTO PUBUS2"
;
label values pubusck3 pubusckc;
label define pubusckc
	1           "GOTO PUABSRSN"
	2           "GOTO PULAY"
;
label values pubusck4 pubusckd;
label define pubusckd
	1           "GOTO PUHRUSL1"
	2           "GOTO PUABSPD"
;
label values puretot  puretot;
label define puretot
	1           "YES"
	2           "NO"
	3           "WAS NOT RETIRED LAST MONTH"
;
label values pudis    pudis;
label define pudis
	1           "YES"
	2           "NO"
	3           "DID NOT HAVE DISABILITY LAST MONTH"
;
label values peret1   peret1l;
label define peret1l
	1           "YES"
	2           "NO"
	3           "HAS A JOB"
;
label values pudis1   pudis1l;
label define pudis1l
	1           "YES"
	2           "NO"
;
label values pudis2   pudis2l;
label define pudis2l
	1           "YES"
	2           "NO"
;
label values puabsot  puabsot;
label define puabsot
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pulay    pulay;
label define pulay
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values peabsrsn peabsrsn;
label define peabsrsn
	1           "ON LAYOFF"
	2           "SLACK WORK/BUSINESS CONDITIONS"
	3           "WAITING FOR A NEW JOB TO BEGIN"
	4           "VACATION/PERSONAL DAYS"
	5           "OWN ILLNESS/INJURY/MEDICAL PROBLEMS"
	6           "CHILD CARE PROBLEMS"
	7           "OTHER FAMILY/PERSONAL OBLIGATION"
	8           "MATERNITY/PATERNITY LEAVE"
	9           "LABOR DISPUTE"
	10          "WEATHER AFFECTED JOB"
	11          "SCHOOL/TRAINING"
	12          "CIVIC/MILITARY DUTY"
	13          "DOES NOT WORK IN THE BUSINESS"
	14          "OTHER (SPECIFY)"
;
label values peabspdo peabspdo;
label define peabspdo
	1           "YES"
	2           "NO"
;
label values pemjot   pemjot;
label define pemjot
	1           "YES"
	2           "NO"
;
label values pemjnum  pemjnum;
label define pemjnum
	2           "2 JOBS"
	3           "3 JOBS"
	4           "4 OR MORE JOBS"
;
label values pehrusl1 pehrusla;
label define pehrusla
	-4          "HOURS VARY"
;
label values pehrusl2 pehruslb;
label define pehruslb
	-4          "HOURS VARY"
;
label values pehrftpt pehrftpt;
label define pehrftpt
	1           "YES"
	2           "NO"
	3           "HOURS VARY"
;
label values pehruslt pehruslt;
label define pehruslt
	-4          "VARIES"
;
label values pehrwant pehrwant;
label define pehrwant
	1           "YES"
	2           "NO"
	3           "REGULAR HOURS ARE FULL-TIME"
;
label values pehrrsn1 pehrrsna;
label define pehrrsna
	1           "SLACK WORK/BUSINESS CONDITIONS"
	2           "COULD ONLY FIND PART-TIME WORK"
	3           "SEASONAL WORK"
	4           "CHILD CARE PROBLEMS"
	5           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	6           "HEALTH/MEDICAL LIMITATIONS"
	7           "SCHOOL/TRAINING"
	8           "RETIRED/SOCIAL SECURITY LIMIT ON EARNINGS"
	9           "FULL-TIME WORKWEEK IS LESS THAN 35 HRS"
	10          "OTHER - SPECIFY"
;
label values pehrrsn2 pehrrsnb;
label define pehrrsnb
	1           "CHILD CARE PROBLEMS"
	2           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	3           "HEALTH/MEDICAL LIMITATIONS"
	4           "SCHOOL/TRAINING"
	5           "RETIRED/SOCIAL SECURITY LIMIT ON EARNINGS"
	6           "FULL-TIME WORKWEEK LESS THAN 35 HOURS"
	7           "OTHER - SPECIFY"
;
label values pehrrsn3 pehrrsnc;
label define pehrrsnc
	1           "SLACK WORK/BUSINESS CONDITIONS"
	2           "SEASONAL WORK"
	3           "JOB STARTED OR ENDED DURING WEEK"
	4           "VACATION/PERSONAL DAY"
	5           "OWN ILLNESS/INJURY/MEDICAL APPOINTMENT"
	6           "HOLIDAY (LEGAL OR RELIGIOUS)"
	7           "CHILD CARE PROBLEMS"
	8           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	9           "LABOR DISPUTE"
	10          "WEATHER AFFECTED JOB"
	11          "SCHOOL/TRAINING"
	12          "CIVIC/MILITARY DUTY"
	13          "OTHER REASON"
;
label values puhroff1 puhroffa;
label define puhroffa
	1           "YES"
	2           "NO"
;
label values puhrot1  puhrot1l;
label define puhrot1l
	1           "YES"
	2           "NO"
;
label values pehravl  pehravl;
label define pehravl
	1           "YES"
	2           "NO"
;
label values puhrck1  puhrck1l;
label define puhrck1l
	1           "GOTO PUHRUSL2"
	2           "GOTO PUHRUSLT"
;
label values puhrck2  puhrck2l;
label define puhrck2l
	1           "IF ENTRY OF 1 IN MJ AND"
	2           "IF ENTRY OF 1 IN MJ AND ENTRY"
	3           "IF ENTRY OF 2, D OR R IN MJ"
	4           "IF ENTRY OF 1 IN BUS1 AND ENTRY"
	5           "ALL OTHERS GOTO HRCK3-C"
;
label values puhrck3  puhrck3l;
label define puhrck3l
	1           "IF ENTRY OF 1 IN ABSOT OR"
	2           "IF ENTRY OF 3 IN RET1 GOTO HRCK8"
	3           "IF ENTRY IN HRUSLT IS 0-34 HOURS GOTO HRCK4-C"
	4           "IF ENTRY IN HRUSLT IS 35+ GOTO HROFF1"
	5           "ALL OTHERS GOTO HRCK4-C"
	6           "GOTO PUHRCK4"
;
label values puhrck4  puhrck4l;
label define puhrck4l
	1           "IF ENTRY OF 1, D, R OR V"
	2           "IF ENTRY OF 2, D OR R IN BUS2 THEN GOTO HROFF1"
	3           "IF HRUSLT IS 0-34 THEN GOTO HRWANT"
	4           "IF ENTRY OF 2 IN HRFTPT THEN GOTO HRWANT"
	5           "ALL OTHERS GOTO HRACT1"
;
label values puhrck5  puhrck5l;
label define puhrck5l
	1           "IF ENTRY OF 1 IN MJOT GOTO HRACT2"
	2           "ALL OTHERS GOTO HRCK6-C"
;
label values puhrck6  puhrck6l;
label define puhrck6l
	1           "IF HRACT1 AND HRACT2 EQ 0 AND"
	2           "IF HRACT1 AND HRACT2 EQ 0 THEN"
	3           "ALL OTHERS GOTO HRACTT-C"
;
label values puhrck7  puhrck7l;
label define puhrck7l
	1           "(IF ENTRY OF 2, D OR R IN BUS2) AND"
	2           "(IF ENTRY OF 2, D OR R IN BUS2) AND"
	3           "(IF HRUSLT IS 35+ OR IF ENTRY OF 1 IN HRFTPT)"
	4           "IF ENTRY OF 1 IN HRWANT AND HRACTT <35"
	5           "ALL OTHERS GOTO HRCK8"
;
label values puhrck12 puhrck1b;
label define puhrck1b
	1           "IF ENTRY OF 2, D OR R IN BUS2"
	2           "ALL OTHERS GOTO IOCK1"
;
label values pulaydt  pulaydt;
label define pulaydt
	1           "YES"
	2           "NO"
;
label values pulay6m  pulay6m;
label define pulay6m
	1           "YES"
	2           "NO"
;
label values pelayavl pelayavl;
label define pelayavl
	1           "YES"
	2           "NO"
;
label values pulayavr pulayavr;
label define pulayavr
	1           "OWN TEMPORARY ILLNESS"
	2           "GOING TO SCHOOL"
	3           "OTHER"
;
label values pelaylk  pelaylk;
label define pelaylk
	1           "YES"
	2           "NO"
;
label values pelayfto pelayfto;
label define pelayfto
	1           "YES"
	2           "NO"
;
label values pulayck1 pulaycka;
label define pulaycka
	1           "GOTO PULAYCK3"
	2           "GOTO PULAYFT"
	3           "GOTO PULAYDR"
;
label values pulayck2 pulayckb;
label define pulayckb
	1           "GOTO PULAYDR3"
	2           "GOTO PULAYFT"
;
label values pulayck3 pulayckc;
label define pulayckc
	1           "MISCK = 5 GOTO IO1INT"
	2           "I-ICR = 1 OR I-OCR = 1, GOTO IO1INT"
	3           "ALL OTHERS GOTO SCHCK"
;
label values pulk     pulk;
label define pulk
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pelkm1   pelkm1l;
label define pelkm1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkm2   pulkm2l;
label define pulkm2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm3   pulkm3l;
label define pulkm3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm4   pulkm4l;
label define pulkm4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm5   pulkm5l;
label define pulkm5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm6   pulkm6l;
label define pulkm6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk1  pulkdk1l;
label define pulkdk1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkdk2  pulkdk2l;
label define pulkdk2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk3  pulkdk3l;
label define pulkdk3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk4  pulkdk4l;
label define pulkdk4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk5  pulkdk5l;
label define pulkdk5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk6  pulkdk6l;
label define pulkdk6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps1  pulkps1l;
label define pulkps1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkps2  pulkps2l;
label define pulkps2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps3  pulkps3l;
label define pulkps3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps4  pulkps4l;
label define pulkps4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps5  pulkps5l;
label define pulkps5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps6  pulkps6l;
label define pulkps6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PULBIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pelkavl  pelkavl;
label define pelkavl
	1           "YES"
	2           "NO"
;
label values pulkavr  pulkavr;
label define pulkavr
	1           "WAITING FOR NEW JOB TO BEGIN"
	2           "OWN TEMPORARY ILLNESS"
	3           "GOING TO SCHOOL"
	4           "OTHER - SPECIFY"
;
label values pelkll1o pelkll1o;
label define pelkll1o
	1           "WORKING"
	2           "SCHOOL"
	3           "LEFT MILITARY SERVICE"
	4           "SOMETHING ELSE"
;
label values pelkll2o pelkll2o;
label define pelkll2o
	1           "LOST JOB"
	2           "QUIT JOB"
	3           "TEMPORARY JOB ENDED"
;
label values pelklwo  pelklwo;
label define pelklwo
	1           "WITHIN THE LAST 12 MONTHS"
	2           "MORE THAN 12 MONTHS AGO"
	3           "NEVER WORKED"
;
label values pelkfto  pelkfto;
label define pelkfto
	1           "YES"
	2           "NO"
	3           "DOESN'T MATTER"
;
label values pedwwnto pedwwnto;
label define pedwwnto
	1           "YES, OR MAYBE, IT DEPENDS"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE"
;
label values pedwrsn  pedwrsn;
label define pedwrsn
	1           "BELIEVES NO WORK AVAILABLE IN AREA OF EXPERTISE"
	2           "COULDN'T FIND ANY WORK"
	3           "LACKS NECESSARY SCHOOLING/TRAINING"
	4           "EMPLOYERS THINK TOO YOUNG OR TOO OLD"
	5           "OTHER TYPES OF DISCRIMINATION"
	6           "CAN'T ARRANGE CHILD CARE"
	7           "FAMILY RESPONSIBILITIES"
	8           "IN SCHOOL OR OTHER TRAINING"
	9           "ILL-HEALTH, PHYSICAL DISABILITY"
	10          "TRANSPORTATION PROBLEMS"
	11          "OTHER - SPECIFY"
;
label values pedwlko  pedwlko;
label define pedwlko
	1           "YES"
	2           "NO"
;
label values pedwwk   pedwwk;
label define pedwwk
	1           "YES"
	2           "NO"
;
label values pedw4wk  pedw4wk;
label define pedw4wk
	1           "YES"
	2           "NO"
;
label values pedwlkwk pedwlkwk;
label define pedwlkwk
	1           "YES"
	2           "NO"
;
label values pedwavl  pedwavl;
label define pedwavl
	1           "YES"
	2           "NO"
;
label values pedwavr  pedwavr;
label define pedwavr
	1           "OWN TEMPORARY ILLNESS"
	2           "GOING TO SCHOOL"
	3           "OTHER"
;
label values pudwck1  pudwck1l;
label define pudwck1l
	1           "IF ENTRY OF 2 IN BUS2 GOTO PUSCHCK"
	2           "IF ENTRY OF 3 ON ABSRSN GOTO PUNLFCK1"
	3           "IF ENTRY OF 1 IN RET1, STORE 1 IN DWWNTO"
	4           "ALL OTHERS GOTO PUDWWNT"
;
label values pudwck2  pudwck2l;
label define pudwck2l
	1           "IF ENTRY IN DIS1 OR DIS2 GOTO PUJHCK1-C"
	2           "IF ENTRY OF 4 IN DWWNT GOTO PUDIS1"
	3           "IF ENTRY OF 5 IN DWWNT GOTO PUDIS2"
	4           "ALL OTHERS GOTO PUDWCK4"
;
label values pudwck3  pudwck3l;
label define pudwck3l
	1           "IF AGERNG EQUALS 1-4 OR 9 GOTO PUDWCK4"
	2           "ALL OTHERS GOTO PUNLFCK2"
;
label values pudwck4  pudwck4l;
label define pudwck4l
	1           "IF ENTRY OF 10 AND/OR 11 AND/OR 13"
	2           "IF ENTRY OF 10 AND/OR 11 AND/OR 13"
	3           "IF ENTRY OF 10 AND/OR 11 AND/OR 13"
	4           "ALL OTHERS GOTO PUDWRSN"
;
label values pudwck5  pudwck5l;
label define pudwck5l
	1           "IF ENTRY OF 1 IN LK THEN STORE 1"
	2           "ALL OTHERS GOTO PUDWLK"
;
label values pejhwko  pejhwko;
label define pejhwko
	1           "YES"
	2           "NO"
;
label values pujhdp1o pujhdp1o;
label define pujhdp1o
	1           "YES"
	2           "NO"
;
label values pejhrsn  pejhrsn;
label define pejhrsn
	1           "PERSONAL/FAMILY (INCLUDING PREGNANCY)"
	2           "RETURN TO SCHOOL"
	3           "HEALTH"
	4           "RETIREMENT OR OLD AGE"
	5           "TEMP, SEASONAL OR INTERMITTENT JOB COMPLETE"
	6           "SLACK WORK/BUSINESS CONDITIONS"
	7           "UNSATISFACTORY WORK ARRANGEMENTS (HRS, PAY, ETC.)"
	8           "OTHER - SPECIFY"
;
label values pejhwant pejhwant;
label define pejhwant
	1           "YES, OR IT DEPENDS"
	2           "NO"
;
label values pujhck1  pujhck1l;
label define pujhck1l
	1           "PURET1 = 1, -2, OR -3"
	2           "IF MISCK EQUALS 4 OR 8"
	3           "ALL OTHERS GOTO PUNLFCK1"
;
label values pujhck2  pujhck2l;
label define pujhck2l
	1           "IF ENTRY OF 1 IN DWWK AND I-MLR= 3, 4"
	2           "IF ENTRY OF 2, D OR R IN DWWK THEN STORE DWWK IN"
	3           "ALL OTHERS GOTO PUJHWK"
;
label values prabsrea prabsrea;
label define prabsrea
	1           "FT PAID-VACATION"
	2           "FT PAID-OWN ILLNESS"
	3           "FT PAID-CHILD CARE PROBLEMS"
	4           "FT PAID-OTHER FAMILY/PERSONAL OBLIG."
	5           "FT PAID-MATERNITY/PATERNITY LEAVE"
	6           "FT PAID-LABOR DISPUTE"
	7           "FT PAID-WEATHER AFFECTED JOB"
	8           "FT PAID-SCHOOL/TRAINING"
	9           "FT PAID-CIVIC/MILITARY DUTY"
	10          "FT PAID-OTHER"
	11          "FT UNPAID-VACATION"
	12          "FT UNPAID-OWN ILLNESS"
	13          "FT UNPAID-CHILD CARE PROBLEMS"
	14          "FT UNPAID-OTHER FAM/PERSONAL OBLIGATION"
	15          "FT UNPAID-MATERNITY/PATERNITY LEAVE"
	16          "FT UNPAID-LABOR DISPUTE"
	17          "FT UNPAID-WEATHER AFFECTED JOB"
	18          "FT UNPAID-SCHOOL/TRAINING"
	19          "FT UNPAID-CIVIC/MILITARY DUTY"
	20          "FT UNPAID-OTHER"
	21          "PT PAID-VACATION"
	22          "PT PAID-OWN ILLNESS"
	23          "PT PAID-CHILD CARE PROBLEMS"
	24          "PT PAID-OTHER FAMILY/PERSONAL OBLIG."
	25          "PT PAID-MATERNITY/PATERNITY LEAVE"
	26          "PT PAID-LABOR DISPUTE"
	27          "PT PAID-WEATHER AFFECTED JOB"
	28          "PT PAID-SCHOOL/TRAINING"
	29          "PT PAID-CIVIC/MILITARY DUTY"
	30          "PT PAID-OTHER"
	31          "PT UNPAID-VACATION"
	32          "PT UNPAID-OWN ILLNESS"
	33          "PT UNPAID-CHILD CARE PROBLEMS"
	34          "PT UNPAID-OTHER FAM/PERSONAL OBLIGATION"
	35          "PT UNPAID-MATERNITY/PATERNITY LEAVE"
	36          "PT UNPAID-LABOR DISPUTE"
	37          "PT UNPAID-WEATHER AFFECTED JOB"
	38          "PT UNPAID-SCHOOL/TRAINING"
	39          "PT UNPAID-CIVIC/MILITARY DUTY"
	40          "PT UNPAID-OTHER"
;
label values prcivlf  prcivlf;
label define prcivlf
	1           "IN CIVILIAN LABOR FORCE"
	2           "NOT IN CIVILIAN LABOR FORCE"
;
label values prdisc   prdisc;
label define prdisc
	1           "DISCOURAGED WORKER"
	2           "CONDITIONALLY INTERESTED"
	3           "NOT AVAILABLE"
;
label values premphrs premphrs;
label define premphrs
	0           "UNEMPLOYED AND NILF"
	1           "W/JOB, NOT AT WORK-ILLNES"
	2           "W/JOB, NOT AT WORK-VACATION"
	3           "W/JOB, NOT AT WORK-WEATHER AFFECTED JOB"
	4           "W/JOB, NOT AT WORK-LABOR DISPUTE"
	5           "W/JOB, NOT AT WORK-CHILD CARE PROBLEMS"
	6           "W/JOB, NOT AT WORK-FAM/PERS OBLIGATION"
	7           "W/JOB, NOT AT WORK-MATERNITY/PATERNITY"
	8           "W/JOB, NOT AT WORK-SCHOOL/TRAINING"
	9           "W/JOB, NOT AT WORK-CIVIC/MILITARY DUTY"
	10          "W/JOB, NOT AT WORK-DOES NOT WORK IN BUS"
	11          "W/JOB, NOT AT WORK-OTHER"
	12          "AT WORK- 1-4 HRS"
	13          "AT WORK- 5-14 HRS"
	14          "AT WORK- 15-21 HRS"
	15          "AT WORK- 22-29 HRS"
	16          "AT WORK- 30-34 HRS"
	17          "AT WORK- 35-39 HRS"
	18          "AT WORK- 40 HRS"
	19          "AT WORK- 41-47 HRS"
	20          "AT WORK- 48 HRS"
	21          "AT WORK- 49-59 HRS"
	22          "AT WORK- 60 HRS OR MORE"
;
label values prempnot prempnot;
label define prempnot
	1           "EMPLOYED"
	2           "UNEMPLOYED"
	3           "NOT IN LABOR FORCE (NILF)-discouraged"
	4           "NOT IN LABOR FORCE (NILF)-other"
;
label values prexplf  prexplf;
label define prexplf
	1           "EMPLOYED"
	2           "UNEMPLOYED"
;
label values prftlf   prftlf;
label define prftlf
	1           "FULL TIME LABOR FORCE"
	2           "PART TIME LABOR FORCE"
;
label values prhrusl  prhrusl;
label define prhrusl
	1           "0-20 HRS"
	2           "21-34 HRS"
	3           "35-39 HRS"
	4           "40 HRS"
	5           "41-49 HRS"
	6           "50 OR MORE HRS"
	7           "VARIES-FULL TIME"
	8           "VARIES-PART TIME"
;
label values prjobsea prjobsea;
label define prjobsea
	1           "LOOKED LAST 12 MONTHS, SINCE COMPLETING PREVIOUS JOB"
	2           "LOOKED AND WORKED IN THE LAST 4 WEEKS"
	3           "LOOKED LAST 4 WEEKS - LAYOFF"
	4           "UNAVAILABLE JOB SEEKERS"
	5           "NO RECENT JOB SEARCH"
;
label values prpthrs  prpthrs;
label define prpthrs
	0           "USUALY FT, PT FOR NONECONOMIC REASONS"
	1           "USU.FT, PT ECON REASONS; 1-4 HRS"
	2           "USU.FT, PT ECON REASONS; 5-14 HRS"
	3           "USU.FT, PT ECON REASONS; 15-29 HRS"
	4           "USU.FT, PT ECON REASONS; 30-34 HRS"
	5           "USU.PT, ECON REASONS; 1-4 HRS"
	6           "USU.PT, ECON REASONS; 5-14 HRS"
	7           "USU.PT, ECON REASONS; 15-29 HRS"
	8           "USU.PT, ECON REASONS; 30-34 HRS"
	9           "USU.PT, NON-ECON REASONS; 1-4 HRS"
	10          "USU.PT, NON-ECON REASONS; 5-14 HRS"
	11          "USU.PT, NON-ECON REASONS; 15-29 HRS"
	12          "USU.PT, NON-ECON REASONS; 30-34 HRS"
;
label values prptrea  prptrea;
label define prptrea
	1           "USU. FT-SLACK WORK/BUSINESS CONDITIONS"
	2           "USU. FT-SEASONAL WORK"
	3           "USU. FT-JOB STARTED/ENDED DURING WEEK"
	4           "USU. FT-VACATION/PERSONAL DAY"
	5           "USU. FT-OWN ILLNESS/INJURY/MEDICAL APPOINTMENT"
	6           "USU. FT-HOLIDAY (RELIGIOUS OR LEGAL)"
	7           "USU. FT-CHILD CARE PROBLEMS"
	8           "USU. FT-OTHER FAM/PERS OBLIGATIONS"
	9           "USU. FT-LABOR DISPUTE"
	10          "USU. FT-WEATHER AFFECTED JOB"
	11          "USU. FT-SCHOOL/TRAINING"
	12          "USU. FT-CIVIC/MILITARY DUTY"
	13          "USU. FT-OTHER REASON"
	14          "USU. PT-SLACK WORK/BUSINESS CONDITIONS"
	15          "USU. PT-COULD ONLY FIND PT WORK"
	16          "USU. PT-SEASONAL WORK"
	17          "USU. PT-CHILD CARE PROBLEMS"
	18          "USU. PT-OTHER FAM/PERS OBLIGATIONS"
	19          "USU. PT-HEALTH/MEDICAL LIMITATIONS"
	20          "USU. PT-SCHOOL/TRAINING"
	21          "USU. PT-RETIRED/S.S. LIMIT ON EARNINGS"
	22          "USU. PT-WORKWEEK <35 HOURS"
	23          "USU. PT-OTHER REASON"
;
label values pruntype pruntype;
label define pruntype
	1           "JOB LOSER/ON LAYOFF"
	2           "OTHER JOB LOSER"
	3           "TEMPORARY JOB ENDED"
	4           "JOB LEAVER"
	5           "RE-ENTRANT"
	6           "NEW-ENTRANT"
;
label values prwksch  prwksch;
label define prwksch
	0           "NOT IN LABOR FORCE"
	1           "AT WORK"
	2           "WITH JOB, NOT AT WORK"
	3           "UNEMPLOYED, SEEKS FT"
	4           "UNEMPLOYED, SEEKS PT"
;
label values prwkstat prwkstat;
label define prwkstat
	1           "NOT IN LABOR FORCE"
	2           "FT HOURS (35+), USUALLY FT"
	3           "PT FOR ECONOMIC REASONS, USUALLY FT"
	4           "PT FOR NON-ECONOMIC REASONS, USUALLY FT"
	5           "NOT AT WORK, USUALLY FT"
	6           "PT HRS, USUALLY PT FOR ECONOMIC REASONS"
	7           "PT HRS, USUALLY PT FOR NON-ECONOMIC REASONS"
	8           "FT HOURS, USUALLY PT FOR ECONOMIC REASONS"
	9           "FT HOURS, USUALLY PT FOR NON-ECONOMIC"
	10          "NOT AT WORK, USUALLY PART-TIME"
	11          "UNEMPLOYED FT"
	12          "UNEMPLOYED PT"
;
label values prwntjob prwntjob;
label define prwntjob
	1           "WANT A JOB"
	2           "OTHER NOT IN LABOR FORCE"
;
label values pujhck3  pujhck3l;
label define pujhck3l
	1           "IF I-MLR EQ 3 OR 4 THEN GOTO PUJHDP1"
	2           "ALL OTHERS GOTO PUJHRSN"
;
label values pujhck4  pujhck4l;
label define pujhck4l
	1           "IF ENTRY OF 2, D OR R IN PUDW4WK OR IN PUJHDP1O"
	2           "IF ENTRY OF 1 IN PUDW4WK OR IN PUJHDP10"
	3           "IF I-MLR EQUALS 1 OR 2 AND ENTRY IN"
	4           "IF ENTRY IN PUJHRSN THEN GOTO PUIO1INT"
	5           "ALL OTHERS GOTO PUNLFCK1"
;
label values pujhck5  pujhck5l;
label define pujhck5l
	1           "IF I-IO1ICR EQUALS 1 OR I-IO1OCR"
	2           "ALL OTHERS GOTO PUIOCK5"
;
label values puiodp1  puiodp1l;
label define puiodp1l
	1           "YES"
	2           "NO"
;
label values puiodp2  puiodp2l;
label define puiodp2l
	1           "YES"
	2           "NO"
;
label values puiodp3  puiodp3l;
label define puiodp3l
	1           "YES"
	2           "NO"
;
label values peio1cow peio1cow;
label define peio1cow
	1           "GOVERNMENT - FEDERAL"
	2           "GOVERNMENT - STATE"
	3           "GOVERNMENT - LOCAL"
	4           "PRIVATE, FOR PROFIT"
	5           "PRIVATE, NONPROFIT"
	6           "SELF-EMPLOYED, INCORPORATED"
	7           "SELF-EMPLOYED, UNINCORPORATED"
	8           "WITHOUT PAY"
;
label values puio1mfg puio1mfg;
label define puio1mfg
	1           "MANUFACTURING"
	2           "RETAIL TRADE"
	3           "WHOLESALE TRADE"
	4           "SOMETHING ELSE"
;
label values peio2cow peio2cow;
label define peio2cow
	1           "GOVERNMENT - FEDERAL"
	2           "GOVERNMENT - STATE"
	3           "GOVERNMENT - LOCAL"
	4           "PRIVATE, FOR PROFIT"
	5           "PRIVATE, NONPROFIT"
	6           "SELF-EMPLOYED, INCORPORATED"
	7           "SELF-EMPLOYED, UNINCORPORATED"
	8           "WITHOUT PAY"
	9           "UNKNOWN"
	10          "GOVERNMENT, LEVEL UNKNOWN"
	11          "SELF-EMPLOYED, INCORP. STATUS UNKNOWN"
;
label values puio2mfg puio2mfg;
label define puio2mfg
	1           "MANUFACTURING"
	2           "RETAIL TRADE"
	3           "WHOLESALE TRADE"
	4           "SOMETHING ELSE"
;
label values puiock1  puiock1l;
label define puiock1l
	1           "IF {MISCK EQ 1 OR 5)"
	2           "IF (MISCK EQ 1 OR 5)"
	3           "IF I-IO1NAM IS D, R OR BLANK THEN GOTO PUIO1INT"
	4           "ALL OTHERS GOTO PUIODP1"
;
label values puiock2  puiock2l;
label define puiock2l
	1           "IF I-IO1ICR EQ 1 THEN GOTO PUIO1IND"
	2           "IF I-IO1OCR EQ 1 THEN GOTO PUIO1OCC"
	3           "ALL OTHERS GOTO PUIODP2"
;
label values puiock3  puiock3l;
label define puiock3l
	1           "IF I-IO1OCC EQUALS D, R OR BLANK THEN GOTO PUIO1OCC"
	2           "IF I-IO1DT1 IS D, R OR BLANK THEN GOTO PUIO1OCC"
	3           "ALL OTHERS GOTO PUIODP3"
;
label values prioelg  prioelg;
label define prioelg
	0           "NOT ELIGIBLE FOR EDIT"
	1           "ELIGIBLE FOR EDIT"
;
label values pragna   pragna;
label define pragna
	1           "AGRICULTURAL"
	2           "NON-AGRICULTURAL"
;
label values prcow1   prcow1l;
label define prcow1l
	1           "FEDERAL GOVT"
	2           "STATE GOVT"
	3           "LOCAL GOVT"
	4           "PRIVATE (INCL. SELF-EMPLOYED INCORP.)"
	5           "SELF-EMPLOYED, UNINCORP."
	6           "WITHOUT PAY"
;
label values prcow2   prcow2l;
label define prcow2l
	1           "FEDERAL GOVT"
	2           "STATE GOVT"
	3           "LOCAL GOVT"
	4           "PRIVATE (INCL. SELF-EMPLOYED INCORP.)"
	5           "SELF-EMPLOYED, UNINCORP."
	6           "WITHOUT PAY"
;
label values prcowpg  prcowpg;
label define prcowpg
	1           "PRIVATE"
	2           "GOVERNMENT"
;
label values prdtcow1 prdtcowa;
label define prdtcowa
	1           "AGRI., WAGE & SALARY, PRIVATE"
	2           "AGRI., WAGE & SALARY, GOVERNMENT"
	3           "AGRI., SELF-EMPLOYED"
	4           "AGRI., UNPAID"
	5           "NONAG, WS, PRIVATE, PRIVATE HHLDS"
	6           "NONAG, WS, PRIVATE, OTHER PRIVATE"
	7           "NONAG, WS, GOVT, FEDERAL"
	8           "NONAG, WS, GOVT, STATE"
	9           "NONAG, WS, GOVT, LOCAL"
	10          "NONAG, SELF-EMPLOYED"
	11          "NONAG, UNPAID"
;
label values prdtcow2 prdtcowb;
label define prdtcowb
	1           "AGRI., WAGE & SALARY, PRIVATE"
	2           "AGRI., WAGE & SALARY, GOVERNMENT"
	3           "AGRI., SELF-EMPLOYED"
	4           "AGRI., UNPAID"
	5           "NONAG, WS, PRIVATE, PRIVATE HHLDS"
	6           "NONAG, WS, PRIVATE, OTHER PRIVATE"
	7           "NONAG, WS, GOVT, FEDERAL"
	8           "NONAG, WS, GOVT, STATE"
	9           "NONAG, WS, GOVT, LOCAL"
	10          "NONAG, SELF-EMPLOYED"
	11          "NONAG, UNPAID"
;
label values prdtind1 prdtinda;
label define prdtinda
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturing"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing services"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
;
label values prdtind2 prdtindb;
label define prdtindb
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturing"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing services"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
;
label values prdtocc1 prdtocca;
label define prdtocca
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media"
	10          "Healthcare practitioner and technical occupations"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupations"
	14          "Building and grounds cleaning and maintenance"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupations"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
;
label values prdtocc2 prdtoccb;
label define prdtoccb
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media"
	10          "Healthcare practitioner and technical occupations"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupations"
	14          "Building and grounds cleaning and maintenance"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupations"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
;
label values prmjind1 prmjinda;
label define prmjinda
	1           "Agriculture, forestry, fishing, and hunting"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing"
	5           "Wholesale and retail trade"
	6           "Transportation and utilities"
	7           "Information"
	8           "Financial activities"
	9           "Professional and business services"
	10          "Educational and health services"
	11          "Leisure and hospitality"
	12          "Other services"
	13          "Public administration"
	14          "Armed Forces"
;
label values prmjind2 prmjindb;
label define prmjindb
	1           "Agriculture, forestry, fishing, and hunting"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing"
	5           "Wholesale and retail trade"
	6           "Transportation and utilities"
	7           "Information"
	8           "Financial activities"
	9           "Professional and business services"
	10          "Educational and health services"
	11          "Leisure and hospitality"
	12          "Other services"
	13          "Public administration"
	14          "Armed Forces"
;
label values prmjocc1 prmjocca;
label define prmjocca
	1           "Management, business, and financial occupations"
	2           "Professional and related occupations"
	3           "Service occupations"
	4           "Sales and related occupations"
	5           "Office and administrative support occupations"
	6           "Farming, fishing, and forestry occupations"
	7           "Construction and extraction occupations"
	8           "Installation, maintenance, and repair occupations"
	9           "Production occupations"
	10          "Transportation and material moving occupations"
	11          "Armed Forces"
;
label values prmjocc2 prmjoccb;
label define prmjoccb
	1           "Management, business, and financial occupations"
	2           "Professional and related occupations"
	3           "Service occupations"
	4           "Sales and related occupations"
	5           "Office and administrative support occupations"
	6           "Farming, fishing, and forestry occupations"
	7           "Construction and extraction occupations"
	8           "Installation, maintenance, and repair occupations"
	9           "Production occupations"
	10          "Transportation and material moving occupations"
	11          "Armed Forces"
;
label values prmjocgr prmjocgr;
label define prmjocgr
	1           "Management, professional, and related occupations"
	2           "Service occupations"
	3           "Sales and office occupations"
	4           "Farming, fishing, and forestry occupations"
	5           "Construction, and maintenance occupations"
	6           "Production, transportation, and material moving"
	7           "Armed Forces"
;
label values prsjmj   prsjmj;
label define prsjmj
	1           "SINGLE JOBHOLDER"
	2           "MULTIPLE JOBHOLDER"
;
label values prerelg  prerelg;
label define prerelg
	0           "NOT ELIGIBLE FOR EDIT"
	1           "ELIGIBLE FOR EDIT"
;
label values peernuot peernuot;
label define peernuot
	1           "YES"
	2           "NO"
;
label values peernper peernper;
label define peernper
	1           "HOURLY"
	2           "WEEKLY"
	3           "BI-WEEKLY"
	4           "TWICE MONTHLY"
	5           "MONTHLY"
	6           "ANNUALLY"
	7           "OTHER - SPECIFY"
;
label values peernrt  peernrt;
label define peernrt
	1           "YES"
	2           "NO"
;
label values peernhry peernhry;
label define peernhry
	1           "HOURLY WORKER"
	2           "NONHOURLY WORKER"
;
label values pthr     pthr;
label define pthr
	0           "NOT TOPCODED"
	1           "TOPCODED"
;
label values ptot     ptot;
label define ptot
	0           "NOT TOPCODED"
	1           "TOPCODED"
;
label values peernlab peernlab;
label define peernlab
	1           "YES"
	2           "NO"
;
label values peerncov peerncov;
label define peerncov
	1           "YES"
	2           "NO"
;
label values penlfjh  penlfjh;
label define penlfjh
	1           "WITHIN THE LAST 12 MONTHS"
	2           "MORE THAN 12 MONTHS AGO"
	3           "NEVER WORKED"
;
label values penlfret penlfret;
label define penlfret
	1           "YES"
	2           "NO"
;
label values penlfact penlfact;
label define penlfact
	1           "DISABLED"
	2           "ILL"
	3           "IN SCHOOL"
	4           "TAKING CARE OF HOUSE OR FAMILY"
	5           "IN RETIREMENT"
	6           "SOMETHING ELSE/OTHER"
;
label values punlfck1 punlfcka;
label define punlfcka
	1           "IF AGERNG EQUALS 1-4 OR 9"
	2           "ALL OTHERS GOT NLFRET"
;
label values punlfck2 punlfckb;
label define punlfckb
	1           "IF MISCK EQUALS 4 OR 8 THEN GOTO NLFJH"
	2           "ALL OTHERS GOTO LBFR-END"
;
label values peschenr peschenr;
label define peschenr
	1           "YES"
	2           "NO"
;
label values peschft  peschft;
label define peschft
	1           "FULL-TIME"
	2           "PART-TIME"
;
label values peschlvl peschlvl;
label define peschlvl
	1           "HIGH SCHOOL"
	2           "COLLEGE OR UNIVERSITY"
;
label values prnlfsch prnlfsch;
label define prnlfsch
	1           "IN SCHOOL"
	2           "NOT IN SCHOOL"
;
label values prchld   prchld;
label define prchld
	-1          "NIU (Not a parent)"
	0           "No own children under 18 years of age"
	1           "All own children 0- 2 years of age"
	2           "All own children 3- 5 years of age"
	3           "All own children 6-13 years of age"
	4           "All own children 14-17 years of age"
	5           "Own children 0- 2 and 3- 5 years of age (none 6-17)"
	6           "Own children 0- 2 and 6-13 years of age (none 3- 5 or 14-17)"
	7           "Own children 0- 2 and 14-17 years of age (none 3-13)"
	8           "Own children 3- 5 and 6-13 years of age (none 0- 2 or 14-17)"
	9           "Own children 3- 5 and 14-17 years of age (none 0- 2 or 6-13)"
	10          "Own children 6-13 and 14-17 years of age (none 0- 5)"
	11          "Own children 0- 2, 3- 5, and 6-13 years of age (none 14-17)"
	12          "Own children 0- 2, 3- 5, and 14-17 years of age (none 6-13)"
	13          "Own children 0- 2, 6-13, and 14-17 years of age (none 3- 5)"
	14          "Own children 3- 5, 6-13, and 14-17 years of age (none 0- 2)"
	15          "Own children from all age groups"
;
label values prnmchld prnmchld;
label define prnmchld
	-1          "NIU (Not a parent)"
;
label values pedipged pedipged;
label define pedipged
	-1          "Not in universe"
	1           "Graduation from high school"
	2           "GED or other equivalent"
;
label values pehgcomp pehgcomp;
label define pehgcomp
	-1          "Not in universe"
	1           "Less than 1st grade"
	2           "1st, 2nd, 3rd, or 4th grade"
	3           "5th or 6th grade"
	4           "7th or 8th grade"
	5           "9th grade"
	6           "10th grade"
	7           "11th grade"
	8           "12th grade (no diploma)"
;
label values pecyc    pecyc;
label define pecyc
	-1          "Not in universe"
	1           "Less than 1 year (includes 0 years completed)"
	2           "The first or Freshman year"
	3           "The second or Sophomore year"
	4           "The third or Junior year"
	5           "Four or more years"
;
label values pegrprof pegrprof;
label define pegrprof
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pegr6cor pegr6cor;
label define pegr6cor
	-1          "Not in universe"
	1           "Yes"
	2           "No"
;
label values pems123  pems123l;
label define pems123l
	-1          "Not in universe"
	1           "1 year program"
	2           "2 year program"
	3           "3 year program"
;
label values primind1 priminda;
label define priminda
	1           "AGRICULTURE, FORESTRY, FISHING, and HUNTING"
	2           "MINING"
	3           "CONSTRUCTION"
	4           "MANUFACTURING - DURABLE GOODS"
	5           "MANUFACTURING - NON-DURABLE GOODS"
	6           "WHOLESALE TRADE"
	7           "RETAIL TRADE"
	8           "TRANSPORTATION AND WAREHOUSING"
	9           "UTILITIES"
	10          "INFORMATION"
	11          "FINANCE AND INSURANCE"
	12          "REAL ESTATE AND RENTAL AND LEASING"
	13          "PROFESSIONAL AND TECHNICAL SERVICES"
	14          "MANAGEMENT, ADMINISTRATIVE AND WASTE"
	15          "EDUCATIONAL SERVICES"
	16          "HEALTH CARE AND SOCIAL SERVICES"
	17          "ARTS, ENTERTAINMENT, AND RECREATION"
	18          "ACCOMMODATION AND FOOD SERVICES"
	19          "PRIVATE HOUSEHOLDS"
	20          "OTHER SERVICES, EXCEPT PRIVATE HOUSEHOLDS"
	21          "PUBLIC ADMINISTRATION"
	22          "ARMED FORCES"
;
label values primind2 primindb;
label define primindb
	1           "AGRICULTURE, FORESTRY, FISHING, and HUNTING"
	2           "MINING"
	3           "CONSTRUCTION"
	4           "MANUFACTURING - DURABLE GOODS"
	5           "MANUFACTURING - NON-DURABLE GOODS"
	6           "WHOLESALE TRADE"
	7           "RETAIL TRADE"
	8           "TRANSPORTATION AND WAREHOUSING"
	9           "UTILITIES"
	10          "INFORMATION"
	11          "FINANCE AND INSURANCE"
	12          "REAL ESTATE AND RENTAL AND LEASING"
	13          "PROFESSIONAL AND TECHNICAL SERVICES"
	14          "MANAGEMENT, ADMINISTRATIVE AND WASTE"
	15          "EDUCATIONAL SERVICES"
	16          "HEALTH CARE AND SOCIAL SERVICES"
	17          "ARTS, ENTERTAINMENT, AND RECREATION"
	18          "ACCOMMODATION AND FOOD SERVICES"
	19          "PRIVATE HOUSEHOLDS"
	20          "OTHER SERVICES, EXCEPT PRIVATE HOUSEHOLDS"
	21          "PUBLIC ADMINISTRATION"
	22          "ARMED FORCES"
;
label values peafwhn1 peafwhna;
label define peafwhna
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn2 peafwhnb;
label define peafwhnb
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn3 peafwhnc;
label define peafwhnc
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn4 peafwhnd;
label define peafwhnd
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;

#delimit cr

outsheet `variables' using `out_file', comma replace
log close

/*
Copyright 2007 shared by the National Bureau of Economic Research and Jean Roth

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
